"""FastMCP server implementation for Perplexity API integration."""

import os
from typing import List, Optional
from dotenv import load_dotenv

try:
    from fastmcp import FastMCP
except ImportError:
    raise ImportError("FastMCP library is required. Install with: uv add fastmcp")

from .client import PerplexityClient
from .utils.logging import setup_logging, get_logger

# Load environment variables
load_dotenv()

# Initialize logging
logger = setup_logging(
    log_level=os.getenv("PERPLEXITY_LOG_LEVEL", "INFO"),
    log_file=os.getenv("PERPLEXITY_LOG_FILE"),
    logger_name="perplexity_mcp"
)

# Create FastMCP server instance
mcp = FastMCP("Perplexity Research Server")

# Initialize Perplexity client
try:
    perplexity_client = PerplexityClient()
    logger.info("Perplexity MCP server initialized successfully")
except Exception as e:
    logger.error(f"Failed to initialize Perplexity client: {e}")
    raise


@mcp.tool(
    annotations={
        "title": "Research with Perplexity",
        "description": "Research any topic using Perplexity's real-time web search capabilities",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
async def perplexity_search(
    query: str,
    model: str = "sonar",
    system_prompt: Optional[str] = None,
    max_tokens: int = 1000,
    temperature: float = 0.7
) -> str:
    """
    Research a topic using Perplexity's real-time web search capabilities.
    
    Args:
        query: The research question or topic to investigate
        model: Perplexity model to use (sonar, sonar-pro, sonar-reasoning, sonar-deep-research)
        system_prompt: Optional custom system prompt to customize response style
        max_tokens: Maximum tokens in response (default: 1000)
        temperature: Sampling temperature between 0.0-2.0 (default: 0.7)
    
    Returns:
        Comprehensive research response with citations and sources
    """
    logger.info(f"Research request: {query[:100]}...")
    
    try:
        # Use provided system prompt or default
        system_message = system_prompt or os.getenv(
            "PERPLEXITY_DEFAULT_SYSTEM", 
            "Provide a comprehensive research response with proper citations and sources."
        )
        
        # Use provided model or default
        selected_model = model if model in PerplexityClient.AVAILABLE_MODELS else os.getenv(
            "PERPLEXITY_DEFAULT_MODEL", "sonar"
        )
        
        result = await perplexity_client.query(
            prompt=query,
            model=selected_model,
            system_message=system_message,
            max_tokens=max_tokens,
            temperature=temperature,
            return_citations=True,
            return_related_questions=True
        )
        
        if "error" in result:
            logger.error(f"API error: {result['error']}")
            return f"Research failed: {result['error']}"
        
        # Extract response content
        content = result.get("choices", [{}])[0].get("message", {}).get("content", "No response generated")
        
        # Add related questions if available
        if result.get("related_questions"):
            content += "\n\n**Related Questions:**\n"
            for i, question in enumerate(result["related_questions"], 1):
                content += f"{i}. {question}\n"
        
        # Add usage information if available
        if result.get("usage"):
            usage = result["usage"]
            logger.info(f"Tokens used - Prompt: {usage.get('prompt_tokens', 0)}, "
                       f"Completion: {usage.get('completion_tokens', 0)}, "
                       f"Total: {usage.get('total_tokens', 0)}")
        
        return content
        
    except Exception as e:
        error_msg = f"Error during research: {str(e)}"
        logger.error(error_msg)
        return error_msg


@mcp.tool(
    annotations={
        "title": "Deep Research Analysis",
        "description": "Conduct comprehensive multi-perspective research on complex topics",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
async def perplexity_deep_research(
    topic: str,
    focus_areas: Optional[List[str]] = None,
    time_filter: Optional[str] = None,
    domain_filter: Optional[List[str]] = None,
    max_tokens: int = 1500
) -> str:
    """
    Conduct comprehensive research on a topic with multiple perspectives and deep analysis.
    
    Args:
        topic: Main research topic to investigate
        focus_areas: Specific aspects or subtopics to focus on (e.g., ["technical challenges", "market impact"])
        time_filter: Time period for search results (e.g., "month", "week", "day")
        domain_filter: Specific domains to search within (e.g., ["github.com", "stackoverflow.com"])
        max_tokens: Maximum tokens in response (default: 1500)
    
    Returns:
        Detailed research report with multiple perspectives, recent developments, and practical implications
    """
    logger.info(f"Deep research request: {topic}")
    
    try:
        result = await perplexity_client.research_topic(
            topic=topic,
            focus_areas=focus_areas,
            time_filter=time_filter,
            domain_filter=domain_filter,
            max_tokens=max_tokens
        )
        
        if "error" in result:
            logger.error(f"Deep research API error: {result['error']}")
            return f"Deep research failed: {result['error']}"
        
        # Extract and format response
        content = result.get("choices", [{}])[0].get("message", {}).get("content", "No response generated")
        
        # Add citations if available
        if result.get("citations"):
            content += "\n\n**Sources:**\n"
            for i, citation in enumerate(result["citations"], 1):
                content += f"{i}. {citation}\n"
        
        # Add related questions if available
        if result.get("related_questions"):
            content += "\n\n**Related Research Questions:**\n"
            for i, question in enumerate(result["related_questions"], 1):
                content += f"{i}. {question}\n"
        
        return content
        
    except Exception as e:
        error_msg = f"Error during deep research: {str(e)}"
        logger.error(error_msg)
        return error_msg


@mcp.tool(
    annotations={
        "title": "Quick Question",
        "description": "Ask a quick question with fast, concise response",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
async def perplexity_quick_query(
    question: str,
    domain_filter: Optional[List[str]] = None,
    recency_filter: Optional[str] = None
) -> str:
    """
    Ask a quick question and get a fast, concise response.
    
    Args:
        question: The question to ask
        domain_filter: Specific domains to search within (e.g., ["github.com", "docs.python.org"])
        recency_filter: How recent results should be (e.g., "month", "week", "day")
    
    Returns:
        Concise answer with key information and sources
    """
    logger.info(f"Quick query: {question[:100]}...")
    
    try:
        result = await perplexity_client.query(
            prompt=question,
            model="sonar",  # Fast model for quick queries
            system_message="Provide a concise, direct answer with key facts. Be brief but comprehensive.",
            max_tokens=500,
            temperature=0.3,  # Lower temperature for more factual responses
            search_domain_filter=domain_filter,
            search_recency_filter=recency_filter,
            return_citations=True
        )
        
        if "error" in result:
            logger.error(f"Quick query API error: {result['error']}")
            return f"Query failed: {result['error']}"
        
        content = result.get("choices", [{}])[0].get("message", {}).get("content", "No response generated")
        return content
        
    except Exception as e:
        error_msg = f"Error during quick query: {str(e)}"
        logger.error(error_msg)
        return error_msg


@mcp.tool(
    annotations={
        "title": "List Available Models",
        "description": "Get list of available Perplexity models and their descriptions",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
async def list_models() -> str:
    """
    List all available Perplexity models and their descriptions.
    
    Returns:
        Formatted list of available models with descriptions
    """
    models_info = {
        "sonar": "Fast, general-purpose model for most queries. Good balance of speed and quality.",
        "sonar-pro": "Enhanced version with better reasoning capabilities for complex queries.",
        "sonar-reasoning": "Optimized for logical reasoning and step-by-step analysis.",
        "sonar-deep-research": "Most comprehensive model for in-depth research and analysis. Slower but highest quality."
    }
    
    result = "**Available Perplexity Models:**\n\n"
    for model, description in models_info.items():
        result += f"• **{model}**: {description}\n\n"
    
    result += "\n**Usage Tips:**\n"
    result += "• Use 'sonar' for general questions and fast responses\n"
    result += "• Use 'sonar-deep-research' for comprehensive research\n"
    result += "• Use 'sonar-reasoning' for complex problem-solving\n"
    result += "• Use 'sonar-pro' for enhanced analysis needs\n"
    
    return result


@mcp.tool(
    annotations={
        "title": "Health Check",
        "description": "Check if Perplexity API is accessible and working",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
async def health_check() -> str:
    """
    Check the health status of the Perplexity API connection.
    
    Returns:
        Status message indicating if the API is accessible
    """
    logger.info("Performing health check")
    
    try:
        is_healthy = await perplexity_client.health_check()
        
        if is_healthy:
            return "✅ Perplexity API is accessible and working correctly."
        else:
            return "❌ Perplexity API is not responding correctly. Check your API key and network connection."
            
    except Exception as e:
        error_msg = f"❌ Health check failed: {str(e)}"
        logger.error(error_msg)
        return error_msg


# Entry point for stdio transport
def main():
    """Main entry point for the MCP server."""
    logger.info("Starting Perplexity MCP server...")
    try:
        mcp.run()  # Defaults to stdio transport
    except KeyboardInterrupt:
        logger.info("Server stopped by user")
    except Exception as e:
        logger.error(f"Server error: {e}")
        raise


if __name__ == "__main__":
    main()