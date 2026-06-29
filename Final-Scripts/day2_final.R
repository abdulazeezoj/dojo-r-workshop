# Day 2 final script: Importing, Cleaning and Preparing Data
# Consolidated, runnable version of the Part 2 guided-coding walkthrough from
# "Materials/Day 2/R Workshop - Day 2 - Importing, Cleaning and Preparing Data.md".
# The participant-practice version (with TODOs) is Starter-Scripts/day2_anchor_cleaning.R;
# the facilitator-reviewed answer key is Solution-Scripts/day2_anchor_cleaning_solution.R.

library(tidyverse)

# --- 2.1 Import with readr ---------------------------------------------------

raw_lecturers <- readr::read_csv("Data/raw/anchor_dataset.csv", show_col_types = FALSE)

# --- 2.2 Inspect before you touch anything ----------------------------------

glimpse(raw_lecturers)
summary(raw_lecturers)
nrow(raw_lecturers)
sum(duplicated(raw_lecturers))
colSums(is.na(raw_lecturers))

# --- 2.3 Flag invalid values (do not delete rows) ---------------------------

flagged_lecturers <- raw_lecturers %>%
  mutate(
    invalid_age = !is.na(age) & (age < 18 | age > 100),
    invalid_attendance = !is.na(attendance) & (attendance < 0 | attendance > 100),
    invalid_satisfaction = !is.na(satisfaction) & !satisfaction %in% 1:5,
    invalid_pre_score = !is.na(pre_score) & (pre_score < 0 | pre_score > 100),
    invalid_post_score = !is.na(post_score) & (post_score < 0 | post_score > 100)
  )

flagged_lecturers %>%
  summarise(across(starts_with("invalid_"), sum, na.rm = TRUE))

# --- 2.4 Replace flagged values with NA -------------------------------------

clean_lecturers <- flagged_lecturers %>%
  mutate(
    age = if_else(invalid_age, NA_real_, age),
    attendance = if_else(invalid_attendance, NA_real_, attendance),
    satisfaction = if_else(invalid_satisfaction, NA_real_, satisfaction),
    pre_score = if_else(invalid_pre_score, NA_real_, pre_score),
    post_score = if_else(invalid_post_score, NA_real_, post_score)
  )

# --- 2.5 Standardise category labels ----------------------------------------

clean_lecturers <- clean_lecturers %>%
  mutate(
    gender = str_trim(gender),
    gender = case_when(
      str_to_lower(gender) %in% c("m", "male") ~ "Male",
      str_to_lower(gender) %in% c("f", "female") ~ "Female",
      TRUE ~ gender
    ),
    region = str_to_title(str_trim(region)),
    institution_type = str_to_title(str_trim(institution_type)),
    training_track = str_trim(training_track),
    training_track = case_when(
      str_to_lower(training_track) == "online" ~ "Online",
      str_to_lower(training_track) == "blended" ~ "Blended",
      str_to_lower(training_track) %in% c("in-person", "in person", "inperson") ~ "In-Person",
      TRUE ~ training_track
    )
  )

count(clean_lecturers, gender)
count(clean_lecturers, training_track)

# --- 2.6 Duplicates ----------------------------------------------------------

n_before <- nrow(clean_lecturers)
clean_lecturers <- clean_lecturers %>% distinct(participant_id, .keep_all = TRUE)
n_duplicates_removed <- n_before - nrow(clean_lecturers)
n_duplicates_removed

# --- 2.7 Data-quality and missingness reports -------------------------------

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

# --- 2.8 Export ---------------------------------------------------------------

clean_lecturers <- clean_lecturers %>% select(-starts_with("invalid_"))

dir.create("Data/processed", showWarnings = FALSE, recursive = TRUE)
write_csv(clean_lecturers, "Data/processed/anchor_dataset_clean.csv")
write_csv(quality_report, "Data/processed/data_quality_report.csv")
write_csv(missingness_report, "Data/processed/missingness_report.csv")

# --- Optional demonstration: reshape pre/post scores into long format ------

clean_lecturers %>%
  select(participant_id, pre_score, post_score) %>%
  pivot_longer(cols = c(pre_score, post_score),
               names_to = "timing", values_to = "score")
