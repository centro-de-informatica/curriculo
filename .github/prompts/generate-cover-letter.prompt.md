---
name: generate-cover-letter
description: Generate a customized cover letter based on a job description
argument-hint: "Paste the job description or provide company/role details"
agent: agent
tools:
  ['read', 'edit', 'web/fetch']
---

# Cover Letter Generator

Generate a customized cover letter for a job application based on the provided job description.

## Context Files

Reference these files to understand the project structure and guidelines:

- [Resume Guidelines and Cover Letter Structure](../../AGENTS.md) - Contains all formatting rules, section structure, and best practices
- [Candidate Resume/CV](../../resume.qmd) - Source of candidate's experience, skills, education, and achievements
- [Cover Letter Template](../../cover-letter.qmd) - Current cover letter structure and format to follow

## Instructions

1. **Analyze the Job Description**: Extract key requirements, technologies, skills, and company information from: `${input:jobDescription:Paste the full job description here}`

2. **Match Candidate Profile**: Using the candidate's resume, identify:
   - Most relevant experiences and achievements that align with the job requirements
   - Technical skills that match the job's tech stack
   - Projects or accomplishments with quantifiable metrics (%, $, users, time)
   - Education and certifications relevant to the role

3. **Research Integration**: If the job description mentions specific company initiatives, products, or values, incorporate them into the "Why This Company" paragraph.

4. **Generate Cover Letter**: Create content following the 5-6 paragraph structure from AGENTS.md:
   - **Paragraph 1**: Hook + Position + Brief Background (mention specific role and company)
   - **Paragraph 2**: Key Achievement from most relevant experience with metrics
   - **Paragraph 3**: Why This Company + What candidate brings (show research)
   - **Paragraph 4**: Key Achievement from second relevant experience with metrics
   - **Paragraph 5**: Call to Action + Availability + Contact
   - **Paragraph 6**: Thank You + Forward-looking Statement

5. **Apply Guidelines**:
   - Use Google XYZ formula: "Accomplished [X] measured by [Y], by doing [Z]"
   - Start with strong action verbs (Built, Led, Developed, Implemented)
   - Include quantified achievements (%, $, users, time saved)
   - Keep to one page maximum
   - Mirror key achievements from resume
   - Customize placeholders like `[Company]`, `[position]` with actual values from job description

6. **Output Format**: 
   - Generate ONLY the content blocks for both `en` and `pt-BR` profiles
   - Maintain the existing YAML frontmatter structure from cover-letter.qmd
   - Update the `recipient` fields based on job description (company name, location)
   - Keep both language versions synchronized in content

## Output Requirements

Update the cover-letter.qmd file with:
- Updated `recipient` section in YAML frontmatter (company, title, address from job description)
- Customized English content in `::: {.content-visible when-profile="en"}` block
- Customized Portuguese content in `::: {.content-visible when-profile="pt-BR"}` block
- All `[Company]`, `[position]`, `[reason showing research]`, `[specific project/initiative]` placeholders replaced with actual content

## Quality Checklist

Before finalizing, verify:
- [ ] Company name and role are correctly mentioned throughout
- [ ] At least 2-3 quantified achievements included
- [ ] "Why This Company" paragraph shows specific research
- [ ] Call to action includes contact information
- [ ] Both EN and PT-BR versions are synchronized
- [ ] No raw LaTeX or special characters in content
- [ ] Tone is professional but enthusiastic
