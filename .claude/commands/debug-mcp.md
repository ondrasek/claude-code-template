# Debug MCP Server Command

Help me debug and troubleshoot an MCP (Model Context Protocol) server:

## Debugging Steps

1. **Check Server Configuration**
   - Verify the server command and arguments
   - Check environment variables
   - Validate JSON configuration syntax

2. **Test Server Connection**
   - Try connecting with MCP Client CLI
   - Check server logs for errors
   - Verify server is listening on correct transport

3. **Inspect Protocol Messages**
   - Enable debug logging with DEBUG=mcp:*
   - Monitor request/response flow
   - Check for protocol version mismatches

4. **Common Issues**
   - Missing dependencies
   - Permission errors
   - Port conflicts
   - Invalid server responses

5. **Testing Tools**
   - Use mcp-inspector for interactive debugging
   - Test with stdio-client for stdio servers
   - Monitor with MCP DevTools

## What to Check

- Server startup logs
- Error messages
- Request/response payloads
- Environment configuration
- Network connectivity (for HTTP/WebSocket servers)

Please provide:
1. The server configuration
2. Any error messages
3. What you're trying to accomplish
4. Steps you've already tried