# R Workshop -- Day 7 -- Reproducible Research and Capstone Presentation

**Session 7 of 7 | Duration: 3 hours**
**Programme:** Applied R for Statistical Teaching, Research and Reproducible Analysis

## Learning objectives

By the end of this session you will be able to:

1. Organise a project into raw data, processed data, scripts, outputs and reports, documented with a README.
2. Build a Quarto report with YAML metadata, code-cell options and inline results.
3. Render the same report to HTML, Word and PDF.
4. Test a report in a clean R session and record session information.
5. Conduct a structured peer review using a short checklist.
6. Present a capstone analysis clearly in five minutes.

## Capstone link

Today integrates everything from Days 2-6 -- the cleaned dataset, the graphics, the inferential result and the diagnosed model -- into one reproducible report, and closes the workshop with the Day 1 baseline task repeated for comparison.

## Segment plan (3 hours)

| Segment | Time | Purpose |
| --- | ---: | --- |
| Opening and recap | 10 min | Recap the full capstone thread, Day 2 through Day 6 |
| Concept bridge | 25 min | Why reproducibility is a deliverable, not an afterthought |
| Guided coding | 60 min | Build and render the Quarto capstone report |
| Participant practice | 45 min | Integrate your own Days 2-6 artefacts into the template |
| Interpretation and reporting | 25 min | Peer review using the checklist |
| Evidence log and capstone update | 15 min | Repeat the Day 1 baseline task and present |

---

## Part 1 -- Concept bridge (Core workshop activity)

### Why reproducibility is a deliverable

A result that only runs on your machine, in your current R session, with objects you created interactively three days ago, is not yet a finished piece of work. Reproducibility means: a colleague (or you, in six months) can open the project, run one command, and get the same report -- numbers, figures and all -- without manual intervention.

### Project organisation

```text
your-capstone-project/
|-- your-capstone-project.Rproj
|-- Data/
|   |-- raw/
|   `-- processed/
|-- Scripts/
|-- Outputs/
|-- Reports/
|   `-- capstone-report.qmd
`-- README.md
```

Relative paths (`Data/raw/anchor_dataset.csv`, not `C:/Users/you/Desktop/...`) are what make this folder portable between machines -- the same principle from Day 1, now applied to a finished report.

### Quarto basics

A `.qmd` file has a YAML header (metadata: title, author, output formats) followed by Markdown text interleaved with executable code cells. Quarto is the modern successor to R Markdown and renders the same source to multiple output formats without changing the document.

---

## Part 2 -- Guided coding (Core workshop activity)

Open `Quarto-Template/capstone-report.qmd`.

### 2.1 YAML metadata

```yaml
---
title: "R Workshop Capstone Report"
author: "Participant name"
format:
  html: default
  docx: default
  pdf: default
execute:
  echo: true
  warning: false
  message: false
---
```

`format:` lists every output you want to render to. `execute:` options apply to every code cell unless overridden per-cell.

### 2.2 Code-cell options

```r
#| label: setup
#| echo: false
library(tidyverse)
```

`#| label:` names the cell (useful for cross-references and error messages); `#| echo: false` hides the code but still runs it and shows any output; `#| fig-cap:` adds a caption to a plot produced in that cell.

### 2.3 Figures, tables, equations and inline results

```r
#| label: fig-score-by-track
#| fig-cap: "Post-training score by training track"
lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
ggplot(lecturers, aes(x = training_track, y = post_score)) +
  geom_boxplot(fill = "#FEB24C") +
  theme_minimal()
```

Inline results, e.g. "the mean attendance was `` `r round(mean(lecturers$attendance, na.rm = TRUE), 1)` `` percent", insert a live-computed number directly into the prose -- so the number updates automatically if the data changes.

### 2.4 Rendering

```r
quarto::quarto_render("Reports/capstone-report.qmd")
```

or, from the terminal: `quarto render "Reports/capstone-report.qmd"`. This produces `.html`, `.docx` and `.pdf` versions in one step, all from the same source.

### 2.5 Testing in a clean session and recording `sessionInfo()`

Before considering a report finished, restart R (`Session -> Restart R` in RStudio) and re-render from scratch -- this catches any hidden dependency on an object that only exists because you ran something manually earlier. Always include:

```r
#| label: session-info
sessionInfo()
```

near the end of the report, so the exact package versions used are recorded alongside the results.

### 2.6 Peer review checklist

Exchange reports with a partner and check:

- [ ] Does the report render from a clean session without errors?
- [ ] Is the research question stated clearly in the first section?
- [ ] Are raw and processed data kept separate, with cleaning decisions documented?
- [ ] Does every figure have a title, labelled axes with units, and a caption?
- [ ] Is the inferential or model result reported with both a number and a plain-language sentence?
- [ ] Is `sessionInfo()` included?

---

## Part 3 -- Participant practice (Core workshop activity)

1. Copy your Day 2 cleaning script's output, your three Day 3 graphics, your Day 4 inferential result and your Day 5/6 model into `Quarto-Template/capstone-report.qmd`, replacing the placeholder text in each section.
2. Render to HTML, Word and PDF (or note in the report if a particular renderer is unavailable on your machine).
3. Restart R and re-render once more to confirm the report is reproducible from a clean session.
4. Exchange reports with a partner and complete the peer-review checklist for each other's report.
5. Repeat the Day 1 baseline task on `Data/raw/day7_baseline_sample.csv` and add a short final section comparing your Day 1 and Day 7 work.
6. Prepare a five-minute presentation: research question, one figure, one result, one limitation.

A facilitator-reviewed, fully completed example report is in `Solution-Scripts/day7_capstone_report_solution.qmd`.

---

## Optional demonstration

- **Confidential-data handling** -- never commit raw participant-identifiable data to a shared repository; demonstrate `.gitignore` patterns and anonymisation as a brief discussion, not a hands-on exercise.
- **Multi-format formatting differences** -- show how the same Quarto source renders slightly differently in HTML versus PDF (e.g. figure sizing, table wrapping) and how to use format-specific code-cell options to handle this.
- **Advanced Quarto options** -- cross-references (`@fig-...`), citations (`.bib` files), parameterised reports.

---

## Reference or take-home material

- Troubleshooting rendering problems: missing LaTeX packages for PDF output, missing pandoc for Word output, encoding issues with special characters.
- A report-polishing checklist for after the workshop: consistent figure styling, a finalised abstract/summary, spell-checked prose.

---

## Daily deliverable

A rendered, reproducible capstone report (HTML, Word and/or PDF) and a five-minute presentation.

### Evidence log entry

Complete the Day 7 row in `Workshop-Evidence-Log.md`. Fill in the pre/post assessment task comparison: how did your Day 7 baseline-task script differ from your Day 1 version, and what does that difference show about your progress through the workshop?

---

## Facilitator notes

- Day 7 is for integration and presentation, not for starting new analysis -- if a participant has not completed earlier days' deliverables, help them integrate what exists rather than trying to backfill missing work live.
- PDF rendering depends on a working LaTeX installation; confirm this in advance, and have HTML as a guaranteed fallback format for every participant.
- Keep presentations strictly timed at five minutes; this is itself a transferable skill (communicating a result to a non-specialist audience under a hard time constraint), not just a logistics choice.
