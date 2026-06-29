# Day 7 final script: Reproducible Research and Capstone Presentation
# Plain-R equivalent of the Part 2 guided-coding code chunks from
# "Materials/Day 7/R Workshop - Day 7 - Reproducible Research and Capstone
# Presentation.md", useful for testing the logic outside Quarto. The actual
# Day 7 deliverable is the rendered .qmd report -- see
# Quarto-Template/capstone-report.qmd (participant template) and
# Solution-Scripts/day7_capstone_report_solution.qmd (facilitator-reviewed
# example).

library(tidyverse)

# --- 2.3 Figure used in the capstone report ---------------------------------

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)

ggplot(lecturers, aes(x = training_track, y = post_score)) +
  geom_boxplot(fill = "#FEB24C") +
  theme_minimal()

# Inline-result example reproduced as plain R:
round(mean(lecturers$attendance, na.rm = TRUE), 1)

# --- 2.4 Rendering the Quarto report ------------------------------------------
# Run this once the capstone-report.qmd sections are filled in:
#
#   quarto::quarto_render("Quarto-Template/capstone-report.qmd")
#
# or, from the terminal: quarto render "Quarto-Template/capstone-report.qmd"

# --- 2.5 Recording session information ---------------------------------------

sessionInfo()
