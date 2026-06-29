# Day 3 starter: exploratory data analysis and statistical graphics
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)

dir.create("Outputs", showWarnings = FALSE)

# TODO 1: categorical-summary chart (bar chart) for a variable of your choice

# TODO 2: distribution chart (histogram or box plot) for pre_score or post_score

# TODO 3: relationship chart (scatter plot or box plot) linked to your research question

# TODO: export each plot with ggsave() to Outputs/, and write a two- to
# three-sentence interpretation as a comment above each ggsave() call.
