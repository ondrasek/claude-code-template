#!/bin/bash

# launch-claude - Enhanced Claude Code wrapper with custom configuration
# Usage: launch-claude [options] [query]
# 
# This script provides a custom wrapper around claude with:
# - Enhanced defaults with logging enabled
# - Default model set to sonnet
# - Custom master prompt loading
# - Enhanced verbose logging capabilities
# - MCP server verbose logging
# - Auto-detection of devcontainer/codespace environments

set -euo pipefail

# Configuration variables
DEFAULT_MODEL="sonnet"
MASTER_PROMPT_FILE=".support/prompts/master-prompt.md"
VERBOSE_MODE="true"
DEBUG_MODE="true"
MCP_DEBUG="true"
LOG_FILE=""
SAVE_LOGS="true"
SKIP_PERMISSIONS="false"

# Environment file configuration
ENV_FILES=(".env" ".env.local" ".env.development")
LOAD_ENV="true"

# Log directory configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_BASE_DIR="$PROJECT_ROOT/.support/logs/claude-code"
SESSION_LOG_DIR="$LOG_BASE_DIR/sessions"
MCP_LOG_DIR="$LOG_BASE_DIR/mcp"
TELEMETRY_LOG_DIR="$LOG_BASE_DIR/telemetry"
DEBUG_LOG_DIR="$LOG_BASE_DIR/debug"

# Auto-detect environment function
detect_environment() {
    # Check for devcontainer environment
    if [[ -n "${CODESPACES:-}" ]] || [[ -n "${REMOTE_CONTAINERS:-}" ]] || [[ -f "/.dockerenv" ]] || [[ -n "${DEVCONTAINER:-}" ]]; then
        echo "🔍 Detected devcontainer/codespace environment - enabling --dangerously-skip-permissions"
        SKIP_PERMISSIONS="true"
    fi
}

# Secure .env file validation and parsing functions
validate_env_file() {
    local env_file="$1"
    
    # Check if file exists and is readable
    if [[ ! -f "$env_file" ]]; then
        return 1
    fi
    
    # Check file permissions - should not be world-readable for security
    if [[ -r "$env_file" ]]; then
        local perms
        perms=$(stat -c "%a" "$env_file" 2>/dev/null || stat -f "%A" "$env_file" 2>/dev/null)
        if [[ "${perms: -1}" -gt 4 ]]; then
            echo "⚠️  Warning: $env_file is world-readable. Consider running: chmod 640 $env_file"
        fi
    fi
    
    # Check file size (prevent DoS via large files)
    local size
    size=$(wc -c < "$env_file" 2>/dev/null || echo 0)
    if [[ $size -gt 100000 ]]; then  # 100KB limit
        echo "❌ Error: $env_file is too large (${size} bytes). Maximum 100KB allowed."
        return 1
    fi
    
    return 0
}

# Parse and load environment variables from .env file
load_env_file() {
    local env_file="$1"
    local loaded_count=0
    
    if ! validate_env_file "$env_file"; then
        return 1
    fi
    
    echo "🔧 Loading environment variables from $env_file"
    
    # Process file line by line with security validation
    local line_num=0
    while IFS= read -r line || [[ -n "$line" ]]; do
        ((line_num++))
        
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        
        # Validate line format: KEY=VALUE
        if [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*=[[:space:]]*(.*)[[:space:]]*$ ]]; then
            local key="${BASH_REMATCH[1]}"
            local value="${BASH_REMATCH[2]}"
            
            # Security checks
            # 1. Prevent command injection in values
            if [[ "$value" =~ \$\(|\`|\;|\||\& ]]; then
                echo "⚠️  Warning: Skipping potentially dangerous value for $key at line $line_num"
                continue
            fi
            
            # 2. Don't override existing environment variables (user environment takes precedence)
            if [[ -z "${!key:-}" ]]; then
                export "$key=$value"
                ((loaded_count++))
                
                # Mask sensitive values in debug output
                if [[ "$DEBUG_MODE" == "true" ]]; then
                    if [[ "$key" =~ (API_KEY|TOKEN|SECRET|PASSWORD|PASS) ]]; then
                        echo "   $key=***masked***"
                    else
                        echo "   $key=$value"
                    fi
                fi
            elif [[ "$DEBUG_MODE" == "true" ]]; then
                echo "   Skipped $key (already set in environment)"
            fi
        else
            echo "⚠️  Warning: Invalid format at line $line_num in $env_file: $line"
        fi
    done < "$env_file"
    
    if [[ $loaded_count -gt 0 ]]; then
        echo "✅ Loaded $loaded_count environment variables from $env_file"
    fi
    
    return 0
}

# Load configuration from multiple .env files with precedence
load_configuration() {
    if [[ "$LOAD_ENV" != "true" ]]; then
        return 0
    fi
    
    local total_loaded=0
    local files_processed=0
    
    # Process .env files in order of precedence (.env.development overrides .env, etc.)
    for env_file in "${ENV_FILES[@]}"; do
        local full_path="$PROJECT_ROOT/$env_file"
        if [[ -f "$full_path" ]]; then
            if load_env_file "$full_path"; then
                ((files_processed++))
            fi
        fi
    done
    
    if [[ $files_processed -eq 0 ]]; then
        if [[ "$DEBUG_MODE" == "true" ]]; then
            echo "ℹ️  No .env files found. Using system environment variables."
        fi
    fi
}

# Help function
show_help() {
    cat << EOF
launch-claude - Enhanced Claude Code wrapper

USAGE:
    launch-claude [OPTIONS] [QUERY]

OPTIONS:
    -h, --help                Show this help message
    -q, --quiet              Disable verbose mode (overrides default enable)
    --no-debug               Disable debug mode (overrides default enable)
    --no-mcp-debug           Disable MCP server debug logging (overrides default enable)
    --no-logs                Disable log saving (overrides default enable)
    -m, --model MODEL        Set model (default: $DEFAULT_MODEL)
    --log-file FILE          Save logs to specified file (default: timestamped)
    --analyze-logs           Analyze existing log files using Claude Code agents
    --skip-permissions       Force enable --dangerously-skip-permissions flag
    --no-skip-permissions    Force disable --dangerously-skip-permissions flag
    --no-env                 Disable .env file loading
    --env-file FILE          Load specific .env file (can be used multiple times)

EXAMPLES:
    launch-claude "Review my code"
    launch-claude --quiet --no-logs "Simple query without logging"
    launch-claude --log-file custom.log "Session with custom log file"
    launch-claude --analyze-logs

FEATURES:
    - All logging enabled by default (verbose, debug, MCP debug, save logs)
    - Default model set to sonnet for optimal performance
    - Automatic MCP configuration loading from .mcp.json in project root
    - Automatic master prompt loading from $MASTER_PROMPT_FILE
    - Comprehensive logging to .support/logs/claude-code/ directory
    - Organized log categories: sessions, mcp, telemetry, debug
    - MCP server debugging with telemetry support
    - Multi-agent log analysis using Claude Code agents
    - Auto-detection of devcontainer/codespace environments for permissions
    - Secure .env file loading with validation and masking of sensitive values

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
            echo "💡 Run launch-claude with logging enabled first to generate logs."
            exit 1
        fi
        
        echo "📊 Found log files for analysis:"
        echo "   📋 Session logs: ${#session_logs[@]}"
        echo "   🔌 MCP logs: ${#mcp_logs[@]}"
        echo "   🐛 Debug logs: ${#debug_logs[@]}"
        echo "   📊 Telemetry logs: ${#telemetry_logs[@]}"
        echo "   📁 Total files: ${#all_logs[@]}"
        
        # Build analysis command with same permissions handling as main script
        local analysis_cmd=("claude" --model "$DEFAULT_MODEL")
        
        # Auto-detect environment for analysis command (same logic as detect_environment)
        if [[ -n "${CODESPACES:-}" ]] || [[ -n "${REMOTE_CONTAINERS:-}" ]] || [[ -f "/.dockerenv" ]] || [[ -n "${DEVCONTAINER:-}" ]] || [[ "$SKIP_PERMISSIONS" == "true" ]]; then
            analysis_cmd+=(--dangerously-skip-permissions)
        fi
        
        # Use Claude Code with multiple agents for comprehensive analysis including security
        echo "🤖 Launching comprehensive log analysis with multiple agents..."
        "${analysis_cmd[@]}" "Use the researcher, patterns, vulnerability-scanner, and threat-modeling agents to analyze these log files comprehensively:

SESSION LOGS: ${session_logs[*]}
MCP LOGS: ${mcp_logs[*]}
DEBUG LOGS: ${debug_logs[*]}
TELEMETRY LOGS: ${telemetry_logs[*]}

Please analyze for:
1. Error patterns and failure modes
2. MCP server communication issues
3. Security vulnerabilities and threats
4. Attack patterns or suspicious activity
5. Data exposure risks in logs
6. Configuration security issues
7. Usage patterns and insights
8. Actionable recommendations for improvement

Focus on Claude Code usage patterns, not performance analysis of the launch-claude.sh script itself.
Provide a structured analysis with specific findings and actionable next steps."
        
    else
        echo "❌ No log directory found at $LOG_BASE_DIR"
        echo "💡 Run launch-claude with logging enabled first to generate logs."
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
        --skip-permissions)
            SKIP_PERMISSIONS="true"
            shift
            ;;
        --no-skip-permissions)
            SKIP_PERMISSIONS="false"
            shift
            ;;
        --no-env)
            LOAD_ENV="false"
            shift
            ;;
        --env-file)
            if [[ -n "$2" ]]; then
                ENV_FILES=("$2")
                LOAD_ENV="true"
                shift 2
            else
                echo "❌ Error: --env-file requires a filename"
                exit 1
            fi
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
        
        # Disable OpenTelemetry exporters to avoid interfering with interactive mode
        export OTEL_LOGS_EXPORTER=""
        export OTEL_METRICS_EXPORTER=""
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

# Load master prompt if exists and has content
load_master_prompt() {
    MASTER_PROMPT_CONTENT=""
    
    if [[ -f "$MASTER_PROMPT_FILE" ]]; then
        local master_content
        master_content=$(cat "$MASTER_PROMPT_FILE")
        
        # Only use master prompt if it has non-whitespace content
        if [[ -n "${master_content// }" ]]; then
            echo "📋 Loading master prompt from $MASTER_PROMPT_FILE"
            MASTER_PROMPT_CONTENT="$master_content"
        elif [[ "$DEBUG_MODE" == "true" ]]; then
            echo "ℹ️  Master prompt file exists but is empty, skipping"
        fi
    elif [[ "$DEBUG_MODE" == "true" ]]; then
        echo "ℹ️  No master prompt file found at $MASTER_PROMPT_FILE"
    fi
}

# Build Claude command with options
build_claude_command() {
    local cmd=("claude")
    
    # Set default model
    cmd+=(--model "$DEFAULT_MODEL")
    
    # Add MCP configuration file if it exists in project root
    local mcp_config="$PROJECT_ROOT/.mcp.json"
    if [[ -f "$mcp_config" ]]; then
        cmd+=(--mcp-config "$mcp_config")
        if [[ "$DEBUG_MODE" == "true" ]]; then
            echo "🔌 Using MCP config: $mcp_config"
        fi
    fi
    
    # Add verbose mode if enabled
    if [[ "$VERBOSE_MODE" == "true" ]]; then
        cmd+=(--verbose)
    fi
    
    # Add MCP debug if enabled
    if [[ "$MCP_DEBUG" == "true" ]]; then
        cmd+=(--mcp-debug)
    fi
    
    # Add skip permissions if enabled (auto-detected or forced)
    if [[ "$SKIP_PERMISSIONS" == "true" ]]; then
        cmd+=(--dangerously-skip-permissions)
    fi
    
    # Add master prompt as system prompt only if it has meaningful content
    if [[ -n "$MASTER_PROMPT_CONTENT" ]]; then
        cmd+=(--append-system-prompt "$MASTER_PROMPT_CONTENT")
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
    echo "🚀 launch-claude - Enhanced Claude Code wrapper"
    echo "📦 Model: $DEFAULT_MODEL"
    
    # Disable verbose and MCP debug modes for interactive mode (no arguments)
    if [[ ${#ARGS[@]} -eq 0 ]]; then
        VERBOSE_MODE="false"
        MCP_DEBUG="false"
        echo "ℹ️  Interactive mode: verbose and MCP debug disabled"
    fi
    
    # Auto-detect environment before other setup
    detect_environment
    
    # Load configuration from .env files
    load_configuration
    
    setup_logging
    load_master_prompt
    
    local claude_cmd
    claude_cmd=($(build_claude_command))
    
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo "🔧 Debug mode enabled"
        echo "📝 Command: ${claude_cmd[*]}"
        echo
    fi
    
    # Execute Claude with comprehensive logging if requested
    if [[ "$SAVE_LOGS" == "true" ]]; then
        # Write session header to all relevant logs
        local session_header
        session_header="=== launch-claude session started at $(date) ===
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
        # For interactive mode, we need to preserve stdin/stdout/stderr properly
        if [[ ${#ARGS[@]} -eq 0 ]]; then
            # Interactive mode - use exec to preserve terminal properly
            exec "${claude_cmd[@]}" 2> >(tee -a "$MYCC_DEBUG_LOG" "$MYCC_MCP_LOG" "$MYCC_TELEMETRY_LOG" >&2)
        else
            "${claude_cmd[@]}" \
                > >(tee -a "$MYCC_SESSION_LOG" | tee -a "$LOG_FILE") \
                2> >(tee -a "$MYCC_DEBUG_LOG" "$MYCC_MCP_LOG" "$MYCC_TELEMETRY_LOG" >&2)
        fi
        
        # Write session footer
        local session_footer="=== launch-claude session ended at $(date) ==="
        echo "$session_footer" >> "$MYCC_SESSION_LOG"
        echo "$session_footer" >> "$MYCC_DEBUG_LOG"
        echo "$session_footer" >> "$LOG_FILE"
        
    else
        # For interactive mode without logging, preserve terminal properly
        if [[ ${#ARGS[@]} -eq 0 ]]; then
            exec "${claude_cmd[@]}"
        else
            "${claude_cmd[@]}"
        fi
    fi
}

# Run main function
main