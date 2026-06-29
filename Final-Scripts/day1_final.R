# Day 1 final script: Getting Comfortable with R
# Consolidated, runnable version of the Part 2 guided-coding walkthrough from
# "Materials/Day 1/R Workshop - Day 1 - Getting Comfortable with R.md".
# The Day 1 baseline task itself lives in Starter-Scripts/day1_baseline.R and
# Solution-Scripts/day1_practice_solution.R.

# --- 2.1 Assignment, object names and comments ------------------------------

# Comments start with # and explain *why*, not *what the code obviously does*
workshop_day <- 1          # use <- for assignment, not =
participant_count <- 24
average_age <- 41.6

workshop_day
print(participant_count)

# --- 2.2 Vectors -------------------------------------------------------------

ages <- c(34, 41, 29, 52, 38, NA, 45)
class(ages)
length(ages)

regions <- c("North West", "South East", "South West", "North Central")
class(regions)

# --- 2.3 Indexing and logical conditions ------------------------------------

ages[1]              # first element
ages[c(1, 3)]        # first and third
ages[ages > 40]      # logical indexing: keep ages above 40

over_40 <- ages > 40 # this is itself a vector of TRUE/FALSE/NA
over_40

# --- 2.4 Missing values ------------------------------------------------------

mean(ages)            # returns NA -- R refuses to silently guess
mean(ages, na.rm = TRUE)
sum(is.na(ages))      # how many missing values?
which(is.na(ages))    # which positions?

# --- 2.5 A small data frame --------------------------------------------------

participants <- data.frame(
  participant_id = c("P01", "P02", "P03", "P04", "P05"),
  age = c(34, 41, 29, 52, 38),
  region = c("North West", "South East", "South West", "North Central", "South East"),
  pre_score = c(58, 64, 71, 49, 60)
)

str(participants)
head(participants, 3)
nrow(participants)
ncol(participants)

# --- 2.6 Descriptive statistics, including grouped summaries ----------------

mean(participants$pre_score)
median(participants$pre_score)
sd(participants$pre_score)

# Grouped summary without extra packages
tapply(participants$pre_score, participants$region, mean)

# --- 2.7 Reading error messages (deliberate, kept non-fatal here) -----------
# Run tryCatch(mean(participnts$pre_score), error = function(e) e) live in the
# console to see: Error in mean(participnts$pre_score) : object
# 'participnts' not found. Read right to left: *what* went wrong and *where*.

tryCatch(
  mean(participnts$pre_score),
  error = function(e) message("Caught the deliberate typo error: ", conditionMessage(e))
)

# --- Optional demonstration: factors ----------------------------------------

satisfaction <- factor(c("Low", "High", "Medium", "High"),
                        levels = c("Low", "Medium", "High"), ordered = TRUE)
satisfaction
satisfaction < "High"
