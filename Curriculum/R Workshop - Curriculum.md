# R Workshop: Practical Curriculum

**Programme:** Applied R for Statistical Teaching, Research and Reproducible Analysis  
**Audience:** Statistics lecturers and academic staff who need to teach, analyse and report with R  
**Format:** Seven guided sessions, three hours each, supported by reference workbooks and independent capstone work

## 1. Curriculum promise

This is not a race through seven dense manuals. The workshop uses the full workbooks as a lasting reference handbook, while the live sessions focus on the essential tasks participants need in order to build one coherent analysis.

The workshop will briefly revisit statistical theory where necessary to connect equations, assumptions and interpretation to their implementation in R. It will not attempt to reteach an entire statistics degree, nor will it become a machine-learning or Shiny course.

## 2. Delivery model

Each workbook section should be labelled in the teaching copy as one of the following.

| Label | Meaning | Live-session expectation |
| --- | --- | --- |
| Core workshop activity | Essential skill or concept needed for the daily deliverable and capstone | Teach and practise during the three-hour session |
| Optional demonstration | Useful extension if the group is fast or the facilitator wants to show breadth | Demonstrate briefly or skip |
| Reference or take-home material | Valuable background, extra methods or fuller explanations | Assign for independent study |

A realistic three-hour session should include approximately:

| Segment | Time | Purpose |
| --- | ---: | --- |
| Opening and recap | 10 minutes | Reconnect with the anchor dataset and prior deliverable |
| Concept bridge | 25 minutes | Explain the statistical or reproducibility idea |
| Guided coding | 60 minutes | Work through the core R workflow |
| Participant practice | 45 minutes | Apply the workflow to the anchor dataset |
| Interpretation and reporting | 25 minutes | Translate outputs into statistical language |
| Evidence log and capstone update | 15 minutes | Save artefacts and plan next steps |

## 3. Anchor dataset and capstone thread

Use one anchor dataset from Day 2 through Day 7. Demonstration datasets may still appear, but they must be labelled as demonstration datasets and should not replace the capstone thread.

| Day | Capstone progress |
| --- | --- |
| Day 1 | Confirm software setup and complete a baseline task |
| Day 2 | Select a research question, clean the anchor dataset and document variables |
| Day 3 | Produce exploratory figures and write initial observations |
| Day 4 | Perform one inferential analysis linked to the research question |
| Day 5 | Fit and diagnose the principal statistical model |
| Day 6 | Recreate or examine part of the model from its equation |
| Day 7 | Integrate, render, peer-review and present the report |

By the start of Day 7, every participant should already have a cleaned dataset, a defined research question, at least two visualisations, one inferential result or model and draft interpretations.

## 4. Assessment and evidence

Assessment is evidence-based and practical. Participants maintain a workshop evidence log with four checks: evidence produced, participant check, peer check and capstone update.

The same short task should be attempted on Day 1 and repeated on Day 7 with an equivalent dataset:

1. Import a small dataset.
2. Identify missing or invalid values.
3. Produce one numerical summary and one labelled plot.
4. Write three sentences interpreting the result for a non-technical reader.
5. Save the script, output and interpretation in the project folder.

## 5. Curriculum at a glance

| Day | Session title | Core live focus | Daily deliverable | Capstone link |
| --- | --- | --- | --- | --- |
| 1 | Getting Comfortable with R | RStudio projects, assignment, vectors, indexing, missing values, data frames, descriptive statistics and reading error messages | Working R project and first script | Baseline task and software readiness |
| 2 | Importing, Cleaning and Preparing Data | Import, inspect, flag invalid values, standardise categories, handle missingness, remove duplicates, export clean data | Clean anchor dataset, data-quality report and data dictionary | Research question, cleaned data and variable documentation |
| 3 | Exploratory Data Analysis and Statistical Graphics | Question-led plot choice, bar charts, histograms, box plots, scatter plots, labels, themes, export and interpretation | Three interpreted graphics | Initial visual evidence for the capstone |
| 4 | Probability, Sampling, Simulation and Inference | `d/p/q/r` functions, `set.seed()`, one simulation, one CLT demonstration, one confidence interval, test selection and plain-language reporting | Inference or simulation notebook | One inferential answer to the capstone question |
| 5 | Regression, ANOVA and Generalised Linear Models | Formula notation, multiple linear regression, categorical predictors, one interaction, diagnostics, one-way ANOVA and reporting | Diagnosed model report | Principal model for the capstone |
| 6 | Coding Statistical Models from Their Equations | Matrix operations, design matrices, OLS derivation, custom function, validation against `lm()` and one numerical failure mode | Equation-based implementation | Mathematical audit of part of the model |
| 7 | Reproducible Research and Capstone Presentation | Project organisation, Quarto basics, code-cell options, multi-format rendering, clean-session checks, peer review and presentations | Reproducible final report | Integrated capstone report and presentation |

## 6. Day-by-day teaching plan

### Day 1: Getting Comfortable with R

**Purpose:** Build confidence with R as a calculator, programming language and statistical working environment.

**Core workshop activity**

- Distinguish R, RStudio, scripts and the console.
- Create an RStudio project and use relative paths.
- Use assignment, object names and comments.
- Create and inspect vectors.
- Use indexing and logical conditions.
- Represent and handle missing values with `NA` and `na.rm`.
- Create simple data frames.
- Compute means, medians, standard deviations and simple grouped summaries.
- Read common error messages and use help.

**Optional demonstration**

- Matrices and basic matrix operations.
- Factors beyond simple category labels.
- Lists and detailed storage-type discussion using `typeof()`.

**Reference or take-home material**

- Extended debugging examples.
- More practice with subsetting and data structures.

**Daily deliverable:** A project folder containing a script that creates objects, summarises a small dataset and records the Day 1 baseline task.

### Day 2: Importing, Cleaning and Preparing Data

**Purpose:** Turn messy raw data into a documented analysis-ready dataset.

**Core workshop activity**

- Import CSV data with `readr`.
- Keep raw data unchanged and create a separate working object.
- Inspect structure, names, ranges and missingness before transforming.
- Flag invalid age, attendance, satisfaction, pre-test score and post-test score values.
- Standardise category labels.
- Identify and resolve duplicates.
- Produce a data-quality report and missingness report.
- Create a short data dictionary.
- Export clean data to `Data/processed/`.

**Optional demonstration**

- Reshaping with `pivot_longer()` and `pivot_wider()`.
- Importing Excel, SPSS, Stata and SAS files.

**Reference or take-home material**

- Audit trails for cleaning decisions.
- More examples of validation rules.

**Daily deliverable:** Clean anchor dataset, data-quality report, missingness report and data dictionary.

### Day 3: Exploratory Data Analysis and Statistical Graphics

**Purpose:** Choose graphics from research questions and interpret visual evidence responsibly.

**Core workshop activity**

- Start with a research question rather than a chart type.
- Use the grammar of graphics: data, aesthetics, geoms, scales, labels and themes.
- Make and interpret bar charts, histograms, box plots and scatter plots.
- Add clear titles, axis labels and units.
- Export publication-ready graphics.
- Write cautious visual claims that do not overstate causality.

**Optional demonstration**

- Density plots and violin plots, including warnings for small samples.
- Two-way categorical graphics.
- Faceting and annotations.
- Missing-data visualisation.
- Honest versus misleading graphics.

**Reference or take-home material**

- Theme customisation.
- Multiple annotation approaches.

**Daily deliverable:** Three exported graphics from the anchor dataset, each with a two- or three-sentence interpretation.

### Day 4: Probability, Sampling, Simulation and Inference

**Purpose:** Connect probability models, sampling variation and inferential reporting in R.

**Core workshop activity**

- Use the `d`, `p`, `q` and `r` distribution-function pattern.
- Set random seeds for reproducible simulation.
- Run one simulation experiment.
- Demonstrate the Central Limit Theorem with repeated samples.
- Estimate and interpret one confidence interval.
- Select a test based on study design.
- Run one independent or paired test on the anchor dataset.
- Report statistical and practical significance in plain language.

**Optional demonstration**

- Coverage simulation.
- Chi-square and Fisher's exact tests.
- Non-parametric alternatives.
- Detailed effect-size calculations.
- Additional theorem demonstrations.

**Reference or take-home material**

- Assumption checks for multiple tests.
- Templates for reporting p-values and confidence intervals.

**Daily deliverable:** A short inference notebook or script answering one capstone question.

### Day 5: Regression, ANOVA and Generalised Linear Models

**Purpose:** Fit, diagnose and report a model that addresses a statistical question.

**Core workshop activity**

- Translate a research question into formula notation.
- Fit and interpret a multiple linear regression model.
- Include categorical predictors and explain reference categories.
- Fit and interpret one interaction.
- Check residuals, fitted values and influential observations.
- Run and interpret a one-way ANOVA where appropriate.
- Report coefficients, uncertainty and model limitations.

**Optional demonstration**

- Logistic regression.
- Poisson regression.
- Nested-model comparison.
- Advanced influence measures.
- Two-way ANOVA if time allows.

**Reference or take-home material**

- Model-selection cautions.
- Post-hoc comparison examples.

**Daily deliverable:** Diagnosed model report for the capstone dataset.

### Day 6: Coding Statistical Models from Their Equations

**Purpose:** Show how model equations become matrix calculations and reusable R code.

**Core workshop activity**

- Read statistical notation and identify dimensions.
- Build a design matrix.
- Derive and compute ordinary least squares estimates.
- Calculate fitted values and residuals.
- Implement a small custom OLS function.
- Validate the function against `lm()`.
- Discuss one numerical failure mode such as rank deficiency or poor conditioning.

**Important implementation note:** The first custom OLS function should either assume an intercept explicitly or reject interceptless formulas with a clear error. R-squared, degrees of freedom and the overall F-test require adjustment when there is no intercept.

**Optional demonstration**

- Bootstrap uncertainty.
- Maximum likelihood.
- Detailed conditioning analysis.
- Extended inference calculations.

**Reference or take-home material**

- QR-based fitting and why explicit matrix inversion is usually avoided.
- Interceptless-model extensions.

**Daily deliverable:** Equation-based implementation that reproduces or audits part of the Day 5 model.

### Day 7: Reproducible Research and Capstone Presentation

**Purpose:** Convert the analysis into a reproducible report and communicate it clearly.

**Core workshop activity**

- Organise projects into raw data, processed data, scripts, outputs and reports.
- Use relative paths and document the project with a README.
- Create a Quarto report with YAML metadata.
- Use code-cell options for readable output.
- Include figures, tables, equations and inline results.
- Render to HTML, Word and PDF where tools are available.
- Test the report in a clean session.
- Include `sessionInfo()`.
- Conduct peer review with a short checklist.
- Present the capstone in five minutes.

**Optional demonstration**

- Confidential-data handling.
- Multi-format formatting differences.
- Advanced Quarto options.

**Reference or take-home material**

- Troubleshooting rendering problems.
- Report-polishing checklist.

**Daily deliverable:** Rendered capstone report and short presentation.

## 7. Minimum package requirements

The final distribution includes:

```text
dojo-r-workshop/
|-- Curriculum/
|   |-- R Workshop - Curriculum.md
|   |-- R Workshop - Curriculum.tex
|   `-- R Workshop - Curriculum.pdf
|-- Materials/
|   |-- Day 1/
|   |   |-- R Workshop - Day 1 - Getting Comfortable with R.md
|   |   |-- ... .tex
|   |   `-- ... .pdf
|   |-- Day 2/  (Importing, Cleaning and Preparing Data)
|   |-- Day 3/  (Exploratory Data Analysis and Statistical Graphics)
|   |-- Day 4/  (Probability, Sampling, Simulation and Inference)
|   |-- Day 5/  (Regression, ANOVA and Generalised Linear Models)
|   |-- Day 6/  (Coding Statistical Models from Their Equations)
|   `-- Day 7/  (Reproducible Research and Capstone Presentation)
|-- Data/
|   |-- raw/
|   |   |-- anchor_dataset.csv
|   |   |-- day1_baseline_sample.csv
|   |   `-- day7_baseline_sample.csv
|   `-- processed/  (created by Day 2 pipeline; not committed)
|-- Starter-Scripts/
|   |-- day1_baseline.R
|   |-- day2_anchor_cleaning.R
|   |-- day3_eda.R
|   |-- day4_inference.R
|   |-- day5_regression.R
|   `-- day6_manual_ols.R
|-- Final-Scripts/
|   |-- day1_final.R  ...  day7_final.R  (complete guided-coding code, one per day)
|-- Solution-Scripts/
|   |-- day1_practice_solution.R
|   |-- day2_anchor_cleaning_solution.R
|   |-- day3_eda_solution.R
|   |-- day4_inference_solution.R
|   |-- day5_regression_solution.R
|   |-- day6_manual_ols_solution.R
|   `-- day7_capstone_report_solution.qmd
|-- Quarto-Template/
|   `-- capstone-report.qmd
|-- install_packages.R
|-- Workshop-Evidence-Log.md
`-- README.md
```

Each `Materials/Day N/` folder holds the matching `.md`, `.tex` and `.pdf` for that day, named `R Workshop - Day N - <Title>`. All seven days' sources compile cleanly from the workbook `.md` files using the shared pandoc + LaTeX template.

## 8. Facilitator checklist

- Confirm R, RStudio and required R packages (`install_packages.R`) are installed.
- Confirm the Quarto CLI is installed separately for Day 7 (the `quarto` R package alone is not sufficient); have HTML as a fallback output format if PDF rendering via LaTeX is not available.
- Confirm the anchor dataset and both baseline samples are available in `Data/raw/`.
- Confirm each workbook section is labelled Core, Optional demonstration or Reference/take-home material.
- Confirm the Day 2 cleaning pipeline creates all promised outputs in `Data/processed/`.
- Confirm Day 7 is used for integration and presentation, not for starting the capstone.
- Confirm participants complete the evidence log each day.
