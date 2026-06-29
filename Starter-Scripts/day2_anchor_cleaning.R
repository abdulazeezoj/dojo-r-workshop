# Day 2 starter: anchor dataset cleaning pipeline
# Replace file paths and variable names to match the workshop anchor dataset.

library(tidyverse)

raw_course <- readr::read_csv("Data/raw/anchor_dataset.csv", show_col_types = FALSE)

clean_course <- raw_course %>%
  mutate(
    invalid_age = !is.na(age) & (age < 16 | age > 100),
    invalid_attendance = !is.na(attendance) & (attendance < 0 | attendance > 100),
    invalid_satisfaction = !is.na(satisfaction) & !satisfaction %in% 1:5,
    invalid_pre_score = !is.na(pre_score) & (pre_score < 0 | pre_score > 100),
    invalid_post_score = !is.na(post_score) & (post_score < 0 | post_score > 100),
    age = if_else(invalid_age, NA_real_, age),
    attendance = if_else(invalid_attendance, NA_real_, attendance),
    satisfaction = if_else(invalid_satisfaction, NA_real_, satisfaction),
    pre_score = if_else(invalid_pre_score, NA_real_, pre_score),
    post_score = if_else(invalid_post_score, NA_real_, post_score)
  )

quality_report <- clean_course %>%
  summarise(
    rows = n(),
    invalid_age = sum(invalid_age, na.rm = TRUE),
    invalid_attendance = sum(invalid_attendance, na.rm = TRUE),
    invalid_satisfaction = sum(invalid_satisfaction, na.rm = TRUE),
    invalid_pre_score = sum(invalid_pre_score, na.rm = TRUE),
    invalid_post_score = sum(invalid_post_score, na.rm = TRUE)
  )

missingness_report <- clean_course %>%
  summarise(across(everything(), ~ sum(is.na(.x)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "missing_count")

readr::write_csv(clean_course, "Data/processed/anchor_dataset_clean.csv")
readr::write_csv(quality_report, "Data/processed/data_quality_report.csv")
readr::write_csv(missingness_report, "Data/processed/missingness_report.csv")
