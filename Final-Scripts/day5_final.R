# Day 5 final script: Regression, ANOVA and Generalised Linear Models
# Consolidated, runnable version of the Part 2 guided-coding walkthrough from
# "Materials/Day 5/R Workshop - Day 5 - Regression, ANOVA and Generalised Linear Models.md".
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

library(tidyverse)
library(broom)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE) %>%
  mutate(training_track = factor(training_track, levels = c("Online", "In-Person", "Blended")))

# --- 2.1 Multiple linear regression ------------------------------------------

model_main <- lm(post_score ~ pre_score + attendance + training_track, data = lecturers)
summary(model_main)
tidy(model_main, conf.int = TRUE)

# --- 2.2 One interaction ------------------------------------------------------

model_interaction <- lm(post_score ~ pre_score + attendance * training_track, data = lecturers)
summary(model_interaction)

anova(model_main, model_interaction)

# --- 2.3 Diagnostics -----------------------------------------------------------

par(mfrow = c(2, 2))
plot(model_main)
par(mfrow = c(1, 1))

influence_check <- augment(model_main) %>%
  arrange(desc(.cooksd)) %>%
  select(.rownames, .cooksd) %>%
  head(5)
influence_check

# --- 2.4 One-way ANOVA ---------------------------------------------------------

anova_track <- aov(post_score ~ training_track, data = lecturers)
summary(anova_track)

# --- 2.5 Reporting -------------------------------------------------------------

glance(model_main)$r.squared

# Keep a copy of the fitted model for the Day 6 audit.
dir.create("Outputs", showWarnings = FALSE)
saveRDS(model_main, "Outputs/day5_model_main.rds")

# --- Optional demonstration: logistic regression on completion --------------

lecturers_glm <- lecturers %>% mutate(completed_numeric = if_else(completed == "Yes", 1, 0))
model_logit <- glm(completed_numeric ~ attendance + satisfaction, data = lecturers_glm, family = binomial)
summary(model_logit)
