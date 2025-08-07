# Claude Prompt Engineering Guidelines
## Optimized AI Instructions for Claude Models

> **Purpose**: Guidelines for writing AI instructions, agent definitions, and command prompts optimized for Claude models. These guidelines are designed for AI consumption, not human readability.

---

## Core Architecture Principles

### 1. Hierarchical XML Structure
**CRITICAL**: Use structured XML tags for optimal Claude parsing and instruction hierarchy.

```xml
<core_identity>
Primary role and capabilities definition
</core_identity>

<operational_constraints priority="CRITICAL">
Clear boundaries and limitations
</operational_constraints>

<task_specifications>
Specific instructions for task execution
</task_specifications>

<output_requirements>
Format, structure, and quality standards
</output_requirements>

<validation_check>
Input → Process → Output verification steps
</validation_check>
```

### 2. Priority-Based Information Ordering
**Sequence for maximum effectiveness:**
1. Critical constraints and safety requirements (`priority="CRITICAL"`)
2. Core identity and role definition 
3. Task-specific instructions
4. Output formatting and quality standards
5. Edge case handling and fallback behaviors

### 3. Enforcement Patterns
**Template for rule enforcement:**
```xml
<enforcement>Specific action after trigger condition</enforcement>
<meaningful_change_definition>
  Precise criteria for when enforcement applies
</meaningful_change_definition>
```

## Agent Definition Optimization

### Role Clarity Framework
```xml
<agent_definition>
  <core_function>Single sentence describing primary purpose</core_function>
  
  <capability_boundaries>
    <handles>
      - Specific task category 1 with measurable criteria
      - Specific task category 2 with validation rules
    </handles>
    
    <does_not_handle>
      - Out of scope task 1 (delegates to X agent)
      - Out of scope task 2 (escalates to Y agent)
    </does_not_handle>
  </capability_boundaries>
  
  <operational_protocol>
    1. Validate inputs against [specific criteria]
    2. Execute [defined workflow with checkpoints]
    3. Verify output meets [quality standards]
    4. Handle errors by [fallback behavior]
  </operational_protocol>
  
  <success_criteria>
    Measurable outputs that define successful task completion
  </success_criteria>
</agent_definition>
```

### Handoff Coordination Patterns
**For multi-agent systems:**
```xml
<agent_delegation>
  <primary_agent>agent-name (PROACTIVELY use when [condition])</primary_agent>
  <trigger_conditions>
    - User mentions [keywords]
    - Task complexity exceeds [threshold]
    - Domain expertise requires [specialization]
  </trigger_conditions>
  <coordination>All [task type] MUST be delegated to [agent] to prevent [problem]</coordination>
</agent_delegation>
```

## Command Prompt Optimization

### Action-Oriented Structure
```json
{
  "name": "action-target-modifier",
  "description": "Active voice description of command purpose",
  "parameters": {
    "required": ["param1 with validation rules"],
    "optional": ["param2 with defaults and constraints"]
  },
  "instructions": [
    "1. Validate inputs against [criteria]",
    "2. Execute [specific actions with checkpoints]", 
    "3. Return [structured output format]",
    "4. Handle errors by [fallback behavior]"
  ],
  "output_format": {
    "success": "Structured response template",
    "error": "Error response with recovery options"
  }
}
```

### Parameter Validation Patterns
**Input validation framework:**
```xml
<parameter_validation>
  <required_checks>
    - Type validation: [parameter] must be [type]
    - Range validation: [parameter] must be between [min] and [max]
    - Format validation: [parameter] must match [regex/pattern]
  </required_checks>
  
  <error_handling>
    - Invalid input: Return [specific error message] with [correction guidance]
    - Missing required: Return [required parameters list] with [examples]
    - Type mismatch: Return [expected type] with [format example]
  </error_handling>
</parameter_validation>
```

## System Prompt Architecture

### Constraint-First Design
**Lead with boundaries and limitations:**
```xml
<system_constraints priority="CRITICAL">
  <security_boundaries>
    - NEVER [forbidden action 1]
    - ALWAYS [required security check]
    - REFUSE [dangerous request categories]
  </security_boundaries>
  
  <capability_limits>
    - CAN: [explicit capability list with examples]
    - CANNOT: [explicit limitation list with alternatives]
    - DELEGATE: [handoff criteria and target agents]
  </capability_limits>
</system_constraints>
```

### Context Window Optimization
**Information hierarchy for Claude's extended context:**
```xml
<information_priority>
  <critical_first_4k>
    Core identity, primary constraints, immediate task requirements
  </critical_first_4k>
  
  <supporting_context>
    Detailed examples, edge cases, comprehensive reference material
  </supporting_context>
  
  <reference_data>
    Historical context, additional resources, extended documentation
  </reference_data>
</information_priority>
```

## Validation Chain Patterns

### Three-Stage Validation
**Input → Process → Output verification:**
```xml
<validation_framework>
  <input_validation>
    - Parameter type checking
    - Constraint verification  
    - Context appropriateness
    - Security boundary compliance
  </input_validation>
  
  <process_validation>
    - Workflow checkpoint verification
    - Intermediate result quality checks
    - Resource utilization monitoring
    - Error condition detection
  </process_validation>
  
  <output_validation>
    - Format compliance verification
    - Content quality assessment
    - Completeness checking
    - Consistency validation
  </output_validation>
</validation_framework>
```

### Error Recovery Protocols
**Graceful failure handling:**
```xml
<error_recovery>
  <failure_categories>
    - Input validation failure: [specific recovery action]
    - Process execution failure: [fallback behavior]
    - Output generation failure: [alternative response]
    - Resource limitation failure: [degraded mode operation]
  </failure_categories>
  
  <escalation_protocol>
    1. Attempt automatic recovery using [method]
    2. If recovery fails, delegate to [fallback agent]
    3. If delegation fails, return [structured error response]
    4. Log failure details for [improvement process]
  </escalation_protocol>
</error_recovery>
```

## Output Format Specifications

### Structured Response Templates
**Consistent formatting for Claude optimization:**
```xml
<output_templates>
  <success_response>
    <status>success</status>
    <result>[structured data matching schema]</result>
    <metadata>
      <processing_time>[duration]</processing_time>
      <validation_passed>true</validation_passed>
      <next_actions>[suggested follow-ups]</next_actions>
    </metadata>
  </success_response>
  
  <error_response>
    <status>error</status>
    <error_type>[category]</error_type>
    <error_message>[user-friendly description]</error_message>
    <recovery_options>[available alternatives]</recovery_options>
    <debug_info>[technical details for troubleshooting]</debug_info>
  </error_response>
</output_templates>
```

### Progressive Disclosure Patterns
**Context-efficient information delivery:**
```xml
<progressive_disclosure>
  <summary_first>
    Brief overview with key points and immediate actions
  </summary_first>
  
  <expandable_details>
    <section name="technical_details" collapse="true">
      Comprehensive technical information available on request
    </section>
    
    <section name="examples" collapse="true">
      Detailed examples and use cases for reference
    </section>
    
    <section name="troubleshooting" collapse="true">
      Error scenarios and resolution steps
    </section>
  </expandable_details>
</progressive_disclosure>
```

## Claude-Specific Optimizations

### Chain of Thought Integration
**Explicit reasoning for accuracy:**
```xml
<reasoning_protocol>
  <step_by_step_analysis>
    1. Problem decomposition: Break complex tasks into verifiable components
    2. Constraint checking: Verify all requirements and limitations
    3. Solution planning: Design approach with checkpoints
    4. Execution monitoring: Track progress and validate intermediate results
    5. Quality verification: Confirm output meets all specifications
  </step_by_step_analysis>
  
  <transparency_requirements>
    - Show reasoning process for complex decisions
    - Explain trade-offs and alternative approaches
    - Highlight assumptions and dependencies
    - Document validation steps and results
  </transparency_requirements>
</reasoning_protocol>
```

### Few-Shot Example Patterns
**2-3 concrete examples for optimal learning:**
```xml
<example_structure>
  <example_1>
    <input>[concrete input scenario]</input>
    <process>[step-by-step handling]</process>
    <output>[expected structured result]</output>
    <reasoning>[why this approach is optimal]</reasoning>
  </example_1>
  
  <example_2>
    <input>[edge case scenario]</input>
    <process>[modified handling approach]</process>
    <output>[adapted result format]</output>
    <reasoning>[handling rationale for edge case]</reasoning>
  </example_2>
  
  <example_3>
    <input>[error condition scenario]</input>
    <process>[error detection and recovery]</process>
    <output>[error response with recovery options]</output>
    <reasoning>[graceful failure handling explanation]</reasoning>
  </example_3>
</example_structure>
```

## Quality Assurance Frameworks

### Consistency Checking
**Maintain coherent behavior across scenarios:**
```xml
<consistency_framework>
  <behavioral_standards>
    - Response format consistency across similar tasks
    - Terminology standardization throughout interactions
    - Quality level maintenance regardless of complexity
    - Error handling uniformity across failure modes
  </behavioral_standards>
  
  <cross_reference_validation>
    - Verify responses align with established patterns
    - Check for contradictions with previous guidance
    - Ensure compatibility with related agent behaviors
    - Validate against system-wide quality standards
  </cross_reference_validation>
</consistency_framework>
```

### Performance Optimization
**Efficiency patterns for Claude models:**
```xml
<performance_optimization>
  <context_efficiency>
    - Front-load critical information within first 4K tokens
    - Use structured tagging for rapid information retrieval
    - Implement reference patterns to avoid repetition
    - Design for optimal context window utilization
  </context_efficiency>
  
  <processing_efficiency>
    - Minimize redundant validation steps
    - Cache frequently accessed patterns
    - Use parallel processing where applicable
    - Optimize decision trees for common scenarios
  </processing_efficiency>
</performance_optimization>
```

## Implementation Guidelines

### File Structure Compliance
**Adhere to established organizational patterns:**
```xml
<file_organization priority="CRITICAL">
  <location_enforcement>
    <agents>.claude/agents/ (ONLY location for agent definitions)</agents>
    <commands>.claude/commands/ (ONLY location for slash commands)</commands>
    <instructions>templates/.support/instructions/ (template instructions)</instructions>
    <prompts>templates/.support/prompts/ (template prompts)</prompts>
  </location_enforcement>
  
  <search_restrictions>
    NEVER search elsewhere for these file types - adherence is CRITICAL
  </search_restrictions>
</file_organization>
```

### Version Control Integration
**Git workflow optimization:**
```xml
<git_protocol priority="CRITICAL">
  <enforcement>Execute git workflow after EVERY meaningful change</enforcement>
  
  <meaningful_change_definition>
    File modifications affecting system behavior, configuration changes, 
    structural updates, or any changes that impact functionality, 
    documentation, or project organization.
  </meaningful_change_definition>
  
  <workflow_steps>
    1. Validate changes meet quality standards
    2. Stage modified files with descriptive commit messages
    3. Include Co-authored-by trailers when appropriate
    4. Push to designated branch following naming conventions
  </workflow_steps>
</git_protocol>
```

## Advanced Patterns

### Memory Integration
**Persistent knowledge management:**
```xml
<memory_patterns>
  <structured_tagging>
    Use consistent XML tags for information categorization and retrieval
  </structured_tagging>
  
  <relationship_mapping>
    Document connections between concepts, agents, and commands
  </relationship_mapping>
  
  <knowledge_graphs>
    Build comprehensive understanding of domain relationships
  </knowledge_graphs>
  
  <retrieval_optimization>
    Design patterns for efficient information access and context building
  </retrieval_optimization>
</memory_patterns>
```

### Multi-Modal Integration
**Combine text with visual elements:**
```xml
<multimodal_optimization>
  <visual_elements>
    - ASCII diagrams for complex relationships
    - Structured tables with clear headers
    - Code blocks for technical specifications
    - Visual examples to supplement text instructions
  </visual_elements>
  
  <format_coordination>
    - Ensure text and visual elements reinforce each other
    - Maintain consistency across different presentation modes
    - Optimize for both screen readers and visual processing
    - Design for cross-platform compatibility
  </format_coordination>
</multimodal_optimization>
```

---

## Summary

These guidelines provide a comprehensive framework for creating AI instructions optimized for Claude models. Key principles:

1. **Structured XML formatting** with priority-based information ordering
2. **Validation chain patterns** ensuring input→process→output verification  
3. **Role clarity frameworks** with explicit capability boundaries
4. **Context efficiency optimization** leveraging Claude's extended context window
5. **Error recovery protocols** with graceful failure handling
6. **Consistency checking** maintaining coherent behavior across scenarios

**Implementation Priority:**
- **High Priority**: XML structure standardization, validation frameworks, role clarity patterns
- **Medium Priority**: Performance optimization, error recovery protocols, consistency checking  
- **Low Priority**: Advanced memory integration, multi-modal optimization patterns

All instructions should follow the constraint-first design principle, leading with security boundaries and capability limits before defining positive behaviors and task specifications.