# Day 4 starter: probability, sampling, simulation and inference
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
set.seed(2024)

# TODO 1: 95% confidence interval for mean attendance

# TODO 2: paired t-test, post_score vs pre_score (filter out NA pairs first)
# Write the plain-language sentence with your actual numbers as a comment.

# TODO 3: one additional comparison relevant to your research question

# TODO 4: check one assumption informally (histogram or qqnorm()) and
# note any concern in a comment
