#!/usr/bin/env python3
"""
Test script for enhanced logging functionality.
This script creates sample log entries to verify the logging system works correctly.
"""

import os
import sys
import asyncio
import tempfile
from pathlib import Path

# Add the src directory to the path so we can import our modules
sys.path.insert(0, str(Path(__file__).parent / "src"))

from perplexity_mcp.utils.logging import setup_logging, get_logger, get_api_logger, log_api_request, log_api_response
from perplexity_mcp.client import PerplexityClient


async def test_logging_system():
    """Test the enhanced logging system."""
    print("🧪 Testing Enhanced Logging System...")
    
    # Create a temporary directory for test logs
    with tempfile.TemporaryDirectory() as temp_dir:
        print(f"📁 Using temporary log directory: {temp_dir}")
        
        # Set environment variables for testing
        os.environ["PERPLEXITY_LOG_PATH"] = temp_dir
        os.environ["PERPLEXITY_LOG_LEVEL"] = "DEBUG"
        os.environ["PERPLEXITY_API_KEY"] = "test_key_for_logging_demo"  # Fake key for testing
        
        # Initialize logging
        logger = setup_logging(
            log_level="DEBUG",
            logger_name="test_perplexity"
        )
        
        print("✅ Logging system initialized")
        
        # Test different log levels
        logger.debug("🔍 This is a DEBUG message")
        logger.info("ℹ️ This is an INFO message")
        logger.warning("⚠️ This is a WARNING message")
        logger.error("❌ This is an ERROR message")
        
        # Test API logging
        api_logger = get_api_logger()
        
        # Simulate an API request
        headers = {"authorization": "Bearer test_key", "content-type": "application/json"}
        data = {"model": "sonar", "messages": [{"role": "user", "content": "Test query"}]}
        
        request_id = log_api_request("POST", "https://api.example.com", headers, data)
        print(f"📝 Logged API request with ID: {request_id}")
        
        # Simulate an API response
        response_data = {
            "choices": [{"message": {"content": "Test response"}}],
            "usage": {"total_tokens": 150}
        }
        log_api_response(request_id, 200, response_data, 1234.5)
        print("📝 Logged API response")
        
        # Test client initialization (this will fail due to fake API key, but will generate logs)
        try:
            client = PerplexityClient()
            print("✅ Client created (using fake key)")
        except Exception as e:
            print(f"⚠️ Expected error with fake API key: {type(e).__name__}")
        
        # Check log files were created
        log_files = list(Path(temp_dir).glob("*.log"))
        print(f"\n📋 Created log files:")
        
        for log_file in log_files:
            size = log_file.stat().st_size
            print(f"  📄 {log_file.name}: {size} bytes")
            
            # Show sample content from each log file
            if size > 0:
                with open(log_file, 'r') as f:
                    lines = f.readlines()
                    print(f"    📖 Sample content ({len(lines)} lines):")
                    for line in lines[:3]:  # Show first 3 lines
                        print(f"    │ {line.strip()}")
                    if len(lines) > 3:
                        print(f"    │ ... and {len(lines) - 3} more lines")
                print()
        
        # Verify expected log files exist
        expected_files = [
            "perplexity_mcp.log",
            "perplexity_debug.log", 
            "perplexity_api.log",
            "perplexity_errors.log"
        ]
        
        created_files = [f.name for f in log_files]
        
        print("✅ Log File Verification:")
        for expected in expected_files:
            if expected in created_files:
                print(f"  ✅ {expected} - Created successfully")
            else:
                print(f"  ❌ {expected} - Missing")
        
        print(f"\n🎉 Logging test completed! Check logs in: {temp_dir}")
        return temp_dir


if __name__ == "__main__":
    asyncio.run(test_logging_system())