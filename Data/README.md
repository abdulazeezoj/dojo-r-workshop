# Data

Use `raw/` for unmodified source data and `processed/` for reproducible outputs from cleaning scripts (not committed; regenerate by running `Starter-Scripts/day2_anchor_cleaning.R` or its solution).

## raw/

- `anchor_dataset.csv` -- the synthetic anchor dataset used from Day 2 through Day 7 (training-track evaluation of a national statistics-lecturer training programme). Contains deliberate missing values, invalid entries and inconsistent category labels for the Day 2 cleaning exercises.
- `day1_baseline_sample.csv` -- small dataset for the Day 1 baseline task.
- `day7_baseline_sample.csv` -- equivalent small dataset for the Day 7 repeat of the baseline task.

## processed/

Created by the Day 2 cleaning pipeline: `anchor_dataset_clean.csv`, `data_dictionary.csv`, plus quality and missingness reports. Any other dataset used in the workshop must be labelled as a demonstration dataset, not a substitute for the anchor dataset.
