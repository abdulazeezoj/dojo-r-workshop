# Day 2 -- facilitator-reviewed solution: anchor dataset cleaning pipeline

library(tidyverse)

raw_lecturers <- readr::read_csv("Data/raw/anchor_dataset.csv", show_col_types = FALSE)

flagged_lecturers <- raw_lecturers %>%
  mutate(
    invalid_age = !is.na(age) & (age < 18 | age > 100),
    invalid_attendance = !is.na(attendance) & (attendance < 0 | attendance > 100),
    invalid_satisfaction = !is.na(satisfaction) & !satisfaction %in% 1:5,
    invalid_pre_score = !is.na(pre_score) & (pre_score < 0 | pre_score > 100),
    invalid_post_score = !is.na(post_score) & (post_score < 0 | post_score > 100)
  )

clean_lecturers <- flagged_lecturers %>%
  mutate(
    age = if_else(invalid_age, NA_real_, age),
    attendance = if_else(invalid_attendance, NA_real_, attendance),
    satisfaction = if_else(invalid_satisfaction, NA_real_, satisfaction),
    pre_score = if_else(invalid_pre_score, NA_real_, pre_score),
    post_score = if_else(invalid_post_score, NA_real_, post_score)
  ) %>%
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
    ),
    completed = str_to_title(str_trim(completed))
  )

n_before_dedup <- nrow(clean_lecturers)
clean_lecturers <- clean_lecturers %>% distinct(participant_id, .keep_all = TRUE)
n_duplicates_removed <- n_before_dedup - nrow(clean_lecturers)

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

clean_lecturers <- clean_lecturers %>% select(-starts_with("invalid_"))

data_dictionary <- tibble::tribble(
  ~variable,          ~type,        ~description,                                            ~valid_range_or_levels,
  "participant_id",   "character",  "Unique lecturer identifier",                             "LEC-####",
  "age",               "numeric",    "Age in years",                                           "18-100",
  "gender",            "character",  "Self-reported gender",                                   "Male, Female",
  "region",            "character",  "Geopolitical zone",                                      "North Central, North East, North West, South East, South South, South West",
  "institution_type",  "character",  "Type of employing institution",                          "Public, Private",
  "years_teaching",    "numeric",    "Years of teaching experience",                           ">= 0",
  "training_track",    "character",  "Mode of programme delivery",                             "Online, In-Person, Blended",
  "attendance",        "numeric",    "Percentage of sessions attended",                        "0-100",
  "satisfaction",      "numeric",    "Likert satisfaction rating",                             "1-5",
  "pre_score",         "numeric",    "Pre-training assessment score",                          "0-100",
  "post_score",        "numeric",    "Post-training assessment score",                         "0-100",
  "completed",         "character",  "Whether the participant finished the programme",        "Yes, No"
)

dir.create("Data/processed", showWarnings = FALSE, recursive = TRUE)
write_csv(clean_lecturers, "Data/processed/anchor_dataset_clean.csv")
write_csv(quality_report, "Data/processed/data_quality_report.csv")
write_csv(missingness_report, "Data/processed/missingness_report.csv")
write_csv(data_dictionary, "Data/processed/data_dictionary.csv")
