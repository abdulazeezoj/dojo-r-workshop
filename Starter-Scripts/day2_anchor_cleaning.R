# Day 2 starter: anchor dataset cleaning pipeline
#
# Anchor dataset: a (synthetic) evaluation of a national statistics-lecturer
# training programme. Columns: participant_id, age, gender, region,
# institution_type, years_teaching, training_track, attendance, satisfaction,
# pre_score, post_score, completed.
#
# TODO (participant): work through each TODO below during the Day 2 session.

library(tidyverse)

raw_lecturers <- readr::read_csv("Data/raw/anchor_dataset.csv", show_col_types = FALSE)

# --- Step 1: flag invalid values (keep raw_lecturers untouched) -----------

flagged_lecturers <- raw_lecturers %>%
  mutate(
    invalid_age = !is.na(age) & (age < 18 | age > 100),
    invalid_attendance = !is.na(attendance) & (attendance < 0 | attendance > 100),
    invalid_satisfaction = !is.na(satisfaction) & !satisfaction %in% 1:5,
    invalid_pre_score = !is.na(pre_score) & (pre_score < 0 | pre_score > 100),
    invalid_post_score = !is.na(post_score) & (post_score < 0 | post_score > 100)
  )

# --- Step 2: TODO replace flagged values with NA --------------------------
# Hint: use if_else(invalid_age, NA_real_, age), one variable at a time, for
# age, attendance, satisfaction, pre_score and post_score.

clean_lecturers <- flagged_lecturers %>%
  mutate(
    # TODO: age = if_else(invalid_age, NA_real_, age)
    # TODO: attendance, satisfaction, pre_score, post_score (same pattern)
  )

# --- Step 3: TODO standardise category labels ------------------------------
# Hint: str_trim() removes stray whitespace, str_to_title() fixes case.
# gender needs "M"/"m"/"Male" -> "Male" style recoding (case_when()).
# training_track and institution_type need a small recode (e.g. "INPERSON").

clean_lecturers <- clean_lecturers %>%
  mutate(
    # TODO: gender, region, institution_type, training_track
  )

# --- Step 4: TODO remove duplicate rows ------------------------------------
# Hint: distinct() on participant_id (or all columns) after standardising.

n_before_dedup <- nrow(clean_lecturers)
clean_lecturers <- clean_lecturers # TODO: distinct(clean_lecturers, participant_id, .keep_all = TRUE)
n_duplicates_removed <- n_before_dedup - nrow(clean_lecturers)

# --- Step 5: data-quality and missingness reports --------------------------

quality_report <- flagged_lecturers %>%
  summarise(
    rows = n(),
    duplicates_removed = n_duplicates_removed,
    invalid_age = sum(invalid_age, na.rm = TRUE),
    invalid_attendance = sum(invalid_attendance, na.rm = TRUE),
    invalid_satisfaction = sum(invalid_satisfaction, na.rm = TRUE),
    invalid_pre_score = sum(invalid_pre_score, na.rm = TRUE),
    invalid_post_score = sum(invalid_post_score, na.rm = TRUE)
  )

missingness_report <- clean_lecturers %>%
  select(-starts_with("invalid_")) %>%
  summarise(across(everything(), ~ sum(is.na(.x)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "missing_count")

clean_lecturers <- clean_lecturers %>%
  select(-starts_with("invalid_"))

# --- Step 6: export ---------------------------------------------------------

dir.create("Data/processed", showWarnings = FALSE, recursive = TRUE)
readr::write_csv(clean_lecturers, "Data/processed/anchor_dataset_clean.csv")
readr::write_csv(quality_report, "Data/processed/data_quality_report.csv")
readr::write_csv(missingness_report, "Data/processed/missingness_report.csv")

# TODO (participant): write Data/processed/data_dictionary.csv with one row
# per variable (name, type, description, valid range/levels).
