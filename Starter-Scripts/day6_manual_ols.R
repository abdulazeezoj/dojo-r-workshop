# Day 6 starter: coding statistical models from their equations
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

lecturers <- readr::read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
model_data <- lecturers[stats::complete.cases(
  lecturers[, c("post_score", "pre_score", "attendance")]
), ]

# TODO 1: build the design matrix X and outcome vector y for
# post_score ~ pre_score + attendance using model.matrix()

# TODO 2: compute beta_hat = solve(t(X) %*% X) %*% (t(X) %*% y) and compare
# to coef(lm(post_score ~ pre_score + attendance, data = model_data))

# TODO 3: compute fitted values and residuals manually, compare to
# fitted()/residuals() from the lm() fit

# TODO 4: complete my_lm() below, then validate it against lm() on the
# full Day 5 formula (post_score ~ pre_score + attendance + training_track)

my_lm <- function(formula, data) {
  # TODO: implement, see the Day 6 workbook Part 2.4 for the full version
}

# TODO 5: rank-deficiency exercise -- duplicate a column and see what
# solve() does

# TODO 6: conditioning exercise -- kappa(t(X) %*% X) before/after rescaling
