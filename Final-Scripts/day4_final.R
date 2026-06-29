# Day 4 final script: Probability, Sampling, Simulation and Inference
# Consolidated, runnable version of the Part 2 guided-coding walkthrough from
# "Materials/Day 4/R Workshop - Day 4 - Probability, Sampling, Simulation and Inference.md".
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
set.seed(2024)

# --- 2.1 One simulation experiment ------------------------------------------

# Simulate 1,000 lecturers' post-training scores under an assumed
# population mean of 65 and sd of 12, purely to see typical sample noise.
simulated_scores <- rnorm(1000, mean = 65, sd = 12)
mean(simulated_scores)
sd(simulated_scores)
hist(simulated_scores, main = "Simulated post-training scores", xlab = "Score")

# --- 2.2 Demonstrating the CLT with repeated samples ------------------------

sample_means <- replicate(2000, {
  one_sample <- sample(lecturers$post_score[!is.na(lecturers$post_score)], size = 30)
  mean(one_sample)
})

hist(sample_means, main = "Distribution of sample means (n = 30, 2000 repeats)",
     xlab = "Sample mean post-training score")
sd(sample_means) # the standard error, empirically
sd(lecturers$post_score, na.rm = TRUE) / sqrt(30) # should be close to sd(sample_means)

# --- 2.3 One confidence interval --------------------------------------------

post_scores <- lecturers$post_score[!is.na(lecturers$post_score)]
n <- length(post_scores)
sample_mean <- mean(post_scores)
sample_se <- sd(post_scores) / sqrt(n)

ci_lower <- sample_mean - qt(0.975, df = n - 1) * sample_se
ci_upper <- sample_mean + qt(0.975, df = n - 1) * sample_se
c(ci_lower, ci_upper)

# Or, directly from a t-test:
t.test(post_scores)$conf.int

# --- 2.4 Selecting and running one test -------------------------------------

paired_data <- lecturers %>% filter(!is.na(pre_score), !is.na(post_score))

t.test(paired_data$post_score, paired_data$pre_score, paired = TRUE)

# --- 2.5 Reporting statistical and practical significance ------------------

paired_result <- t.test(paired_data$post_score, paired_data$pre_score, paired = TRUE)
mean_gain <- mean(paired_data$post_score - paired_data$pre_score)
mean_gain
paired_result

# --- Optional demonstration: chi-square test of independence ---------------

chisq.test(table(lecturers$completed, lecturers$training_track))
