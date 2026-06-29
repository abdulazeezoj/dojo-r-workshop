# R Workshop -- Day 4 -- Probability, Sampling, Simulation and Inference

**Session 4 of 7 | Duration: 3 hours**
**Programme:** Applied R for Statistical Teaching, Research and Reproducible Analysis

## Learning objectives

By the end of this session you will be able to:

1. Use the `d`/`p`/`q`/`r` distribution-function pattern for at least the normal and binomial distributions.
2. Set a random seed and explain why it matters for reproducible simulation.
3. Run a simulation experiment and demonstrate the Central Limit Theorem with repeated sampling.
4. Estimate and interpret a confidence interval in plain language.
5. Choose an appropriate test based on study design and run it on the anchor dataset.
6. Report statistical and practical significance without overstating certainty.

## Capstone link

Today produces one inferential answer to your capstone research question: typically, whether post-training scores improved relative to pre-training scores, and/or whether scores differ between two groups (e.g. completers versus non-completers).

## Segment plan (3 hours)

| Segment | Time | Purpose |
| --- | ---: | --- |
| Opening and recap | 10 min | Recap Day 3 graphics, preview today's inferential question |
| Concept bridge | 25 min | Probability functions, sampling variation, the CLT |
| Guided coding | 60 min | Simulation, confidence interval, one hypothesis test |
| Participant practice | 45 min | Run inference on the anchor dataset |
| Interpretation and reporting | 25 min | Plain-language statistical reporting |
| Evidence log and capstone update | 15 min | Save the inference notebook/script |

---

## Part 1 -- Concept bridge (Core workshop activity)

### The `d`/`p`/`q`/`r` pattern

Every distribution in R follows a naming convention, illustrated for the normal distribution:

| Prefix | Meaning | Example |
| --- | --- | --- |
| `d` | density (height of the curve at x) | `dnorm(70, mean = 65, sd = 10)` |
| `p` | cumulative probability, P(X <= x) | `pnorm(70, mean = 65, sd = 10)` |
| `q` | quantile, the x for a given cumulative probability | `qnorm(0.95, mean = 65, sd = 10)` |
| `r` | random draws from the distribution | `rnorm(10, mean = 65, sd = 10)` |

The same four letters apply to `binom` (binomial), `unif` (uniform), `t` (t-distribution), and others.

### Why `set.seed()`

```r
set.seed(2024)
rnorm(3)
```

Running the line above twice with the same seed gives the same three numbers. Without `set.seed()`, every run of a simulation differs, which makes results impossible to check or reproduce. Set the seed once, near the top of the script, before the first random draw.

### Sampling variation and the Central Limit Theorem (CLT)

A single sample mean is one estimate of the population mean; a different sample would give a different estimate. The CLT says that, as sample size grows, the distribution of the *sample mean* across repeated samples becomes approximately normal, regardless of the shape of the original population -- which is why so much of classical inference relies on the normal distribution.

---

## Part 2 -- Guided coding (Core workshop activity)

```r
library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
set.seed(2024)
```

### 2.1 One simulation experiment

```r
# Simulate 1,000 lecturers' post-training scores under an assumed
# population mean of 65 and sd of 12, purely to see typical sample noise.
simulated_scores <- rnorm(1000, mean = 65, sd = 12)
mean(simulated_scores)
sd(simulated_scores)
hist(simulated_scores, main = "Simulated post-training scores", xlab = "Score")
```

### 2.2 Demonstrating the CLT with repeated samples

```r
sample_means <- replicate(2000, {
  one_sample <- sample(lecturers$post_score[!is.na(lecturers$post_score)], size = 30)
  mean(one_sample)
})

hist(sample_means, main = "Distribution of sample means (n = 30, 2000 repeats)",
     xlab = "Sample mean post-training score")
sd(sample_means) # the standard error, empirically
```

Compare `sd(sample_means)` to `sd(lecturers$post_score, na.rm = TRUE) / sqrt(30)` -- the two should be close, which is the CLT's standard-error formula made concrete.

### 2.3 One confidence interval

```r
post_scores <- lecturers$post_score[!is.na(lecturers$post_score)]
n <- length(post_scores)
sample_mean <- mean(post_scores)
sample_se <- sd(post_scores) / sqrt(n)

ci_lower <- sample_mean - qt(0.975, df = n - 1) * sample_se
ci_upper <- sample_mean + qt(0.975, df = n - 1) * sample_se
c(ci_lower, ci_upper)

# Or, directly from a t-test:
t.test(post_scores)$conf.int
```

**Plain-language template:** "We are 95% confident that the true mean post-training score for the population this sample represents lies between `ci_lower` and `ci_upper`."

### 2.4 Selecting and running one test

Test choice follows study design, not habit:

| Design | Typical test |
| --- | --- |
| One numeric variable vs. a fixed value | One-sample t-test |
| Same individuals measured twice (pre/post) | Paired t-test |
| Two independent groups, one numeric outcome | Independent (two-sample) t-test |
| Two categorical variables | Chi-square test of independence |

For the capstone question -- did scores improve from pre- to post-training -- the design is paired:

```r
paired_data <- lecturers %>% filter(!is.na(pre_score), !is.na(post_score))

t.test(paired_data$post_score, paired_data$pre_score, paired = TRUE)
```

### 2.5 Reporting statistical and practical significance

```r
paired_result <- t.test(paired_data$post_score, paired_data$pre_score, paired = TRUE)
mean_gain <- mean(paired_data$post_score - paired_data$pre_score)
```

**Reporting template:** "Post-training scores were on average `mean_gain` points higher than pre-training scores (paired t-test, t = ..., df = ..., p = ...). This difference is [statistically significant / not statistically significant] at the 5% level, and represents a [meaningful / modest] practical gain on a 0-100 scale."

Statistical significance (a small p-value) and practical significance (a gain large enough to matter to a lecturer or programme manager) are different claims -- report both.

---

## Part 3 -- Participant practice (Core workshop activity)

1. Compute a 95% confidence interval for mean attendance.
2. Run the paired t-test for pre- versus post-training scores and write the plain-language sentence above with your actual numbers filled in.
3. Choose one additional comparison relevant to your research question (e.g. post-training score for completers versus non-completers, an independent two-sample t-test) and run it.
4. For your chosen test, check at least one assumption informally (e.g. a histogram or `qqnorm()` of the relevant variable) and note any concern in a comment.
5. Save your code and your written interpretation as `Outputs/day4_inference_notebook.R` (or an `.Rmd`/`.qmd` if you prefer).

A facilitator-reviewed solution is in `Solution-Scripts/day4_inference_solution.R`.

---

## Optional demonstration

- **Coverage simulation** -- repeat the confidence-interval calculation across many simulated samples and check what proportion actually contain the true mean (should be close to 95%).
- **Chi-square and Fisher's exact test** -- e.g. is `completed` associated with `training_track`?
- **Non-parametric alternatives** -- Wilcoxon signed-rank test as a paired-t-test alternative when normality is doubtful.
- **Effect-size calculations** -- Cohen's d via the `effectsize` package.
- **Additional CLT demonstrations** -- repeat Part 2.2 with a clearly skewed variable (e.g. `years_teaching`) to show the CLT still holds for the *sample mean* even when the raw variable is not normal.

```r
# Optional: chi-square test of independence
chisq.test(table(lecturers$completed, lecturers$training_track))
```

---

## Reference or take-home material

- Assumption checklists for the t-test family (independence, approximate normality of the relevant quantity, for two-sample tests: variance assumptions and Welch's correction).
- A short template for reporting a p-value and confidence interval consistently across the rest of the workshop.

---

## Daily deliverable

A short inference notebook or script (`Outputs/day4_inference_notebook.R` or equivalent) that answers one inferential question linked to the capstone research question, with a plain-language interpretation.

### Evidence log entry

Complete the Day 4 row in `Workshop-Evidence-Log.md`: state your inferential result and whether it supports, contradicts, or is inconclusive about your initial impression from the Day 3 graphics.

---

## Facilitator notes

- The paired t-test on `pre_score`/`post_score` should show a positive, statistically significant gain by construction of the synthetic dataset -- use this as your answer key for spot-checking participants' work.
- Watch for participants computing a confidence interval or t-test on a column that still contains `NA` without filtering first; `t.test()` will error or silently drop rows depending on the call, so this is worth flagging explicitly.
- If a participant chooses chi-square as their "one additional comparison," that is acceptable even though it is listed as optional demonstration -- the boundary exists for time management, not as a hard rule.
