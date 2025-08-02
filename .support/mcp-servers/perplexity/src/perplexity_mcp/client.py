"""Perplexity API client implementation."""

import httpx
import os
from typing import Dict, Any, List, Optional
from functools import wraps
import asyncio

from .utils.logging import get_logger

logger = get_logger(__name__)


def handle_api_errors(func):
    """Decorator for handling Perplexity API errors consistently."""
    @wraps(func)
    async def wrapper(*args, **kwargs):
        try:
            return await func(*args, **kwargs)
        except httpx.HTTPStatusError as e:
            if e.response.status_code == 429:
                logger.warning("Rate limit exceeded")
                return {"error": "Rate limit exceeded. Please try again later."}
            elif e.response.status_code == 401:
                logger.error("Authentication failed")
                return {"error": "Authentication failed. Check your API key."}
            elif e.response.status_code == 400:
                logger.error(f"Bad request: {e.response.text}")
                return {"error": f"Bad request: {e.response.text}"}
            else:
                logger.error(f"API error ({e.response.status_code}): {e.response.text}")
                return {"error": f"API error ({e.response.status_code}): {e.response.text}"}
        except httpx.RequestError as e:
            logger.error(f"Network error: {str(e)}")
            return {"error": f"Network error: {str(e)}"}
        except Exception as e:
            logger.exception("Unexpected error in API call")
            return {"error": f"Unexpected error: {str(e)}"}
    return wrapper


class PerplexityClient:
    """Client for interacting with the Perplexity API."""
    
    AVAILABLE_MODELS = [
        "sonar",
        "sonar-pro", 
        "sonar-reasoning",
        "sonar-deep-research"
    ]
    
    def __init__(self, api_key: Optional[str] = None):
        """
        Initialize Perplexity client.
        
        Args:
            api_key: Perplexity API key. If not provided, will try to load from environment.
        """
        self.api_key = api_key or os.getenv("PERPLEXITY_API_KEY")
        if not self.api_key:
            raise ValueError("PERPLEXITY_API_KEY environment variable is required")
            
        self.base_url = "https://api.perplexity.ai/chat/completions"
        self.timeout = 60.0  # Default timeout for requests
        
        logger.info("Perplexity client initialized")
    
    @handle_api_errors
    async def query(
        self,
        prompt: str,
        model: str = "sonar",
        system_message: Optional[str] = None,
        max_tokens: int = 1000,
        temperature: float = 0.7,
        top_p: float = 1.0,
        return_citations: bool = True,
        return_images: bool = False,
        return_related_questions: bool = False,
        search_domain_filter: Optional[List[str]] = None,
        search_recency_filter: Optional[str] = None
    ) -> Dict[str, Any]:
        """
        Query the Perplexity API.
        
        Args:
            prompt: The user query
            model: Model to use (sonar, sonar-pro, sonar-reasoning, sonar-deep-research)
            system_message: Optional system message to customize behavior
            max_tokens: Maximum tokens in response
            temperature: Sampling temperature (0.0 to 2.0)
            top_p: Nucleus sampling parameter
            return_citations: Whether to include citations
            return_images: Whether to include images in results
            return_related_questions: Whether to return related questions
            search_domain_filter: List of domains to search within
            search_recency_filter: Recency filter (e.g., "month", "week", "day")
            
        Returns:
            API response dictionary or error dictionary
        """
        if model not in self.AVAILABLE_MODELS:
            logger.warning(f"Unknown model '{model}', using 'sonar' instead")
            model = "sonar"
        
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        messages = []
        if system_message:
            messages.append({"role": "system", "content": system_message})
        messages.append({"role": "user", "content": prompt})
        
        data = {
            "model": model,
            "messages": messages,
            "max_tokens": max_tokens,
            "temperature": temperature,
            "top_p": top_p,
            "return_citations": return_citations,
            "return_images": return_images,
            "return_related_questions": return_related_questions
        }
        
        # Add optional search filters
        if search_domain_filter:
            data["search_domain_filter"] = search_domain_filter
        if search_recency_filter:
            data["search_recency_filter"] = search_recency_filter
        
        logger.debug(f"Making API request with model: {model}")
        
        async with httpx.AsyncClient(timeout=self.timeout) as client:
            response = await client.post(self.base_url, headers=headers, json=data)
            response.raise_for_status()
            result = response.json()
            
            logger.info(f"API request successful, tokens used: {result.get('usage', {}).get('total_tokens', 'unknown')}")
            return result
    
    @handle_api_errors
    async def research_topic(
        self,
        topic: str,
        focus_areas: Optional[List[str]] = None,
        time_filter: Optional[str] = None,
        domain_filter: Optional[List[str]] = None,
        max_tokens: int = 1500,
        temperature: float = 0.3
    ) -> Dict[str, Any]:
        """
        Conduct comprehensive research on a topic.
        
        Args:
            topic: Main research topic
            focus_areas: Specific aspects to focus on
            time_filter: Time period for search (e.g., "month", "week")
            domain_filter: Specific domains to search
            max_tokens: Maximum tokens for response
            temperature: Sampling temperature (0.0 to 2.0)
            
        Returns:
            Comprehensive research results
        """
        # Build comprehensive research prompt
        prompt = f"Conduct comprehensive research on: {topic}"
        
        if focus_areas:
            prompt += f"\n\nSpecific focus areas to address:\n" + "\n".join(f"- {area}" for area in focus_areas)
        
        if time_filter:
            prompt += f"\n\nFocus on information from the {time_filter}."
        
        system_message = """You are a research expert. Provide a comprehensive analysis that includes:
1. Key findings and current state of the topic
2. Multiple perspectives and viewpoints
3. Recent developments and trends
4. Practical implications and applications
5. Reliable sources and citations

Be thorough, balanced, and evidence-based. Structure your response clearly with appropriate headings."""
        
        return await self.query(
            prompt=prompt,
            model="sonar-deep-research",
            system_message=system_message,
            max_tokens=max_tokens,
            temperature=temperature,
            search_domain_filter=domain_filter,
            search_recency_filter=time_filter,
            return_citations=True,
            return_related_questions=True
        )
    
    async def health_check(self) -> bool:
        """
        Check if the API is accessible and credentials are valid.
        
        Returns:
            True if API is accessible, False otherwise
        """
        try:
            result = await self.query("Test query", max_tokens=10)
            return "error" not in result
        except Exception as e:
            logger.error(f"Health check failed: {e}")
            return False