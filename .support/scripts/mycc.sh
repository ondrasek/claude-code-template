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
    - Advanced logging with timestamped files in .logs/
    - MCP server debugging support
    - Log analysis using Claude Code agents

EOF
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

# Function to analyze logs using Claude Code agents
analyze_logs() {
    echo "🔍 Analyzing logs using Claude Code agents..."
    
    # Find log files
    if [[ -d ".logs" ]]; then
        local log_files=($(find .logs -name "*.log" -type f | head -5))
        if [[ ${#log_files[@]} -eq 0 ]]; then
            echo "❌ No log files found in .logs directory"
            exit 1
        fi
        
        echo "📊 Found ${#log_files[@]} log files for analysis"
        
        # Use Claude Code with researcher and patterns agents to analyze logs
        claude --model "$DEFAULT_MODEL" "Use the researcher and patterns agents to analyze these log files: ${log_files[*]}. Look for performance issues, error patterns, and optimization opportunities. Provide actionable insights."
    else
        echo "❌ No .logs directory found. Run mycc with --save-logs first to generate logs."
        exit 1
    fi
}

# Setup logging if requested
setup_logging() {
    if [[ "$SAVE_LOGS" == "true" ]]; then
        if [[ -z "$LOG_FILE" ]]; then
            # Create timestamped log file
            mkdir -p .logs
            LOG_FILE=".logs/mycc-$(date +%Y%m%d-%H%M%S).log"
        fi
        echo "📝 Saving logs to: $LOG_FILE"
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
            ARGS[0]="$master_content\n\n${ARGS[0]}"
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
    
    # Execute Claude with logging if requested
    if [[ "$SAVE_LOGS" == "true" ]]; then
        {
            echo "=== mycc session started at $(date) ==="
            echo "Command: ${claude_cmd[*]}"
            echo "Model: $DEFAULT_MODEL"
            echo "Verbose: $VERBOSE_MODE"
            echo "Debug: $DEBUG_MODE"
            echo "MCP Debug: $MCP_DEBUG"
            echo "=========================="
            echo
        } >> "$LOG_FILE"
        
        "${claude_cmd[@]}" 2>&1 | tee -a "$LOG_FILE"
    else
        "${claude_cmd[@]}"
    fi
}

# Run main function
main