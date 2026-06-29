# R Workshop package installer
# Run once before the workshop, then restart R/RStudio.

required_packages <- c(
  "tidyverse",
  "readr",
  "dplyr",
  "tidyr",
  "ggplot2",
  "readxl",
  "haven",
  "broom",
  "effectsize",
  "car",
  "emmeans",
  "rmarkdown",
  "knitr",
  "quarto"
)

missing_packages <- setdiff(required_packages, rownames(installed.packages()))

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

message("Package check complete. Installed/available packages:")
print(required_packages)
