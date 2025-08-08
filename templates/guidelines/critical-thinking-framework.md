# Critical Thinking Framework for Source Evaluation
# Version: 2.0
# Purpose: Systematic evaluation of sources and claims with hierarchical quality standards
# Application: Use during research phase for every source

## Source Quality Hierarchy (Prioritized)

### Tier 1: Gold Standard Sources
- **Peer-reviewed journals** (Nature, Science, PNAS, domain-specific top journals)
- **Systematic reviews and meta-analyses**
- **Official technical documentation** (RFCs, language specs, API docs)
- **Primary research with reproducible methodology**

### Tier 2: High-Quality Secondary Sources
- **Academic textbooks** from reputable publishers
- **Technical books** with strong peer review (O'Reilly, Manning, etc.)
- **Official organizational reports** (WHO, IEEE, ACM)
- **Established technical blogs** with author expertise (e.g., Martin Fowler for software)

### Tier 3: Acceptable Supporting Sources
- **Reputable news outlets** with fact-checking (Reuters, AP, BBC)
- **Community-validated resources** (high-quality Stack Overflow answers with votes)
- **Conference proceedings** and white papers
- **Well-maintained documentation** (MDN, official tutorials)

### Tier 4: Use With Extreme Caution
- **Personal blogs** without clear expertise
- **Medium/Substack** unless author is recognized expert
- **YouTube/Video content** unless from educational institutions
- **Any source trying to sell something**

**Decision Rule**: Always prefer highest tier available. If only Tier 3-4 available, explicitly note limitation.

## Source Credibility Assessment

### Primary Questions (Ask for EVERY source)

1. **Authority**
   - Who is the author/organization?
   - What are their credentials in this field?
   - Is this their area of expertise?
   - Are they cited by others in the field?

2. **Source Type Hierarchy**
   - Primary source (original research/direct evidence)
   - Secondary source (analysis/interpretation)
   - Tertiary source (encyclopedia/aggregator)
   - Opinion/Editorial (clearly marked viewpoint)

3. **Publication Quality**
   - Peer-reviewed journal article
   - Academic institution publication  
   - Professional organization report
   - Reputable news outlet with fact-checking
   - Blog/Personal website (evaluate carefully)

4. **Recency and Relevance**
   - When published/last updated?
   - Is this current for the topic?
   - Have there been major developments since?
   - Does date matter for this claim?

5. **Transparency**
   - Are sources and methods clear?
   - Is raw data available?
   - Are limitations acknowledged?
   - Is uncertainty quantified?

### Red Flags to Identify

⚠️ **Immediate Concerns:**
- No author or organization listed
- No date or "timeless" content
- No sources cited for factual claims
- Obvious spelling/grammar errors
- Sensationalist headlines
- Domain looks suspicious
- Vendor marketing content (especially product/service claims)

🚫 **Disqualifying Factors:**
- Known disinformation source
- Extreme bias without disclosure
- Pure marketing material disguised as research
- Selling something related to claims
- Conspiracy theory promotion
- Hate speech or extremism

## Claim Evaluation Process

### For Each Claim, Assess:

1. **Evidence Quality**
   ```
   Strong Evidence:
   - Multiple independent sources agree
   - Primary research with methodology
   - Statistical significance shown
   - Reproducible results
   
   Weak Evidence:
   - Single source only
   - Anecdotal/personal experience
   - No methodology described
   - Cherry-picked examples
   ```

2. **Logical Soundness**
   - Does conclusion follow from evidence?
   - Are there unstated assumptions?
   - Any logical fallacies present?
   - Alternative explanations possible?

3. **Context Completeness**
   - Is claim taken out of context?
   - Are important caveats missing?
   - What's the broader picture?
   - Who benefits from this claim?

4. **Consensus Check**
   - What do other experts say?
   - Is this mainstream or fringe?
   - Are there active debates?
   - What's the evidence on both sides?

## Grounding Quality Checklist

Before marking any claim as verified, confirm:

### Source Assessment
- [ ] Is this the original source, not someone citing it?
- [ ] Can I access the actual data/methodology?
- [ ] Is the author qualified in this specific domain?
- [ ] Is this the most recent authoritative position?

### Claim Validation
- [ ] Does the source actually support this specific claim?
- [ ] Am I avoiding overinterpretation?
- [ ] Have I checked for retractions/corrections?
- [ ] Is this claim still current?

### Context Completeness
- [ ] Have I captured important caveats/limitations?
- [ ] Is the claim's scope accurately represented?
- [ ] Are confidence levels appropriately marked?
- [ ] Would an expert recognize this as accurate?

### Red Flags That Require Additional Verification
- Source is >5 years old for empirical claims
- Author works for company benefiting from claim
- Claim includes specific percentages without methodology
- Source is secondary without primary citation
- Extraordinary claim without extraordinary evidence

## Decision Framework

### How to Classify Claims

**✓ VERIFIED - High Confidence**
- Multiple credible sources agree (Tier 1-2)
- Evidence directly supports claim
- No significant contradictions
- Methodology is sound
- Expert consensus exists

**⚠️ PARTIALLY VERIFIED - Medium Confidence**
- Some credible support (mix of Tier 2-3)
- Evidence suggests but doesn't prove
- Minor contradictions exist
- Limited sources available
- Emerging consensus

**❌ CANNOT VERIFY - Low/No Confidence**
- No credible sources found
- Only weak evidence exists (Tier 4)
- Contradictions without resolution
- Claims beyond current knowledge
- Speculation presented as fact

**🚫 CONTRADICTED - Negative Confidence**
- Credible sources disagree
- Evidence points opposite direction
- Claim has been debunked
- Based on outdated information
- Misrepresents the source

## Common Biases to Check

### In Sources:
- **Confirmation bias**: Only presenting supporting evidence
- **Selection bias**: Cherry-picking data
- **Publication bias**: Only positive results published
- **Funding bias**: Results favor sponsor
- **Cultural bias**: Assumptions from specific worldview
- **Marketing bias**: Information shaped to sell products/services

### In Yourself:
- **Anchoring**: Over-relying on first source
- **Availability heuristic**: Recent info seems more valid
- **Authority bias**: Trusting credentials over evidence
- **Coherence bias**: Preferring neat stories over messy truth

## Practical Evaluation Examples

### Example 1: Evaluating a Blog Post
```
Source: PersonalBlog.com/productivity-technique
Author: "Productivity Guru" (no real name)
Date: No date visible
Quality Tier: 4

Red flags:
- No author credentials
- No date provided
- Selling a course on the topic
- No sources cited
- Claims seem exaggerated

Decision: ❌ Not credible for factual claims
```

### Example 2: Evaluating Academic Paper
```
Source: Nature.com/articles/s41586-023-12345
Authors: University researchers with PhDs
Date: 2023, peer-reviewed
Quality Tier: 1

Strengths:
- Published in top journal
- Peer review process
- Methods clearly described
- Data available
- Limitations acknowledged

Decision: ✓ Highly credible for claims made
```

### Example 3: Evaluating News Article
```
Source: TechNews.com/ai-breakthrough
Author: Tech journalist with byline
Date: Last week
Quality Tier: 3

Mixed signals:
- Reputable outlet
- But reporting on press release
- Quotes only company sources
- No independent verification
- Some hype language

Decision: ⚠️ Partially credible, need verification
```

### Example 4: Evaluating Vendor Marketing Content
```
Source: SuperProductCorp.com/whitepaper-productivity
Author: "Research Team" (no individual names)
Date: No date, but pushing latest product
Quality Tier: 4

Red flags:
- Published by vendor selling the solution
- No peer review or external validation
- Cherry-picked case studies
- All metrics favor their product
- Competitors portrayed negatively
- "Research" leads to sales pitch
- No discussion of limitations

Decision: ❌ Not credible for objective claims
Note: May contain useful technical specs but verify all comparative claims
```

## Quick Evaluation Checklist

For every source, quickly check:
- [ ] Author/organization identified?
- [ ] Expertise in this topic?
- [ ] Date recent enough?
- [ ] Sources cited?
- [ ] Bias disclosed?
- [ ] Methods explained?
- [ ] Limitations acknowledged?
- [ ] Other sources agree?
- [ ] Evidence matches claims?
- [ ] Free from marketing intent?
- [ ] Free from major red flags?
- [ ] What quality tier (1-4)?

Score 10-12: Likely credible (Tier 1-2)
Score 6-9: Evaluate carefully (Tier 2-3)
Score 0-5: Probably not credible (Tier 4)

## Final Reminders

1. **No source is perfect** - Even good sources have limitations
2. **Triangulate** - Never rely on single source for important claims
3. **Document doubts** - If unsure, say so in the note
4. **Update regularly** - Knowledge evolves, so should notes
5. **Prefer primary** - Get as close to original source as possible
6. **Check yourself** - Are your own biases affecting evaluation?
7. **Quality over quantity** - One Tier 1 source beats five Tier 4 sources

## Special Considerations for Marketing Content

### Identifying Marketing Material
- **Obvious**: Product pages, sales brochures, vendor websites
- **Disguised**: White papers, "research reports," case studies
- **Subtle**: Sponsored content, native advertising, paid placements
- **Academic-looking**: Vendor-funded studies without disclosure

### How to Handle Marketing Content
1. **Never use as primary source** for comparative claims
2. **Can use for**: Technical specifications, feature lists
3. **Always verify**: Any performance claims independently
4. **Look for**: Independent reviews, third-party testing
5. **Red flag phrases**:
   - "Industry-leading"
   - "Revolutionary breakthrough"
   - "The only solution that..."
   - "Studies show" (without citation)
   - "Customers report" (without data)

### When Marketing Content Is Encountered
- Mark source as vendor/marketing
- Extract only factual specifications
- Seek independent verification
- Note potential bias in research transparency
- Never present marketing claims as verified facts

## When in Doubt

If you cannot determine credibility:
- Mark as "uncertain pending verification"
- Document what would be needed to verify
- Search for additional sources
- Consider reaching out to experts
- Default to transparency about limitations

Remember: It's better to admit uncertainty than to present dubious claims as facts.