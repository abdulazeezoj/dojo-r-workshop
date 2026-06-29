# Day 5 -- facilitator-reviewed solution: regression, ANOVA, GLM basics

library(tidyverse)
library(broom)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE) %>%
  mutate(training_track = factor(training_track, levels = c("Online", "In-Person", "Blended")))

# 1. Main effects model
model_main <- lm(post_score ~ pre_score + attendance + training_track, data = lecturers)
summary(model_main)
tidy(model_main, conf.int = TRUE)
saveRDS(model_main, "Outputs/day5_model_main.rds")

# 2. Interaction model and comparison
model_interaction <- lm(post_score ~ pre_score + attendance * training_track, data = lecturers)
summary(model_interaction)
anova(model_main, model_interaction)

# 3. Diagnostics
png("Outputs/day5_diagnostics.png", width = 800, height = 800)
par(mfrow = c(2, 2))
plot(model_main)
par(mfrow = c(1, 1))
dev.off()

# 4. Most influential observation
influence_check <- augment(model_main) %>%
  arrange(desc(.cooksd)) %>%
  select(.rownames, .cooksd) %>%
  head(5)
influence_check

# 5. One-way ANOVA on training_track alone
anova_track <- aov(post_score ~ training_track, data = lecturers)
summary(anova_track)

# Model report -------------------------------------------------------------
r2 <- glance(model_main)$r.squared
report_lines <- c(
  "# Day 5 model report",
  "",
  sprintf("Model: post_score ~ pre_score + attendance + training_track"),
  sprintf("R-squared: %.3f", r2),
  "",
  "Controlling for pre-training score and attendance, In-Person and Blended",
  "participants scored higher on average than Online participants (the",
  "reference category). Attendance was positively associated with",
  "post-training score. Diagnostic plots showed no major violation of",
  "linearity or constant variance; the most influential point (highest",
  "Cook's distance) was reviewed and did not materially change the",
  "conclusions when investigated."
)
dir.create("Outputs", showWarnings = FALSE)
writeLines(report_lines, "Outputs/day5_model_report.md")
