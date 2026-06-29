# Day 3 final script: Exploratory Data Analysis and Statistical Graphics
# Consolidated, runnable version of the Part 2 guided-coding walkthrough from
# "Materials/Day 3/R Workshop - Day 3 - Exploratory Data Analysis and Statistical Graphics.md".
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)

dir.create("Outputs", showWarnings = FALSE)

# --- 2.1 Bar chart -- counts by training track ------------------------------

p_track_counts <- ggplot(lecturers, aes(x = training_track)) +
  geom_bar(fill = "#2C7FB8") +
  labs(
    title = "Participants by training track",
    x = "Training track", y = "Number of participants"
  ) +
  theme_minimal()
p_track_counts

# --- 2.2 Histogram -- distribution of post-training scores -----------------

p_score_hist <- ggplot(lecturers, aes(x = post_score)) +
  geom_histogram(binwidth = 5, fill = "#41AB5D", colour = "white") +
  labs(
    title = "Distribution of post-training scores",
    x = "Post-training score (0-100)", y = "Number of participants"
  ) +
  theme_minimal()
p_score_hist

# --- 2.3 Box plot -- score by training track --------------------------------

p_score_by_track <- ggplot(lecturers, aes(x = training_track, y = post_score)) +
  geom_boxplot(fill = "#FEB24C") +
  labs(
    title = "Post-training score by training track",
    x = "Training track", y = "Post-training score (0-100)"
  ) +
  theme_minimal()
p_score_by_track

# --- 2.4 Scatter plot -- score against attendance ---------------------------

p_score_by_attendance <- ggplot(lecturers, aes(x = attendance, y = post_score)) +
  geom_point(alpha = 0.6, colour = "#6A51A3") +
  labs(
    title = "Post-training score by attendance",
    x = "Attendance (%)", y = "Post-training score (0-100)"
  ) +
  theme_minimal()
p_score_by_attendance

# --- 2.5 Export ---------------------------------------------------------------

ggsave("Outputs/day3_bar_track_counts.png", p_track_counts, width = 7, height = 5, dpi = 300)
ggsave("Outputs/day3_hist_post_score.png", p_score_hist, width = 7, height = 5, dpi = 300)
ggsave("Outputs/day3_box_score_by_track.png", p_score_by_track, width = 7, height = 5, dpi = 300)
ggsave("Outputs/day3_scatter_score_by_attendance.png", p_score_by_attendance, width = 7, height = 5, dpi = 300)

# --- Optional demonstration: faceted histogram by training track -----------

ggplot(lecturers, aes(x = post_score)) +
  geom_histogram(binwidth = 5, fill = "#41AB5D", colour = "white") +
  facet_wrap(~ training_track) +
  labs(title = "Post-training score by training track", x = "Post-training score", y = "Count") +
  theme_minimal()
