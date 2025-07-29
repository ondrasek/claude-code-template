---
status: pending
type: fix
priority: medium
assignee: unassigned
created: 2025-07-29
---

# Improve launch-claude.sh interactive mode detection logic

## Description
The current implementation in launch-claude.sh incorrectly assumes no arguments means interactive mode, but arguments like --model, --log-file, --skip-permissions don't prevent interactive mode. Need proper detection that distinguishes between configuration arguments and actual query/command arguments.

## Problem Analysis
Current logic uses `${#ARGS[@]} -eq 0` which is flawed because:
- Configuration flags like `--model`, `--log-file`, `--skip-permissions` are treated as non-interactive
- These flags should be allowed in interactive mode as they configure the session
- Only actual query/command arguments should trigger non-interactive mode

## Acceptance Criteria
- [ ] Identify configuration-only arguments that don't prevent interactive mode
- [ ] Implement proper detection logic that separates config args from query args
- [ ] Ensure `--model`, `--log-file`, `--skip-permissions` work in interactive mode
- [ ] Test interactive mode detection with various argument combinations
- [ ] Update logic to only consider actual query/command content as non-interactive triggers
- [ ] Maintain backward compatibility with existing usage patterns

## Implementation Notes
- Review current argument parsing in launch-claude.sh
- Create whitelist of configuration arguments that don't affect interactive mode
- Implement logic to filter out config args when determining interactive vs non-interactive mode
- Consider using argument classification approach (config vs content)

## Files to Review
- `launch-claude.sh` - Current interactive mode detection logic
- Related shell scripts that might have similar patterns