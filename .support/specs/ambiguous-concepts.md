There are several ambiguous concepts in this repository and the ambiguity hinders productivity.

1. ~~.support/todos and related agents and commands sometimes conflict with the internal TodoWrite tool, which is used to manage internal todo list. Two different concepts with similar naming.~~ **RESOLVED**: Renamed to `.support/specs/` and `specs-analyst` agent to eliminate namespace collision.
2. We have several commands that refer to agents. This is fine as long as this configuration template is not used with codebase that contains actual agents. How will we differentiate between configured Claude Code sub-agents and the agents implemented in the codebase to avoid confusion?
