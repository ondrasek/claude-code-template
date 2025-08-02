"""FastMCP server implementation for Perplexity API integration."""

import os
from typing import List, Optional
from dotenv import load_dotenv

try:
    from fastmcp import FastMCP
except ImportError:
    raise ImportError("FastMCP library is required. Install with: uv add fastmcp")

from .client import PerplexityClient
from .utils.logging import setup_logging, get_logger, debug_decorator

# Load environment variables
load_dotenv()

# Initialize logging with environment configuration
logger = setup_logging(
    log_level=os.getenv("PERPLEXITY_LOG_LEVEL", "INFO"),
    logger_name="perplexity_mcp"
)

# Log environment configuration
logger.info("Perplexity MCP server starting")
logger.debug(f"Environment variables:")
logger.debug(f"  PERPLEXITY_LOG_LEVEL: {os.getenv('PERPLEXITY_LOG_LEVEL', 'INFO')}")
logger.debug(f"  PERPLEXITY_LOG_PATH: {os.getenv('PERPLEXITY_LOG_PATH', './logs')}")
logger.debug(f"  PERPLEXITY_TIMEOUT: {os.getenv('PERPLEXITY_TIMEOUT', '60.0')}")
logger.debug(f"  PERPLEXITY_API_KEY: {'SET' if os.getenv('PERPLEXITY_API_KEY') else 'NOT_SET'}")

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
@debug_decorator
async def perplexity_search(
    query: str,
    model: str = "sonar",
    system_prompt: Optional[str] = None,
    max_tokens: int = 1000,
    temperature: float = 0.7,
    search_domain_filter: Optional[List[str]] = None,
    search_recency_filter: Optional[str] = None,
    top_p: float = 1.0,
    presence_penalty: float = 0.0,
    frequency_penalty: float = 0.0
) -> str:
    """
    Research a topic using Perplexity's real-time web search capabilities.
    
    Args:
        query: The research question or topic to investigate
        model: Perplexity model to use (sonar, sonar-pro, sonar-reasoning, sonar-deep-research)
        system_prompt: Optional custom system prompt to customize response style
        max_tokens: Maximum tokens in response (default: 1000)
        temperature: Sampling temperature between 0.0-2.0 (default: 0.7)
        search_domain_filter: List of domains to filter search results (e.g., ["github.com", "stackoverflow.com"])
        search_recency_filter: Time period filter for search results (e.g., "month", "week", "day")
        top_p: Nucleus sampling parameter (default: 1.0)
        presence_penalty: Penalty for token presence (default: 0.0)
        frequency_penalty: Penalty for token frequency (default: 0.0)
    
    Returns:
        Comprehensive research response with citations and sources
    """
    logger.info(f"Research request: {query[:100]}...")
    logger.debug(f"Full research parameters: query_length={len(query)}, model={model}, system_prompt_length={len(system_prompt) if system_prompt else 0}, max_tokens={max_tokens}, temperature={temperature}, search_domain_filter={search_domain_filter}, search_recency_filter={search_recency_filter}")
    
    try:
        # Use provided system prompt or default
        system_message = system_prompt or "Provide a comprehensive research response with proper citations and sources."
        
        # Use provided model or default
        selected_model = model if model in PerplexityClient.AVAILABLE_MODELS else "sonar"
        
        result = await perplexity_client.query(
            prompt=query,
            model=selected_model,
            system_message=system_message,
            max_tokens=max_tokens,
            temperature=temperature,
            top_p=top_p,
            presence_penalty=presence_penalty,
            frequency_penalty=frequency_penalty,
            search_domain_filter=search_domain_filter,
            search_recency_filter=search_recency_filter,
            return_citations=True,
            return_related_questions=True
        )
        
        if "error" in result:
            logger.error(f"API error: {result['error']}")
            logger.debug(f"Full error result: {result}")
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
            logger.debug(f"Full usage details: {usage}")
        
        logger.debug(f"Research completed successfully, content length: {len(content)}")
        return content
        
    except Exception as e:
        error_msg = f"Error during research: {str(e)}"
        logger.error(error_msg)
        logger.debug(f"Research exception details", exc_info=True)
        return error_msg


@mcp.tool(
    annotations={
        "title": "Deep Research Analysis",
        "description": "Conduct comprehensive research using the sonar-deep-research model",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
@debug_decorator
async def perplexity_deep_research(
    topic: str,
    search_domain_filter: Optional[List[str]] = None,
    search_recency_filter: Optional[str] = None,
    max_tokens: int = 1500,
    temperature: float = 0.3
) -> str:
    """
    Conduct deep research analysis on a topic using the sonar-deep-research model.
    
    Args:
        topic: Main research topic to investigate
        search_domain_filter: List of domains to filter search results (e.g., ["github.com", "stackoverflow.com"])
        search_recency_filter: Time period filter for search results (e.g., "month", "week", "day")
        max_tokens: Maximum tokens in response (default: 1500)
        temperature: Sampling temperature between 0.0-2.0 (default: 0.3)
    
    Returns:
        Detailed research report with comprehensive analysis and citations
    """
    logger.info(f"Deep research request: {topic}")
    logger.debug(f"Deep research parameters: topic_length={len(topic)}, search_domain_filter={search_domain_filter}, search_recency_filter={search_recency_filter}, max_tokens={max_tokens}, temperature={temperature}")
    
    try:
        # Build comprehensive research prompt
        system_message = """You are a research expert. Provide a comprehensive analysis that includes:
1. Key findings and current state of the topic
2. Multiple perspectives and viewpoints
3. Recent developments and trends
4. Practical implications and applications
5. Reliable sources and citations

Be thorough, balanced, and evidence-based. Structure your response clearly with appropriate headings."""
        
        result = await perplexity_client.query(
            prompt=f"Conduct comprehensive research on: {topic}",
            model="sonar-deep-research",
            system_message=system_message,
            max_tokens=max_tokens,
            temperature=temperature,
            search_domain_filter=search_domain_filter,
            search_recency_filter=search_recency_filter,
            return_citations=True,
            return_related_questions=True
        )
        
        if "error" in result:
            logger.error(f"Deep research API error: {result['error']}")
            logger.debug(f"Full deep research error result: {result}")
            return f"Deep research failed: {result['error']}"
        
        # Extract and format response
        content = result.get("choices", [{}])[0].get("message", {}).get("content", "No response generated")
        
        # Add related questions if available
        if result.get("related_questions"):
            content += "\n\n**Related Research Questions:**\n"
            for i, question in enumerate(result["related_questions"], 1):
                content += f"{i}. {question}\n"
        
        # Add usage information if available
        if result.get("usage"):
            usage = result["usage"]
            logger.info(f"Tokens used - Prompt: {usage.get('prompt_tokens', 0)}, "
                       f"Completion: {usage.get('completion_tokens', 0)}, "
                       f"Total: {usage.get('total_tokens', 0)}")
        
        logger.debug(f"Deep research completed successfully, content length: {len(content)}")
        return content
        
    except Exception as e:
        error_msg = f"Error during deep research: {str(e)}"
        logger.error(error_msg)
        logger.debug(f"Deep research exception details", exc_info=True)
        return error_msg


@mcp.tool(
    annotations={
        "title": "Quick Question",
        "description": "Ask a quick question with fast, concise response",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
@debug_decorator
async def perplexity_quick_query(
    question: str,
    search_domain_filter: Optional[List[str]] = None,
    search_recency_filter: Optional[str] = None,
    temperature: float = 0.3
) -> str:
    """
    Ask a quick question and get a fast, concise response.
    
    Args:
        question: The question to ask
        search_domain_filter: Specific domains to search within (e.g., ["github.com", "docs.python.org"])
        search_recency_filter: How recent results should be (e.g., "month", "week", "day")
        temperature: Sampling temperature between 0.0-2.0 (default: 0.3 for factual responses)
    
    Returns:
        Concise answer with key information and sources
    """
    logger.info(f"Quick query: {question[:100]}...")
    logger.debug(f"Quick query parameters: question_length={len(question)}, search_domain_filter={search_domain_filter}, search_recency_filter={search_recency_filter}, temperature={temperature}")
    
    try:
        result = await perplexity_client.query(
            prompt=question,
            model="sonar",  # Fast model for quick queries
            system_message="Provide a concise, direct answer with key facts. Be brief but comprehensive.",
            max_tokens=500,
            temperature=temperature,  # Use provided temperature parameter
            search_domain_filter=search_domain_filter,
            search_recency_filter=search_recency_filter,
            return_citations=True
        )
        
        if "error" in result:
            logger.error(f"Quick query API error: {result['error']}")
            logger.debug(f"Full quick query error result: {result}")
            return f"Query failed: {result['error']}"
        
        content = result.get("choices", [{}])[0].get("message", {}).get("content", "No response generated")
        logger.debug(f"Quick query completed successfully, content length: {len(content)}")
        return content
        
    except Exception as e:
        error_msg = f"Error during quick query: {str(e)}"
        logger.error(error_msg)
        logger.debug(f"Quick query exception details", exc_info=True)
        return error_msg


@mcp.tool(
    annotations={
        "title": "List Available Models",
        "description": "Get list of available Perplexity models and their descriptions",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
@debug_decorator
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
    
    logger.debug(f"Models list generated, length: {len(result)}")
    return result


@mcp.tool(
    annotations={
        "title": "Health Check",
        "description": "Check if Perplexity API is accessible and working",
        "readOnlyHint": True,
        "openWorldHint": False
    }
)
@debug_decorator
async def health_check() -> str:
    """
    Check the health status of the Perplexity API connection.
    
    Returns:
        Status message indicating if the API is accessible
    """
    logger.info("Performing health check")
    logger.debug("Starting comprehensive health check of Perplexity API connection")
    
    try:
        is_healthy = await perplexity_client.health_check()
        
        if is_healthy:
            logger.debug("Health check passed - API is responding correctly")
            return "✅ Perplexity API is accessible and working correctly."
        else:
            logger.debug("Health check failed - API is not responding correctly")
            return "❌ Perplexity API is not responding correctly. Check your API key and network connection."
            
    except Exception as e:
        error_msg = f"❌ Health check failed: {str(e)}"
        logger.error(error_msg)
        logger.debug(f"Health check exception details", exc_info=True)
        return error_msg


# Entry point for stdio transport
def main():
    """Main entry point for the MCP server with enhanced logging."""
    logger.info("Starting Perplexity MCP server...")
    logger.debug(f"Server configuration: FastMCP instance={type(mcp).__name__}")
    logger.debug(f"Available tools: {[tool for tool in dir(mcp) if not tool.startswith('_')]}")
    
    try:
        logger.debug("Starting FastMCP server with stdio transport")
        mcp.run()  # Defaults to stdio transport
    except KeyboardInterrupt:
        logger.info("Server stopped by user (KeyboardInterrupt)")
        logger.debug("Graceful shutdown initiated")
    except Exception as e:
        logger.error(f"Server error: {e}")
        logger.debug(f"Server exception details", exc_info=True)
        raise
    finally:
        logger.debug("Server shutdown complete")


if __name__ == "__main__":
    main()