# Research Verification Protocol
# Purpose: Mandatory research process for Zettelkasten notes with dynamic depth
# Status: REQUIRED - Notes cannot be created without following this protocol

## Core Principle

Every claim must be verified or explicitly marked as unverifiable. Research is not optional - it is the foundation of note quality. Research depth should match claim complexity.

## Dynamic Research Depth

### Claim Complexity Assessment
Rate each claim 1-5 on:
- **Specificity**: Vague claim (1) vs precise metric (5)
- **Importance**: Supporting detail (1) vs core concept (5)
- **Controversy**: Widely accepted (1) vs actively debated (5)
- **Recency**: Established knowledge (1) vs cutting-edge (5)

### Research Depth Formula
Total Score → Required Research:
- 4-7: Single authoritative source sufficient
- 8-11: 2-3 diverse sources needed
- 12-16: 4-5 sources including primary research
- 17-20: Comprehensive literature review (6+ sources)

### Search Strategy by Depth
**Light (4-7)**:
- Start with official docs or textbooks
- One verification search if needed

**Medium (8-11)**:
- Primary source + supporting secondary
- Check for recent updates/contradictions

**Deep (12-16)**:
- Academic search first (Google Scholar)
- Cross-reference multiple viewpoints
- Include historical context

**Comprehensive (17-20)**:
- Systematic review approach
- Include opposing viewpoints
- Trace citation networks
- Document evolution of understanding

## Verification Checklist (Required Before Any Artifact)

**Format:**
```
Claims Requiring Verification:
1. [Claim]: _______________
   - Complexity Score: [Specificity:_] [Importance:_] [Controversy:_] [Recency:_] = Total: __
   - Research Depth Required: [Light/Medium/Deep/Comprehensive]
   - Status: ❌ Unverified
   - Search strategy: _______________
   - Target source tier: [1-2 preferred]
   
2. [Claim]: _______________
   - Complexity Score: [Specificity:_] [Importance:_] [Controversy:_] [Recency:_] = Total: __
   - Research Depth Required: [Light/Medium/Deep/Comprehensive]
   - Status: ❌ Unverified
   - Search strategy: _______________
   - Target source tier: [1-2 preferred]
```

**GATE RULE:** Cannot create artifact until ALL ❌ are resolved

## Research Execution Protocol

### For EACH Claim:

1. **Search Phase** (Depth varies by complexity score)
   ```
   Searching: "[exact query shown to user]"
   - Use web_search tool (NOT MCP fetch)
   - Light: 1 targeted search
   - Medium: 2-3 searches from different angles
   - Deep: 4-5 including academic sources
   - Comprehensive: 6+ systematic coverage
   ```

2. **Source Evaluation** (For each source found)
   ```
   Evaluating: [Source Domain/Title]
   - Quality Tier: [1-4 per framework]
   - Credibility: Academic/Primary/Secondary/Weak
   - Date: [When published/updated]
   - Relevant quote: "[Exact quote from source]"
   - Assessment: [Why reliable or not]
   ```

3. **Verification Decision**
   ```
   ✓ Verified: "[exact quote]" (Source: https://full-url.com)
   ⚠️ Partially verified: General support but not specific claim - apply appropriate hashtag per note-templates.md
   ❌ Cannot verify: No credible sources found after X searches - apply appropriate hashtag per note-templates.md
   🚫 Contradicted: Sources disagree - show both views with appropriate hashtag per note-templates.md
   ```

4. **Checklist Update**
   ```
   Updated status:
   1. ✓ [Claim] - Verified with Tier 1 source (apply hashtag per note-templates.md)
   2. ⚠️ [Claim] - Partially supported by Tier 3 sources (apply hashtag per note-templates.md)
   3. ❌ [Claim] - Removed as unverifiable (apply hashtag per note-templates.md)
   ```

## Source Citation Format

**Required format for ALL web sources:**
- `"[Exact quote]" (Source: https://example.com/full-path)`
- Can add domain for clarity: `(fs.blog: https://fs.blog/article)`
- NO academic-style citations for web sources
- URL must be complete and clickable

## Quality Standards

### Minimum Requirements:
- Every uncertain claim must be searched
- Search depth must match complexity score
- All sources evaluated for credibility and tier
- Exact quotes required for verification
- Failed searches must be documented
- Contradicting evidence must be presented
- Majority of sources should be Tier 1-2 when possible

### Target Metrics:
- 80%+ claims successfully verified
- 60%+ sources from Tier 1-2
- Average source age < 5 years for empirical claims
- Zero unverified claims marked as verified
- All high-importance claims (4-5) have multiple sources

## Research Transparency

Every note must document:
- **Search Evolution**: Started broad → narrowed to [specific aspect]
- **Source Distribution**: X academic, Y technical docs, Z secondary (Tiers: X@1, Y@2, Z@3, W@4)
- **Confidence Distribution**: X high, Y medium, Z low confidence claims
- **Research Scope**: Y searches performed, Z sources evaluated
- **Key Decisions**: 
  - Rejected [source] because [specific reason]
  - Chose [source A] over [source B] due to [criteria]
  - Could not verify [aspect] despite searching [queries]
- **Remaining Uncertainties**: [What would need better sources]

## Common Pitfalls to Avoid

❌ Marking claims verified without quotes
❌ Using single search when complexity score > 7
❌ Accepting Tier 4 sources for important claims
❌ Hiding contradicting evidence
❌ Creating artifact before research complete
❌ Using vague "studies show" without citation
❌ Not adjusting depth for claim importance

## Workflow Integration

1. User provides topic
2. Create verification checklist with complexity scores FIRST
3. Show checklist to user
4. Research each claim according to required depth
5. Update checklist after each
6. Perform source quality audit
7. Only create artifact when complete
8. Include research metrics in note

## Source Quality Audit (Before Artifact Creation)

After completing searches but before creating artifact:
1. Calculate source tier distribution
2. If >50% sources are Tier 3-4, perform additional academic search
3. Flag any claims relying solely on Tier 4 sources
4. Suggest elevation strategy for weak sources
5. Document any synthesis requiring 3+ sources

## Example Research Flow

```
Verification Checklist:
1. ❌ Technique improves learning by 55%
   - Complexity: [Specificity:5] [Importance:5] [Controversy:3] [Recency:3] = 16 (Deep research)
   - Target: Find primary research study
   
2. ❌ Developed by Richard Feynman
   - Complexity: [Specificity:3] [Importance:3] [Controversy:1] [Recency:1] = 8 (Medium research)
   - Target: Biography or primary source
   
3. ❌ Has 4 specific steps
   - Complexity: [Specificity:4] [Importance:2] [Controversy:1] [Recency:1] = 8 (Medium research)
   - Target: Multiple consistent sources

Starting research...

Claim 1: "Technique improves learning by 55%" (Deep - need 4-5 sources)
Searching: "Feynman technique effectiveness percentage study"
[No specific study found - Tier 4 blogs only]
Searching: "self-explanation learning improvement research"
[Found Chi et al. meta-analysis - Tier 1]
Searching: "teaching others learning retention study"
[Found Fiorella & Mayer 2015 - Tier 1]
Searching: "explain to learn effectiveness research"
[Additional supporting studies - Tier 1-2]
⚠️ Partially verified: Self-explanation shows 20-40% improvement (apply #emerging per note-templates.md), but no Feynman-specific studies exist

Claim 2: "Developed by Richard Feynman" (Medium - need 2-3 sources)
Searching: "Richard Feynman teaching technique origin"
[Multiple sources cite but no primary - Tier 3]
Searching: "Feynman technique biography Surely You're Joking"  
[Checked his books, no mention - Original source absent]
❌ Cannot verify: Widely attributed but no primary source found (apply #attributed per note-templates.md)

[Continue for all claims...]

Source Quality Audit:
- Tier 1: 3 sources (43%)
- Tier 2: 1 source (14%)
- Tier 3: 2 sources (29%)
- Tier 4: 1 source (14%)
- Action: Acceptable distribution, flagging attribution issue

Final checklist:
1. ⚠️ Partially verified - modified to general self-explanation benefits (apply hashtags per note-templates.md)
2. ❌ Cannot verify - marked as popular attribution (apply hashtags per note-templates.md)
3. ✓ Verified - consistent 4-step structure across sources (apply hashtag per note-templates.md)
```

## Remember

- Research quality determines note value
- Depth should match importance and complexity
- Prefer Tier 1-2 sources whenever possible
- Better to have fewer verified claims than many uncertain ones
- Transparency about limitations builds trust
- Every URL should be immediately checkable
- This protocol is mandatory, not optional
- Apply confidence hashtags as defined in note-templates.md