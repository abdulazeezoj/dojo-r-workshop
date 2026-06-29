# Day 6 final script: Coding Statistical Models from Their Equations
# Consolidated, runnable version of the Part 2 guided-coding walkthrough from
# "Materials/Day 6/R Workshop - Day 6 - Coding Statistical Models from Their Equations.md".
# Requires Data/processed/anchor_dataset_clean.csv (produced on Day 2).

lecturers <- readr::read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
model_data <- lecturers[stats::complete.cases(
  lecturers[, c("post_score", "pre_score", "attendance")]
), ]

# --- 2.1 Build the design matrix ---------------------------------------------

X <- model.matrix(~ pre_score + attendance, data = model_data)
y <- model_data$post_score

dim(X)     # n rows, 3 columns: intercept, pre_score, attendance
head(X, 3)

# --- 2.2 Compute OLS coefficients directly -----------------------------------

XtX <- t(X) %*% X
XtY <- t(X) %*% y
beta_hat <- solve(XtX) %*% XtY
beta_hat

model_lm <- lm(post_score ~ pre_score + attendance, data = model_data)
coef(model_lm)

# --- 2.3 Fitted values and residuals -----------------------------------------

fitted_manual <- X %*% beta_hat
residuals_manual <- y - fitted_manual

max(abs(fitted_manual - fitted(model_lm)))
max(abs(residuals_manual - residuals(model_lm)))

# --- 2.4 A small custom OLS function -----------------------------------------

my_lm <- function(formula, data) {
  X <- model.matrix(formula, data = data)
  response_name <- all.vars(formula)[1]
  y <- data[[response_name]][stats::complete.cases(model.matrix(formula, data = data))]

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

# --- 2.5 Validate against lm() ------------------------------------------------

my_fit <- my_lm(post_score ~ pre_score + attendance, data = model_data)
my_fit$coefficients
coef(model_lm)

my_fit$r_squared
summary(model_lm)$r.squared

my_fit$std_errors
summary(model_lm)$coefficients[, "Std. Error"]

# --- Optional demonstration: bootstrap standard error -----------------------

set.seed(2024)
boot_coefs <- replicate(500, {
  boot_rows <- sample(seq_len(nrow(model_data)), replace = TRUE)
  boot_fit <- my_lm(post_score ~ pre_score + attendance, data = model_data[boot_rows, ])
  boot_fit$coefficients["attendance"]
})
sd(boot_coefs)
