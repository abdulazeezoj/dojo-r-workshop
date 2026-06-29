# R Workshop -- Day 5 -- Regression, ANOVA and Generalised Linear Models

**Session 5 of 7 | Duration: 3 hours**
**Programme:** Applied R for Statistical Teaching, Research and Reproducible Analysis

## Learning objectives

By the end of this session you will be able to:

1. Translate a research question into R formula notation.
2. Fit and interpret a multiple linear regression model with `lm()`.
3. Include categorical predictors and correctly explain the reference category.
4. Fit and interpret one interaction term.
5. Check residuals, fitted values and influential observations.
6. Run and interpret a one-way ANOVA where appropriate.
7. Report coefficients, uncertainty and model limitations in plain language.

## Capstone link

Today you fit the **principal statistical model** for your capstone: a regression of post-training score on pre-training score, attendance and training track (with an interaction), directly answering the Day 2 research question.

## Segment plan (3 hours)

| Segment | Time | Purpose |
| --- | ---: | --- |
| Opening and recap | 10 min | Recap Day 4 inference, preview today's model |
| Concept bridge | 25 min | Formula notation, what a coefficient means |
| Guided coding | 60 min | Fit, extend and diagnose a regression model |
| Participant practice | 45 min | Fit, interpret and diagnose the capstone model |
| Interpretation and reporting | 25 min | Report coefficients and limitations |
| Evidence log and capstone update | 15 min | Save the diagnosed model report |

---

## Part 1 -- Concept bridge (Core workshop activity)

### Formula notation

`lm(post_score ~ pre_score + attendance + training_track, data = lecturers)` reads as: model `post_score` as a function of `pre_score`, `attendance` and `training_track`. The left-hand side is the outcome; the right-hand side lists predictors separated by `+`. An interaction between two predictors is written `a:b`, or `a*b` as shorthand for `a + b + a:b`.

### What a coefficient means

For a numeric predictor, the coefficient is the expected change in the outcome for a one-unit increase in that predictor, holding other predictors in the model constant. For a categorical predictor, R picks one level as the **reference category** (by default, the first alphabetically) and reports every other level's coefficient as a difference *from that reference*, holding other predictors constant.

---

## Part 2 -- Guided coding (Core workshop activity)

```r
library(tidyverse)
library(broom)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE) %>%
  mutate(training_track = factor(training_track, levels = c("Online", "In-Person", "Blended")))
```

Setting the factor levels explicitly fixes the reference category at "Online" rather than leaving it to alphabetical order, and documents the choice.

### 2.1 Multiple linear regression

```r
model_main <- lm(post_score ~ pre_score + attendance + training_track, data = lecturers)
summary(model_main)
tidy(model_main, conf.int = TRUE)
```

**Reading the output:** the intercept is the predicted post-score for an Online participant with `pre_score = 0` and `attendance = 0` -- rarely meaningful on its own, but necessary algebraically. The `training_trackIn-Person` and `training_trackBlended` coefficients are the expected score difference for those tracks *relative to Online*, holding pre-score and attendance fixed.

### 2.2 One interaction

```r
model_interaction <- lm(post_score ~ pre_score + attendance * training_track, data = lecturers)
summary(model_interaction)
```

The interaction `attendance:training_track` asks: does the *effect of attendance* on post-score differ by track? Compare `model_main` and `model_interaction` with `anova(model_main, model_interaction)` to see whether the interaction earns its place in the model.

```r
anova(model_main, model_interaction)
```

### 2.3 Diagnostics

```r
par(mfrow = c(2, 2))
plot(model_main)
par(mfrow = c(1, 1))
```

Read the four panels as: residuals vs fitted (look for curvature -- a violation of linearity), Q-Q plot (look for departure from the line -- non-normal residuals), scale-location (look for a fan shape -- non-constant variance), and residuals vs leverage (look for points outside Cook's distance contours -- influential observations).

```r
influence_check <- augment(model_main) %>%
  arrange(desc(.cooksd)) %>%
  select(.rownames, .cooksd) %>%
  head(5)
influence_check
```

### 2.4 One-way ANOVA

```r
anova_track <- aov(post_score ~ training_track, data = lecturers)
summary(anova_track)
```

A one-way ANOVA on `post_score ~ training_track` tests whether mean post-score differs across the three tracks, ignoring `pre_score` and `attendance`. It answers a narrower question than the regression model above, and is appropriate when you genuinely only care about one categorical factor.

### 2.5 Reporting

**Reporting template:** "Controlling for pre-training score and attendance, [In-Person/Blended] participants scored on average `coefficient` points [higher/lower] than Online participants (95% CI: `lower` to `upper`, p = `p_value`). The model explained `r.squared` of the variance in post-training scores. [Note any diagnostic concern, e.g. one influential observation flagged by Cook's distance.]"

```r
glance(model_main)$r.squared
```

---

## Part 3 -- Participant practice (Core workshop activity)

1. Fit `model_main` and `model_interaction` on your own copy of the cleaned anchor dataset.
2. Write, in plain language, what the `training_track` coefficients mean relative to your chosen reference category.
3. Run the four-panel diagnostic plot and note, in a comment, anything that concerns you (or confirms the model is reasonable).
4. Identify the single most influential observation by Cook's distance and decide, with a one-sentence justification, whether it should be investigated further or left in the model.
5. Run the one-way ANOVA on `training_track` alone and compare its conclusion to the regression's `training_track` coefficients.
6. Save a short written model report (`Outputs/day5_model_report.md` or `.R` with comments) covering points 1-5.

A facilitator-reviewed solution is in `Solution-Scripts/day5_regression_solution.R`.

---

## Optional demonstration

- **Logistic regression** -- model `completed` (Yes/No) with `glm(completed_numeric ~ ..., family = binomial)`.
- **Poisson regression** -- for count outcomes, if a suitable variable is available or simulated.
- **Nested-model comparison** -- `anova(model_a, model_b)` beyond the one interaction already shown.
- **Advanced influence measures** -- DFBETAS, DFFITS via `car::influence.measures()`.
- **Two-way ANOVA** -- `aov(post_score ~ training_track * institution_type, data = lecturers)`, if time allows.

```r
# Optional: logistic regression on completion
lecturers_glm <- lecturers %>% mutate(completed_numeric = if_else(completed == "Yes", 1, 0))
model_logit <- glm(completed_numeric ~ attendance + satisfaction, data = lecturers_glm, family = binomial)
summary(model_logit)
```

---

## Reference or take-home material

- Model-selection cautions: do not chase the highest R-squared by adding every available variable; justify each predictor from the research question.
- Post-hoc comparison examples: `emmeans::emmeans(anova_track, pairwise ~ training_track)` for pairwise track comparisons after a significant ANOVA.

---

## Daily deliverable

A diagnosed model report for the capstone dataset: the fitted model, its coefficients with confidence intervals, a diagnostic-plot summary, and a plain-language interpretation.

### Evidence log entry

Complete the Day 5 row in `Workshop-Evidence-Log.md`: name your principal model and note one limitation you would mention if presenting this result to a non-statistician.

---

## Facilitator notes

- By construction, the synthetic dataset has a real `training_track` effect (Blended > In-Person > Online) and a real positive `attendance` effect, so a correctly specified `model_main` should show both as statistically meaningful -- use this as your answer key.
- Watch for participants treating the regression intercept as if it described a typical participant; it describes a hypothetical one with all numeric predictors at zero, which is rarely realistic here.
- The Day 5 model becomes the Day 6 audit target -- make sure participants keep a copy of `model_main`'s formula and coefficients accessible (e.g. save the fitted object with `saveRDS()`), since Day 6 reproduces part of it by hand.
