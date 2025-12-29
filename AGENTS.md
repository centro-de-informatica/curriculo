# AGENTS.md

Before begin, read [README.md](./README.md)

> **Context:** Quarto Extensions for FAANG-style PDF Résumé and Cover Letter.
> **Target Audience:** New Graduates and Junior Engineers (0-2 years experience).
> **Architecture:** Single `.qmd` files with multi-language content via Quarto Profiles.
> **Output:** `_output/{en,pt-BR}/`
> **Based on:** Official guides from CMU, Harvard, Stanford, Google, and Tech Interview Handbook.

---

## 1. Project Structure

```text
/
├── resume.qmd              # Resume (EN + PT-BR, concise + master)
├── cover-letter.qmd        # Cover letter (EN + PT-BR)
├── _quarto.yml             # Base config + two profile groups
├── _quarto-en.yml          # English language settings
├── _quarto-pt-BR.yml       # Portuguese language settings
├── _quarto-concise.yml     # Concise version (default names)
├── _quarto-master.yml      # Master version (master.pdf)
├── _extensions/
│   ├── professional-cv/    # format: professional-cv-pdf
│   └── cover-letter/       # format: cover-letter-pdf
└── _output/                # Generated PDFs
    ├── en/
    │   ├── resume.pdf
    │   ├── master.pdf
    │   └── cover-letter.pdf
    └── pt-BR/
        ├── resume.pdf
        ├── master.pdf
        └── cover-letter.pdf
```

---

## 2. Profiles

Two independent profile groups combined at render time:

| Group | Profiles | Purpose |
|-------|----------|--------|
| Language | `en`, `pt-BR` | Sets `lang` and `output-dir` |
| Version | `concise`, `master` | Sets output filename for resume |

| Combination | Output Directory | Resume File | Cover Letter |
|-------------|------------------|-------------|--------------|
| `--profile en,concise` | `_output/en/` | `resume.pdf` | `cover-letter.pdf` |
| `--profile en,master` | `_output/en/` | `master.pdf` | `cover-letter.pdf` |
| `--profile pt-BR,concise` | `_output/pt-BR/` | `resume.pdf` | `cover-letter.pdf` |
| `--profile pt-BR,master` | `_output/pt-BR/` | `master.pdf` | `cover-letter.pdf` |

**`_quarto.yml`:**
```yaml
project:
  type: default
profile:
  default: [en, concise]
  group:
    - [en, pt-BR]
    - [concise, master]
```

**Conditional content:**
```markdown
::: {.content-visible when-profile="en"}
English content (both concise and master)

::: {.content-visible when-profile="master"}
Additional master-only details (nested inside language block)
:::

:::

::: {.content-visible when-profile="pt-BR"}
Conteúdo em português (concise e master)

::: {.content-visible when-profile="master"}
Detalhes adicionais apenas para master (aninhado dentro do bloco de idioma)
:::

:::
```

---

## 3. Format Pattern

| Extension Folder | Format Key | Result |
|------------------|------------|--------|
| `professional-cv/` | `pdf` | `professional-cv-pdf` |
| `cover-letter/` | `pdf` | `cover-letter-pdf` |

---

## 4. Shortcodes

### Entry (Experience/Education)

```markdown
{{< entry title="Job Title" company="Company Name" dates="Start - End" loc="Location" >}}

* Achievement with metrics
```

---

## 5. Build Commands

```bash
# Combine language + version profiles
quarto render --profile en,concise       # EN concise: resume.pdf
quarto render --profile en,master        # EN master: master.pdf
quarto render --profile pt-BR,concise    # PT concise: resume.pdf
quarto render --profile pt-BR,master     # PT master: master.pdf

# Single file
quarto render resume.qmd --profile en,master
quarto render cover-letter.qmd --profile pt-BR,concise
```

---

# RESUME GUIDELINES

## 6. Resume Formatting and Layout

The #1 mistake is trying to be "creative" with design. Engineering values efficiency and clarity.

- **Single Page (Required for <10 years experience):** Recruiters spend ~6 seconds on initial scan
- **Single Column:** Double columns confuse ATS (Applicant Tracking Systems)
- **Margins:** 0.75" to 1" (minimum 0.5" if space is critical)
- **Font:** Clean serif or sans-serif (Arial, Calibri, Helvetica, Times New Roman, Garamond)
  - Body: 10-12pt
  - Headers: 14-16pt
  - Name: 20pt+
- **File Format:** Always **PDF** (never .docx unless explicitly requested)

---

## 7. Resume YAML Frontmatter

```yaml
---
format: professional-cv-pdf
name: "Full Name"
contact:
  email: "email@example.com"
  phone: "+1 555-000-0000"
  location: "City, State"
  linkedin: "linkedin_username"
  github: "github_username"
---
```

**Header Rules:**
- Email: Professional format (e.g., `firstname.lastname@gmail.com`)
- Location: City/State only (no full street address)
- Links: LinkedIn and GitHub (required for devs) - ensure GitHub has visible/public code
- **Do NOT include:** Photo, age, marital status, generic "Objective" statement

---

## 8. Concise vs Master Resume

### Concise (Default/ATS-Friendly/Targeted)

The concise version is what you send to employers. It's tailored for specific job applications.

- **Purpose:** Job applications, ATS systems, recruiters
- **Length:** 1 page (strictly enforced for new grads with <2 years experience)
- **Content:** Only relevant experience for the target role
- **Bullets:** 3-4 per role, high-level achievements with metrics
- **Sections (New Grad/Junior - Default):** Education, Experience (internships count!), Additional Experience and Leadership (research, TA positions, personal projects, extracurriculars), Skills, Certifications
- **Output:** `resume.pdf`

**New Grad Reality Check:**
- Internships ARE experience - treat them as such
- Research positions and TA roles belong in "Additional Experience"
- **Projects go INSIDE the relevant experience entry** (thesis in Education/Research, internship projects in that internship)
- Personal/hackathon projects without institutional context → Additional Experience
- Leadership shows soft skills that differentiate you from other new grads

```markdown
::: {.content-visible when-profile="en"}
{{< entry title="Senior Engineer" company="Google" dates="2021 - Present" loc="City, ST" >}}

* Led migration reducing costs by 30%
* Built pipeline handling 2M+ events/second
* Mentored 4 engineers, 2 promoted
:::
```

### Master (Extended/Complete Career Database)

The master version is your personal career repository. It's NOT sent to employers - it's a comprehensive document to pull from when creating targeted resumes.

- **Purpose:** Personal career archive, source for tailored resumes
- **Length:** 3-5+ pages (no limit)
- **Content:** ALL jobs, skills, certifications, projects, volunteer work ever
- **Bullets:** 4-8 per role with detailed sub-bullets
- **Details:** Technical specifics, tools, methodologies, team sizes, budgets
- **Additional Sections:**
  - Internships and Research positions
  - Publications and Talks
  - Awards and Recognition
  - Volunteering and Leadership
  - Professional Memberships
  - Languages
  - Expired Certifications
- **Update:** Every 3-6 months
- **Output:** `master.pdf`

```markdown
::: {.content-visible when-profile="en"}
{{< entry title="Senior Engineer" company="Google" dates="2021 - Present" loc="City, ST" >}}

* Led migration reducing costs by 30%
::: {.content-visible when-profile="master"}
  * Identified 12 bounded contexts from 500k LOC monolith
  * Implemented strangler fig pattern for zero-downtime migration
  * Established CI/CD with 85% test coverage
  * Tools: Kubernetes, Terraform, GitHub Actions, DataDog
:::
* Built pipeline handling 2M+ events/second
::: {.content-visible when-profile="master"}
  * Architected with Kafka and Flink for stream processing
  * Custom partitioning across 50+ nodes
  * Sub-millisecond latency at p99
  * Budget managed: $2M annually
:::
* Mentored 4 engineers, 2 promoted
:::
```

### Key Differences Table

| Aspect | Concise | Master |
|--------|---------|--------|
| Purpose | Send to employers | Personal archive |
| Length | 1-2 pages | 3-5+ pages |
| Content | Relevant only | Everything |
| Bullets | 3-4 per role | 4-8+ with sub-bullets |
| Details | High-level metrics | Technical specifics, tools |
| Update | Per application | Every 3-6 months |

---

## 9. Resume Section Order (New Grad/Junior)

For new grads, education is your biggest asset. Order recommended by Harvard and CMU:

1. **Contact Info** (Header)
2. **Education** (Top, right after header - your main asset as new grad)
3. **Experience** (Internships and entry-level jobs - most relevant first)
4. **Additional Experience and Leadership** (Research positions, teaching assistantships, personal/academic projects, extracurriculars, volunteer work)
5. **Skills** (grouped by category)
6. **Certifications** (if relevant)

**Critical Notes for New Grads:**
- **Projects belong IN the experience that generated them** - not as a separate section
  - Thesis/TCC project → Education or Research experience
  - Internship project → That internship entry
  - Personal/Hackathon project → Additional Experience and Leadership
- This avoids content duplication and shows context for each project
- Section 4 combines research, teaching, and leadership - showing both technical depth and soft skills
- Don't undervalue internships - a 3-month internship with impact is valuable experience

### Master (Career Database)

All sections from concise, plus:

7. Publications and Talks
8. Awards and Recognition
9. Professional Memberships
10. Languages
11. All Certifications (including expired)
12. Older/Archived Experience

---

## 10. The Impact Formula (Google XYZ)

Don't describe "responsibilities". Describe **impact**. Use Google's XYZ Formula:

> *"Accomplished [X] measured by [Y], by doing [Z]."*

- **X:** What you accomplished
- **Y:** Quantitative or qualitative result (numbers, %, $, time saved)
- **Z:** How you did it (technologies, strategies, methods)

**Transformation Example:**

- ❌ *Weak:* "Responsible for creating APIs in Java."
- ✅ *Strong:* "Reduced API response latency by 20% by refactoring legacy endpoints and implementing Redis caching in Java."

---

## 11. Action Verbs (Harvard)

Never start bullet points with "Worked on", "Helped", or "Responsible for". Use strong engineering verbs:

**Creation:** Engineered, Architected, Built, Developed, Implemented, Designed, Created

**Improvement:** Optimized, Refactored, Accelerated, Reduced, Enhanced, Streamlined

**Leadership:** Spearheaded, Mentored, Led, Orchestrated, Coordinated, Directed

---

## 12. Resume Section Content Guidelines

### Education

- University, Degree Title (e.g., B.S. in Computer Science), Graduation Date (Month/Year)
- **GPA:** Include only if high (generally above 3.0 or 3.5). If low, omit.
- **Coursework:** List 4-6 relevant courses (e.g., Data Structures, Algorithms, Distributed Systems) only if space allows

### Technical Skills

Group for readability. **Do NOT use progress bars or percentages** (e.g., "Java 90%"). Either you know it or you don't.

```markdown
**Languages:** Java, Python, C++, JavaScript, SQL
**Frameworks:** React, Spring Boot, Node.js, TensorFlow
**Tools:** Git, Docker, Kubernetes, AWS, Linux, Jenkins
```

### Experience

- Format: Job Title | Company | Location | Dates
- Use 3-5 bullet points per experience
- Apply XYZ formula rigorously
- If no formal experience, use Additional Experience for academic projects
- **Projects go as bullet points within relevant entries** - include tech stack and link to repo

**Project Integration Examples:**

```markdown
{{< entry title="Data Analytics Intern" company="Company" dates="2024" loc="City" >}}

* Built sales forecasting tool using Prophet, improving planning accuracy by 20%
* Created dashboards for 200+ users using Power BI

::: {.content-visible when-profile="master"}
  * Project: [repo-name](https://github.com/user/repo) - additional details
  * Tools: Python, Prophet, Power BI
:::
```

```markdown
{{< entry title="Thesis Project" company="University - Department" dates="2024 - 2025" loc="City" >}}

* Built sentiment analysis dashboard achieving 82% accuracy using BERTimbau
* Deployed demo: [project-name](https://github.com/user/project)
```

---

## 13. Resume Validation Checklist

Before submitting, verify these critical points:

- [ ] **10-Second Test:** Can a recruiter see your University, main programming languages, and last role in under 10 seconds?
- [ ] **Verb Filter:** Removed all passive occurrences ("helped", "participated") and replaced with active ("built", "led")?
- [ ] **Quantification:** At least 30-50% of bullet points contain numbers or metrics?
- [ ] **Consistency:** Dates all right-aligned? Date format consistent (e.g., "Jan 2024" or "01/2024")?
- [ ] **Link Check:** GitHub and LinkedIn links clickable in PDF?
- [ ] **ATS Test:** Single column layout? Standard fonts? No tables/graphics that confuse parsers?

---

# COVER LETTER GUIDELINES

## 14. Cover Letter YAML Frontmatter

```yaml
---
format: cover-letter-pdf
name: "Full Name"
contact:
  email: "email@example.com"
  phone: "+1 555-000-0000"
  location: "City, State"
  linkedin: "linkedin_username"
  github: "github_username"
date: "Month DD, YYYY"
recipient:
  name: "Recipient Name"
  title: "Hiring Manager"
  company: "Company Inc."
  address: "123 Street, City, ST 00000"
greeting: "Dear Mr./Ms. LastName,"
closing: "Sincerely,"
---
```

---

## 15. Cover Letter Structure (5-6 Paragraphs)

```markdown
Paragraph 1: Hook + Position + Brief Background

Paragraph 2: Key Achievement from Role A with metrics

Paragraph 3: Why This Company + What You Bring

Paragraph 4: Key Achievement from Role B with metrics

Paragraph 5: Call to Action + Availability + Contact

Paragraph 6: Thank You + Forward-looking Statement
```

---

## 16. Cover Letter Template

```markdown
---
format: cover-letter-pdf
name: "Name"
contact:
  email: "email@example.com"
  phone: "+1 555-000-0000"
  location: "City, ST"
  linkedin: "username"
  github: "username"
date: "Month DD, YYYY"
recipient:
  name: "Recipient Name"
  title: "Hiring Manager"
  company: "Company Inc."
  address: "123 Street, City, ST 00000"
greeting: "Dear Mr./Ms. LastName,"
closing: "Sincerely,"
---

::: {.content-visible when-profile="en"}

I am writing to express my interest in the [position] at [company]. With [X+ years] of experience [domain expertise], I am confident in my ability to contribute to [company's mission/goal].

During my tenure at [Company A], I [key achievement with metric]. I [another achievement with metric]. This experience has given me [skill/expertise] which aligns directly with [company's needs].

What draws me to [company] specifically is [reason showing research]. I am particularly excited about [specific project/initiative]. My background in [relevant skills] positions me well to [value proposition].

At [Company B], I [achievement with metric]. This experience taught me [lesson/skill]. I bring this same [quality] to every project I undertake.

I would welcome the opportunity to discuss how my skills align with [company's] needs. I am available for an interview at your convenience and can be reached at [email] or [phone].

Thank you for considering my application. I look forward to the possibility of contributing to [company's] continued success.

:::

::: {.content-visible when-profile="pt-BR"}

Escrevo para expressar meu interesse na posição de [cargo] no [empresa]. Com mais de [X anos] de experiência [área], estou confiante em minha capacidade de contribuir para [missão da empresa].

Durante minha atuação no [Empresa A], [conquista com métrica]. [outra conquista]. Esta experiência me proporcionou [habilidade] que se alinha com [necessidades da empresa].

O que me atrai especificamente ao [empresa] é [razão mostrando pesquisa]. Estou particularmente entusiasmado com [projeto/iniciativa]. Minha experiência em [habilidades] me posiciona bem para [proposta de valor].

No [Empresa B], [conquista com métrica]. Esta experiência me ensinou [lição]. Trago esse mesmo [qualidade] para cada projeto.

Agradeço a oportunidade de discutir como minhas habilidades se alinham com as necessidades do [empresa]. Estou disponível para uma entrevista conforme sua conveniência e posso ser contatado pelo email [email] ou telefone [telefone].

Agradeço sua consideração e aguardo a possibilidade de contribuir para o sucesso contínuo do [empresa].

:::
```

---

## 17. Cover Letter Rules

1. One page maximum (5-6 paragraphs)
2. Customize for each company (show research)
3. Quantify achievements (%, $, users, time)
4. Hook in first paragraph
5. Clear call to action
6. No raw LaTeX
7. Keep both language blocks synchronized
8. Mirror key achievements from resume

---

# GENERAL RULES

## 18. Design Rules Summary

- Quantify all achievements (%, $, time, users, team size, budget)
- Start bullets with action verbs (Led, Built, Designed, Implemented)
- No raw LaTeX or `&` in headings
- No graphics, standard fonts (ATS-friendly)
- Keep EN and PT-BR blocks synchronized
- Master content nested inside language blocks using `when-profile="master"`
- Master expands on concise (same base achievements, more technical detail)
- Master includes: tools used, team sizes, budgets managed, methodologies
- Concise: only include last 10-15 years of relevant experience
- Master: include ALL experience, even early career and unrelated roles
- Update master every 3-6 months, even when not job hunting

---

## 19. References

**Quarto Documentation:**
- https://quarto.org/docs/projects/profiles
- https://quarto.org/docs/extensions/

**Resume Guides:**
- [Harvard FAS - Create a Strong Resume](https://careerservices.fas.harvard.edu/resources/create-a-strong-resume/)
- [Google Resume Tips](https://www.google.com/about/careers/applications/videos/google-resume-tips-and-advice/)
- [Google - How to Review Resumes](https://rework.withgoogle.com/intl/en/guides/hiring-review-resumes)
- [Tech Interview Handbook - Resume](https://www.techinterviewhandbook.org/resume/)
- [Master Resume Guide - Teal](https://www.tealhq.com/post/how-to-create-a-master-resume)
