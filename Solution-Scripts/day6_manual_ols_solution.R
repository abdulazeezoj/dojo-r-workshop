# Day 6 -- facilitator-reviewed solution: coding statistical models from equations

lecturers <- readr::read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
lecturers$training_track <- factor(lecturers$training_track,
                                    levels = c("Online", "In-Person", "Blended"))

model_data <- lecturers[stats::complete.cases(
  lecturers[, c("post_score", "pre_score", "attendance")]
), ]

# 1. Design matrix and outcome vector
X <- model.matrix(~ pre_score + attendance, data = model_data)
y <- model_data$post_score

# 2. Manual OLS coefficients
beta_hat <- solve(t(X) %*% X) %*% (t(X) %*% y)
beta_hat
model_lm <- lm(post_score ~ pre_score + attendance, data = model_data)
coef(model_lm)

# 3. Fitted values and residuals
fitted_manual <- X %*% beta_hat
residuals_manual <- y - fitted_manual
max(abs(fitted_manual - fitted(model_lm)))
max(abs(residuals_manual - residuals(model_lm)))

# 4. Custom OLS function
my_lm <- function(formula, data) {
  X <- model.matrix(formula, data = data)
  response_name <- all.vars(formula)[1]
  keep <- stats::complete.cases(model.matrix(formula, data = data))
  y <- data[[response_name]][keep]

  if (colnames(X)[1] != "(Intercept)") {
    stop("my_lm() requires an intercept; interceptless formulas are not supported.")
  }

  beta_hat <- solve(t(X) %*% X) %*% (t(X) %*% y)
  fitted_values <- X %*% beta_hat
  resid_values <- y - fitted_values

  n <- nrow(X)
  p <- ncol(X)
  rss <- sum(resid_values^2)
  tss <- sum((y - mean(y))^2)
  r_squared <- 1 - rss / tss
  sigma2 <- rss / (n - p)
  var_beta <- sigma2 * solve(t(X) %*% X)
  se_beta <- sqrt(diag(var_beta))

  list(
    coefficients = setNames(as.vector(beta_hat), colnames(X)),
    std_errors = setNames(se_beta, colnames(X)),
    fitted_values = as.vector(fitted_values),
    residuals = as.vector(resid_values),
    r_squared = r_squared,
    df_residual = n - p
  )
}

full_data <- lecturers[stats::complete.cases(
  lecturers[, c("post_score", "pre_score", "attendance", "training_track")]
), ]

my_fit <- my_lm(post_score ~ pre_score + attendance + training_track, data = full_data)
model_lm_full <- lm(post_score ~ pre_score + attendance + training_track, data = full_data)

my_fit$coefficients
coef(model_lm_full)

my_fit$r_squared
summary(model_lm_full)$r.squared

my_fit$std_errors
summary(model_lm_full)$coefficients[, "Std. Error"]

# 5. Rank-deficiency exercise
model_data$attendance_copy <- model_data$attendance
X_rank_deficient <- model.matrix(~ pre_score + attendance + attendance_copy, data = model_data)
result <- tryCatch(
  solve(t(X_rank_deficient) %*% X_rank_deficient),
  error = function(e) conditionMessage(e)
)
result
# Expected: a "Lapack routine dgesv: system is exactly singular" style error,
# because attendance_copy is an exact linear function of attendance.

# 6. Conditioning exercise
kappa(t(X) %*% X)
X_rescaled <- X
X_rescaled[, "attendance"] <- X_rescaled[, "attendance"] / 10000
kappa(t(X_rescaled) %*% X_rescaled)
# Rescaling one predictor to a tiny range inflates the condition number
# substantially, even though the model is still technically full rank.
