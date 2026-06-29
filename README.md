# R Workshop

Applied R for Statistical Teaching, Research and Reproducible Analysis.

This repository is organised as a workshop distribution package for a seven-day R programme for Statistics lecturers. The materials are designed as a set of guided live sessions supported by deeper reference workbooks.

## Delivery principles

- Treat each three-hour session as guided instruction, not as a requirement to complete every workbook page live.
- Label workbook sections as **Core workshop activity**, **Optional demonstration**, or **Reference/take-home material**.
- Use one **anchor dataset** from Day 2 through Day 7 so participants clean, explore, infer from, model, examine and publish one coherent analysis.
- Start the capstone on Day 2 and reserve Day 7 for integration, rendering, peer review and presentation.
- Use the evidence log to document daily artefacts, participant checks, peer checks and capstone progress.

## Repository structure

```text
R-Workshop/
├── Curriculum/
│   ├── R Workshop - Curriculum.md
│   ├── R Workshop - Curriculum.tex
│   └── R Workshop - Curriculum.pdf
├── Materials/
│   └── README.md
├── Data/
│   ├── README.md
│   ├── raw/
│   └── processed/
├── Starter-Scripts/
│   └── day2_anchor_cleaning.R
├── Solution-Scripts/
│   └── README.md
├── Quarto-Template/
│   └── capstone-report.qmd
├── install_packages.R
├── Workshop-Evidence-Log.md
└── README.md
```

## Critical release checklist

- [ ] Recover or recreate Day 3 LaTeX source.
- [ ] Recover or recreate Day 5 LaTeX source.
- [ ] Update the Day 2 complete cleaning script so it includes invalid pre-score and post-score handling.
- [ ] Confirm one anchor dataset is used across Days 2--7.
- [ ] Mark all workbook sections as Core, Optional demonstration, or Reference/take-home material.
- [ ] Add `rmarkdown` and `knitr` to setup requirements.
- [ ] Compile all LaTeX sources from a clean environment.
- [x] Provide practical curriculum in Markdown, LaTeX and PDF formats.
- [ ] Render the Quarto capstone template to HTML, Word and PDF.

## Setup

Run the package installer before the workshop:

```r
source("install_packages.R")
```

The installer includes `rmarkdown` and `knitr` because they are required for common R-backed Quarto and R Markdown rendering workflows.
