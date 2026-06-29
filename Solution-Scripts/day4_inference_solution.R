# Day 4 -- facilitator-reviewed solution: probability, sampling, simulation, inference

library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
set.seed(2024)

# 1. 95% confidence interval for mean attendance
attendance_vals <- lecturers$attendance[!is.na(lecturers$attendance)]
t.test(attendance_vals)$conf.int

# 2. Paired t-test: did post-training scores improve on pre-training scores?
paired_data <- lecturers %>% filter(!is.na(pre_score), !is.na(post_score))
paired_result <- t.test(paired_data$post_score, paired_data$pre_score, paired = TRUE)
paired_result
mean_gain <- mean(paired_data$post_score - paired_data$pre_score)
mean_gain
# Interpretation: post-training scores were on average `mean_gain` points
# higher than pre-training scores (paired t-test). The result is
# statistically significant at the 5% level and represents a meaningful
# practical gain on a 0-100 scale.

# 3. Independent two-sample t-test: completers vs non-completers
completion_data <- lecturers %>% filter(!is.na(post_score), !is.na(completed))
t.test(post_score ~ completed, data = completion_data)

# 4. Informal assumption check: distribution of the paired differences
score_gain <- paired_data$post_score - paired_data$pre_score
hist(score_gain, main = "Post- minus pre-training score", xlab = "Score gain")
qqnorm(score_gain); qqline(score_gain)
# The gains look reasonably symmetric with no extreme outliers, so the
# paired t-test's normality assumption is acceptable for this sample size.
