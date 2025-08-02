"""Enhanced logging utilities for Perplexity MCP server with extensive debug capabilities."""

import logging
import os
import json
import time
from datetime import datetime
from pathlib import Path
from typing import Optional, Dict, Any
from functools import wraps


def setup_logging(
    log_level: str = "INFO",
    log_file: Optional[str] = None,
    logger_name: str = "perplexity_mcp"
) -> logging.Logger:
    """
    Set up enhanced logging configuration for the MCP server with configurable paths.
    
    Environment Variables:
        PERPLEXITY_LOG_PATH: Base directory for all log files (default: ./logs)
        PERPLEXITY_LOG_LEVEL: Logging level (default: INFO)
        PERPLEXITY_LOG_FILE: Main log file name (default: perplexity_mcp.log)
        PERPLEXITY_DEBUG_LOG_FILE: Debug log file name (default: perplexity_debug.log)
        PERPLEXITY_API_LOG_FILE: API request/response log file (default: perplexity_api.log)
        PERPLEXITY_ERROR_LOG_FILE: Error log file name (default: perplexity_errors.log)
    
    Args:
        log_level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        log_file: Optional file path for logging output (overrides env var)
        logger_name: Name of the logger
        
    Returns:
        Configured logger instance
    """
    logger = logging.getLogger(logger_name)
    logger.setLevel(getattr(logging, log_level.upper()))
    
    # Clear any existing handlers
    logger.handlers.clear()
    
    # Get log directory from environment variable
    log_path = os.getenv("PERPLEXITY_LOG_PATH", "./logs")
    
    # Ensure log directory exists
    Path(log_path).mkdir(parents=True, exist_ok=True)
    
    # Create enhanced formatter with more context
    detailed_formatter = logging.Formatter(
        fmt='%(asctime)s.%(msecs)03d - %(name)s - %(levelname)s - %(funcName)s:%(lineno)d - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    simple_formatter = logging.Formatter(
        fmt='%(asctime)s - %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    # Console handler (simplified for stdio)
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(simple_formatter)
    console_handler.setLevel(logging.INFO)  # Keep console less verbose
    logger.addHandler(console_handler)
    
    # Main log file
    main_log_file = log_file or os.path.join(log_path, os.getenv("PERPLEXITY_LOG_FILE", "perplexity_mcp.log"))
    try:
        main_handler = logging.FileHandler(main_log_file)
        main_handler.setFormatter(detailed_formatter)
        main_handler.setLevel(logging.INFO)
        logger.addHandler(main_handler)
        logger.info(f"Main logging to: {main_log_file}")
    except (OSError, IOError) as e:
        logger.warning(f"Could not create main log handler for {main_log_file}: {e}")
    
    # Debug log file (for verbose debugging)
    debug_log_file = os.path.join(log_path, os.getenv("PERPLEXITY_DEBUG_LOG_FILE", "perplexity_debug.log"))
    try:
        debug_handler = logging.FileHandler(debug_log_file)
        debug_handler.setFormatter(detailed_formatter)
        debug_handler.setLevel(logging.DEBUG)
        logger.addHandler(debug_handler)
        logger.debug(f"Debug logging to: {debug_log_file}")
    except (OSError, IOError) as e:
        logger.warning(f"Could not create debug log handler for {debug_log_file}: {e}")
    
    # Error log file (errors and exceptions only)
    error_log_file = os.path.join(log_path, os.getenv("PERPLEXITY_ERROR_LOG_FILE", "perplexity_errors.log"))
    try:
        error_handler = logging.FileHandler(error_log_file)
        error_handler.setFormatter(detailed_formatter)
        error_handler.setLevel(logging.ERROR)
        logger.addHandler(error_handler)
        logger.debug(f"Error logging to: {error_log_file}")
    except (OSError, IOError) as e:
        logger.warning(f"Could not create error log handler for {error_log_file}: {e}")
    
    # Initialize API logging
    setup_api_logging(log_path)
    
    return logger


def setup_api_logging(log_path: str) -> logging.Logger:
    """
    Set up dedicated API request/response logging.
    
    Args:
        log_path: Base directory for log files
        
    Returns:
        API logger instance
    """
    api_logger = logging.getLogger("perplexity_api")
    api_logger.setLevel(logging.DEBUG)
    
    # Clear any existing handlers
    api_logger.handlers.clear()
    
    # API log file (structured JSON logging for API calls)
    api_log_file = os.path.join(log_path, os.getenv("PERPLEXITY_API_LOG_FILE", "perplexity_api.log"))
    try:
        api_handler = logging.FileHandler(api_log_file)
        api_formatter = logging.Formatter(
            fmt='%(asctime)s.%(msecs)03d - %(levelname)s - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        api_handler.setFormatter(api_formatter)
        api_logger.addHandler(api_handler)
        api_logger.debug(f"API logging to: {api_log_file}")
    except (OSError, IOError) as e:
        main_logger = logging.getLogger("perplexity_mcp")
        main_logger.warning(f"Could not create API log handler for {api_log_file}: {e}")
    
    return api_logger


def get_logger(name: str = "perplexity_mcp") -> logging.Logger:
    """Get or create a logger instance."""
    return logging.getLogger(name)


def get_api_logger() -> logging.Logger:
    """Get the dedicated API logger instance."""
    return logging.getLogger("perplexity_api")


def log_api_request(method: str, url: str, headers: Dict[str, Any], data: Dict[str, Any]) -> str:
    """
    Log API request details in structured format.
    
    Args:
        method: HTTP method
        url: Request URL
        headers: Request headers (sensitive data will be redacted)
        data: Request payload
        
    Returns:
        Request ID for correlation
    """
    api_logger = get_api_logger()
    request_id = f"req_{int(time.time() * 1000)}_{id(data) % 10000}"
    
    # Redact sensitive information
    safe_headers = {k: "[REDACTED]" if "authorization" in k.lower() or "key" in k.lower() else v 
                    for k, v in headers.items()}
    
    safe_data = data.copy()
    if "messages" in safe_data and isinstance(safe_data["messages"], list):
        # Log message count and lengths instead of full content for privacy
        safe_data["messages_info"] = {
            "count": len(safe_data["messages"]),
            "lengths": [len(str(msg.get("content", ""))) for msg in safe_data["messages"]]
        }
        safe_data["messages"] = "[CONTENT_REDACTED_FOR_PRIVACY]"
    
    request_log = {
        "request_id": request_id,
        "timestamp": datetime.now().isoformat(),
        "type": "request",
        "method": method,
        "url": url,
        "headers": safe_headers,
        "data": safe_data
    }
    
    api_logger.debug(f"API_REQUEST: {json.dumps(request_log, indent=2)}")
    return request_id


def log_api_response(request_id: str, status_code: int, response_data: Dict[str, Any], 
                    duration_ms: float, error: Optional[str] = None) -> None:
    """
    Log API response details in structured format.
    
    Args:
        request_id: Correlation ID from request
        status_code: HTTP status code
        response_data: Response payload
        duration_ms: Request duration in milliseconds
        error: Optional error message
    """
    api_logger = get_api_logger()
    
    safe_response = response_data.copy() if response_data else {}
    
    # Redact potentially large content but keep metadata
    if "choices" in safe_response and isinstance(safe_response["choices"], list):
        safe_response["choices_info"] = {
            "count": len(safe_response["choices"]),
            "content_lengths": [len(str(choice.get("message", {}).get("content", ""))) 
                               for choice in safe_response["choices"]]
        }
        safe_response["choices"] = "[CONTENT_REDACTED_FOR_SIZE]"
    
    response_log = {
        "request_id": request_id,
        "timestamp": datetime.now().isoformat(),
        "type": "response",
        "status_code": status_code,
        "duration_ms": duration_ms,
        "response": safe_response,
        "error": error,
        "success": status_code < 400 and error is None
    }
    
    api_logger.debug(f"API_RESPONSE: {json.dumps(response_log, indent=2)}")


def debug_decorator(func):
    """
    Decorator to add extensive debug logging to functions.
    
    Args:
        func: Function to wrap with debug logging
        
    Returns:
        Wrapped function with debug logging
    """
    @wraps(func)
    async def async_wrapper(*args, **kwargs):
        logger = get_logger()
        func_name = f"{func.__module__}.{func.__name__}"
        
        # Log function entry
        logger.debug(f"ENTER {func_name} with args={len(args)}, kwargs={list(kwargs.keys())}")
        
        start_time = time.time()
        try:
            result = await func(*args, **kwargs)
            duration = (time.time() - start_time) * 1000
            logger.debug(f"EXIT {func_name} - SUCCESS - duration={duration:.2f}ms")
            return result
        except Exception as e:
            duration = (time.time() - start_time) * 1000
            logger.debug(f"EXIT {func_name} - ERROR - duration={duration:.2f}ms - error={type(e).__name__}: {str(e)}")
            raise
    
    @wraps(func)
    def sync_wrapper(*args, **kwargs):
        logger = get_logger()
        func_name = f"{func.__module__}.{func.__name__}"
        
        # Log function entry
        logger.debug(f"ENTER {func_name} with args={len(args)}, kwargs={list(kwargs.keys())}")
        
        start_time = time.time()
        try:
            result = func(*args, **kwargs)
            duration = (time.time() - start_time) * 1000
            logger.debug(f"EXIT {func_name} - SUCCESS - duration={duration:.2f}ms")
            return result
        except Exception as e:
            duration = (time.time() - start_time) * 1000
            logger.debug(f"EXIT {func_name} - ERROR - duration={duration:.2f}ms - error={type(e).__name__}: {str(e)}")
            raise
    
    # Return appropriate wrapper based on whether function is async
    import asyncio
    if asyncio.iscoroutinefunction(func):
        return async_wrapper
    else:
        return sync_wrapper