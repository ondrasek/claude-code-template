#!/bin/bash

# mycc - Enhanced Claude Code alias with custom configuration
# Usage: mycc [options] [query]
# 
# This script provides a custom wrapper around claude with:
# - Disabled verbose mode by default
# - Default model set to sonnet
# - Custom master prompt loading
# - Enhanced verbose logging capabilities
# - MCP server verbose logging

set -euo pipefail

# Configuration variables
DEFAULT_MODEL="sonnet"
MASTER_PROMPT_FILE=".claude.support/master-prompt.md"
VERBOSE_MODE="true"
DEBUG_MODE="true"
MCP_DEBUG="true"
LOG_FILE=""
SAVE_LOGS="true"

# Log directory configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_BASE_DIR="$PROJECT_ROOT/.support/logs/claude-code"
SESSION_LOG_DIR="$LOG_BASE_DIR/sessions"
MCP_LOG_DIR="$LOG_BASE_DIR/mcp"
TELEMETRY_LOG_DIR="$LOG_BASE_DIR/telemetry"
DEBUG_LOG_DIR="$LOG_BASE_DIR/debug"

# Help function
show_help() {
    cat << EOF
mycc - Enhanced Claude Code wrapper

USAGE:
    mycc [OPTIONS] [QUERY]

OPTIONS:
    -h, --help                Show this help message
    -q, --quiet              Disable verbose mode (overrides default enable)
    --no-debug               Disable debug mode (overrides default enable)
    --no-mcp-debug           Disable MCP server debug logging (overrides default enable)
    --no-logs                Disable log saving (overrides default enable)
    -m, --model MODEL        Set model (default: $DEFAULT_MODEL)
    --log-file FILE          Save logs to specified file (default: timestamped)
    --analyze-logs           Analyze existing log files using Claude Code agents

EXAMPLES:
    mycc "Review my code"
    mycc --quiet --no-logs "Simple query without logging"
    mycc --log-file custom.log "Session with custom log file"
    mycc --analyze-logs

FEATURES:
    - All logging enabled by default (verbose, debug, MCP debug, save logs)
    - Default model set to sonnet for optimal performance
    - Automatic master prompt loading from $MASTER_PROMPT_FILE
    - Comprehensive logging to .support/logs/claude-code/ directory
    - Organized log categories: sessions, mcp, telemetry, debug
    - MCP server debugging with telemetry support
    - Multi-agent log analysis using Claude Code agents

EOF
}

# Function to analyze logs using Claude Code agents
analyze_logs() {
    echo "🔍 Analyzing logs using Claude Code agents..."
    
    # Check if log directory exists
    if [[ -d "$LOG_BASE_DIR" ]]; then
        # Find log files from all categories
        local session_logs=($(find "$SESSION_LOG_DIR" -name "*.log" -type f 2>/dev/null | head -3))
        local mcp_logs=($(find "$MCP_LOG_DIR" -name "*.log" -type f 2>/dev/null | head -3))
        local debug_logs=($(find "$DEBUG_LOG_DIR" -name "*.log" -type f 2>/dev/null | head -3))
        local telemetry_logs=($(find "$TELEMETRY_LOG_DIR" -name "*.log" -type f 2>/dev/null | head -2))
        
        # Combine all log files
        local all_logs=("${session_logs[@]}" "${mcp_logs[@]}" "${debug_logs[@]}" "${telemetry_logs[@]}")
        
        if [[ ${#all_logs[@]} -eq 0 ]]; then
            echo "❌ No log files found in $LOG_BASE_DIR"
            echo "💡 Run mycc with logging enabled first to generate logs."
            exit 1
        fi
        
        echo "📊 Found log files for analysis:"
        echo "   📋 Session logs: ${#session_logs[@]}"
        echo "   🔌 MCP logs: ${#mcp_logs[@]}"
        echo "   🐛 Debug logs: ${#debug_logs[@]}"
        echo "   📊 Telemetry logs: ${#telemetry_logs[@]}"
        echo "   📁 Total files: ${#all_logs[@]}"
        
        # Use Claude Code with multiple agents to analyze logs comprehensively
        echo "🤖 Launching comprehensive log analysis with multiple agents..."
        claude --model "$DEFAULT_MODEL" "Use the researcher, patterns, and performance agents to analyze these log files comprehensively:

SESSION LOGS: ${session_logs[*]}
MCP LOGS: ${mcp_logs[*]}
DEBUG LOGS: ${debug_logs[*]}
TELEMETRY LOGS: ${telemetry_logs[*]}

Please analyze for:
1. Performance issues and bottlenecks
2. Error patterns and failure modes
3. MCP server communication issues
4. Optimization opportunities
5. Usage patterns and insights
6. Actionable recommendations for improvement

Provide a structured analysis with specific findings and actionable next steps."
        
    else
        echo "❌ No log directory found at $LOG_BASE_DIR"
        echo "💡 Run mycc with logging enabled first to generate logs."
        exit 1
    fi
}

# Parse command line arguments
ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -q|--quiet)
            VERBOSE_MODE="false"
            shift
            ;;
        --no-debug)
            DEBUG_MODE="false"
            shift
            ;;
        --no-mcp-debug)
            MCP_DEBUG="false"
            shift
            ;;
        --no-logs)
            SAVE_LOGS="false"
            shift
            ;;
        -m|--model)
            DEFAULT_MODEL="$2"
            shift 2
            ;;
        --log-file)
            LOG_FILE="$2"
            SAVE_LOGS="true"
            shift 2
            ;;
        --analyze-logs)
            analyze_logs
            exit 0
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done

# Setup comprehensive logging system
setup_logging() {
    if [[ "$SAVE_LOGS" == "true" ]]; then
        # Create all log directories
        mkdir -p "$SESSION_LOG_DIR" "$MCP_LOG_DIR" "$TELEMETRY_LOG_DIR" "$DEBUG_LOG_DIR"
        
        # Set up timestamped log files if not specified
        local timestamp
        timestamp=$(date +%Y%m%d-%H%M%S)
        
        if [[ -z "$LOG_FILE" ]]; then
            LOG_FILE="$SESSION_LOG_DIR/mycc-session-$timestamp.log"
        fi
        
        # Set up environment variables for comprehensive logging
        export CLAUDE_CODE_ENABLE_TELEMETRY=1
        export MCP_CLAUDE_DEBUG=true
        export MCP_LOG_LEVEL=debug
        export MCP_TIMEOUT=30000
        
        # Configure OpenTelemetry for console output to our logs
        export OTEL_LOGS_EXPORTER=console
        export OTEL_METRICS_EXPORTER=console
        export OTEL_METRIC_EXPORT_INTERVAL=10000
        export OTEL_LOGS_EXPORT_INTERVAL=5000
        
        # Create organized log files
        local session_log="$SESSION_LOG_DIR/session-$timestamp.log"
        local mcp_log="$MCP_LOG_DIR/mcp-$timestamp.log"
        local telemetry_log="$TELEMETRY_LOG_DIR/telemetry-$timestamp.log"
        local debug_log="$DEBUG_LOG_DIR/debug-$timestamp.log"
        
        # Store paths for later use
        export MYCC_SESSION_LOG="$session_log"
        export MYCC_MCP_LOG="$mcp_log"
        export MYCC_TELEMETRY_LOG="$telemetry_log"
        export MYCC_DEBUG_LOG="$debug_log"
        
        echo "📝 Comprehensive logging enabled:"
        echo "   📋 Session logs: $session_log"
        echo "   🔌 MCP logs: $mcp_log"
        echo "   📊 Telemetry logs: $telemetry_log"  
        echo "   🐛 Debug logs: $debug_log"
        echo "   📁 All logs in: $LOG_BASE_DIR"
    fi
}

# Load master prompt if exists
load_master_prompt() {
    if [[ -f "$MASTER_PROMPT_FILE" ]]; then
        echo "📋 Loading master prompt from $MASTER_PROMPT_FILE"
        local master_content
        master_content=$(cat "$MASTER_PROMPT_FILE")
        
        # Prepend master prompt to the query
        if [[ ${#ARGS[@]} -gt 0 ]]; then
            ARGS[0]="$master_content

${ARGS[0]}"
        else
            ARGS=("$master_content")
        fi
    fi
}

# Build Claude command with options
build_claude_command() {
    local cmd=("claude")
    
    # Set default model
    cmd+=(--model "$DEFAULT_MODEL")
    
    # Add verbose mode if enabled
    if [[ "$VERBOSE_MODE" == "true" ]]; then
        cmd+=(--verbose)
    fi
    
    # Add MCP debug if enabled
    if [[ "$MCP_DEBUG" == "true" ]]; then
        cmd+=(--mcp-debug)
    fi
    
    # Add debug environment variables if debug mode
    if [[ "$DEBUG_MODE" == "true" ]]; then
        export CLAUDE_DEBUG=1
        export MCP_LOG_LEVEL=debug
        export ANTHROPIC_DEBUG=1
    fi
    
    # Add user arguments
    cmd+=("${ARGS[@]}")
    
    echo "${cmd[@]}"
}

# Main execution
main() {
    echo "🚀 mycc - Enhanced Claude Code wrapper"
    echo "📦 Model: $DEFAULT_MODEL"
    
    setup_logging
    load_master_prompt
    
    local claude_cmd
    claude_cmd=($(build_claude_command))
    
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo "🔧 Debug mode enabled"
        echo "📝 Command: ${claude_cmd[*]}"
    fi
    
    # Execute Claude with comprehensive logging if requested
    if [[ "$SAVE_LOGS" == "true" ]]; then
        # Write session header to all relevant logs
        local session_header
        session_header="=== mycc session started at $(date) ===
Command: ${claude_cmd[*]}
Model: $DEFAULT_MODEL
Verbose: $VERBOSE_MODE
Debug: $DEBUG_MODE
MCP Debug: $MCP_DEBUG
Project: $PROJECT_ROOT
=========================="
        
        # Write headers to organized log files
        echo "$session_header" >> "$MYCC_SESSION_LOG"
        echo "$session_header" >> "$MYCC_DEBUG_LOG"
        
        # Execute Claude with comprehensive log redirection
        # Use process substitution to split logs appropriately
        "${claude_cmd[@]}" \
            > >(tee -a "$MYCC_SESSION_LOG" | tee -a "$LOG_FILE") \
            2> >(tee -a "$MYCC_DEBUG_LOG" "$MYCC_MCP_LOG" "$MYCC_TELEMETRY_LOG" >&2)
        
        # Write session footer
        local session_footer="=== mycc session ended at $(date) ==="
        echo "$session_footer" >> "$MYCC_SESSION_LOG"
        echo "$session_footer" >> "$MYCC_DEBUG_LOG"
        echo "$session_footer" >> "$LOG_FILE"
        
    else
        "${claude_cmd[@]}"
    fi
}

# Run main function
main