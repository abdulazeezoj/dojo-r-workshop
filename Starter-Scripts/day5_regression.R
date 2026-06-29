# Day 5 starter: regression, ANOVA and generalised linear models
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

library(tidyverse)
library(broom)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE) %>%
  mutate(training_track = factor(training_track, levels = c("Online", "In-Person", "Blended")))

# TODO 1: fit model_main: post_score ~ pre_score + attendance + training_track

# TODO 2: fit model_interaction: add attendance * training_track instead of
# attendance + training_track, then compare with anova(model_main, model_interaction)

# TODO 3: diagnostic plots for model_main (plot(model_main)), note concerns

# TODO 4: most influential observation (broom::augment() + .cooksd)

# TODO 5: one-way ANOVA: post_score ~ training_track, compare to regression

# TODO: save a written model report to Outputs/day5_model_report.md
