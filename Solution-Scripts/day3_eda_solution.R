# Day 3 -- facilitator-reviewed solution: exploratory data analysis and graphics

library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)

dir.create("Outputs", showWarnings = FALSE)

# 1. Participants by training track.
# Online was the most common track, followed by In-Person and then Blended.
# Any track-level result should be read with this imbalance in mind.
p_track_counts <- ggplot(lecturers, aes(x = training_track)) +
  geom_bar(fill = "#2C7FB8") +
  labs(title = "Participants by training track",
       x = "Training track", y = "Number of participants") +
  theme_minimal()
ggsave("Outputs/day3_bar_track_counts.png", p_track_counts, width = 7, height = 5, dpi = 300)

# 2. Distribution of post-training scores.
# Scores are roughly centred in the 60-80 range with a moderate spread.
# A small number of participants scored below 40, worth a closer look on Day 4.
p_post_hist <- ggplot(lecturers, aes(x = post_score)) +
  geom_histogram(binwidth = 5, fill = "#41AB5D", colour = "white") +
  labs(title = "Distribution of post-training scores",
       x = "Post-training score (0-100)", y = "Number of participants") +
  theme_minimal()
ggsave("Outputs/day3_hist_post_score.png", p_post_hist, width = 7, height = 5, dpi = 300)

# 3. Post-training score against attendance.
# Higher attendance is associated with higher post-training scores in this
# sample; this plot shows association only, not a causal claim.
p_score_attendance <- ggplot(lecturers, aes(x = attendance, y = post_score)) +
  geom_point(alpha = 0.6, colour = "#6A51A3") +
  labs(title = "Post-training score by attendance",
       x = "Attendance (%)", y = "Post-training score (0-100)") +
  theme_minimal()
ggsave("Outputs/day3_scatter_score_attendance.png", p_score_attendance, width = 7, height = 5, dpi = 300)
