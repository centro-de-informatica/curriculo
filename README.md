# CV Profissional e Carta de Apresentação

Extensões Quarto para currículo em PDF estilo FAANG e carta de apresentação, projetadas para recém-formados e engenheiros juniores (0–2 anos de experiência).

Baseado em guias oficiais de Harvard, Google, CMU, Stanford e Tech Interview Handbook.

## Recursos

- **Currículo de uma página compatível com ATS** com layout limpo e profissional
- **Suporte multilíngue** (inglês e português)
- **Versões Concisa e Mestre** — currículo direcionado para candidaturas + base de carreira completa
- **Modelo de carta de apresentação** com design correspondente
- **Perfis Quarto** para configuração de build simplificada

## Estrutura do Projeto

```
├── resume.qmd              # Currículo (EN + PT-BR, concise + master)
├── cover-letter.qmd        # Carta de apresentação (EN + PT-BR)
├── _quarto.yml             # Configuração base + grupos de perfis
├── _quarto-{en,pt-BR}.yml  # Configurações de idioma
├── _quarto-{concise,master}.yml  # Configurações de versão
├── _extensions/
│   ├── professional-cv/    # Formato do currículo
│   └── cover-letter/       # Formato da carta de apresentação
└── _output/                # PDFs gerados
    ├── en/
    └── pt-BR/
```

## Build

```bash
# Inglês
quarto render --profile en,concise    # resume.pdf, cover-letter.pdf
quarto render --profile en,master     # master.pdf

# Português
quarto render --profile pt-BR,concise # resume.pdf, cover-letter.pdf
quarto render --profile pt-BR,master  # master.pdf

# Arquivo único
quarto render resume.qmd --profile en,concise
quarto render cover-letter.qmd --profile pt-BR,concise
```

## Saída

```
_output/
├── en/
│   ├── resume.pdf
│   ├── master.pdf
│   └── cover-letter.pdf
└── pt-BR/
    ├── resume.pdf
    ├── master.pdf
    └── cover-letter.pdf
```

## Concisa vs Mestre

| Versão | Propósito | Extensão | Conteúdo |
|--------|----------|--------|---------|
| **Concisa** | Candidaturas | 1 página | Direcionado, conquistas em alto nível |
| **Mestre** | Arquivo pessoal | 3–5+ páginas | Tudo — todos empregos, habilidades, projetos |

Use blocos condicionais em arquivos `.qmd`:

```markdown
* Conquista principal visível em ambas as versões

::: {.content-visible when-profile="master"}
* Detalhes adicionais apenas na versão master
:::
```

## Requisitos

- Quarto >= 1.3.0
- XeLaTeX (recomenda-se TeX Live)

