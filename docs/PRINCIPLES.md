# Software Development Principles

This document captures the core principles and patterns observed in this codebase. It is maintained by the patterns and principles agents to document architectural decisions, design patterns, and guiding principles.

## Core Principles

### 1. Simplicity First
- Prefer simple solutions over complex ones
- YAGNI (You Aren't Gonna Need It) - don't build for hypothetical futures
- Optimize for readability and maintainability

### 2. Documentation as Code
- Documentation lives alongside code
- Keep docs in sync with implementation
- Prefer updating existing docs over creating new ones

### 3. Fail Fast, Fail Clearly
- Validate inputs early
- Provide clear error messages
- Make invalid states unrepresentable

### 4. Composition Over Inheritance
- Small, focused modules
- Clear interfaces
- Dependency injection for flexibility

## Design Patterns Observed

### Current Patterns
<!-- This section is updated by the patterns agent -->
- Pattern: [Name]
  - Where: [Files/modules using this pattern]
  - Why: [Benefits in this context]

## Architecture Decisions

### Decision Log
<!-- Updated when significant architectural choices are made -->
- Decision: [What was decided]
  - Context: [Why this decision was needed]
  - Options Considered: [Alternatives evaluated]
  - Choice: [What was chosen and why]
  - Trade-offs: [What we gained/lost]

## Code Quality Standards

### Enforced Principles
- Single Responsibility Principle
- Open/Closed Principle
- Liskov Substitution Principle
- Interface Segregation Principle
- Dependency Inversion Principle

### Anti-Patterns to Avoid
- God objects/functions
- Circular dependencies
- Magic numbers/strings
- Copy-paste programming
- Premature optimization

## Evolution Guidelines

### When to Update This Document
- New patterns emerge across multiple files
- Architectural decisions are made
- Principles are violated and need clarification
- Team agrees on new standards

### How to Update
- Use patterns agent to identify emerging patterns
- Use principles agent to validate against SOLID/DRY/KISS
- Document the WHY, not just the WHAT
- Include concrete examples from the codebase

---
*This document is actively maintained by the patterns and principles agents*