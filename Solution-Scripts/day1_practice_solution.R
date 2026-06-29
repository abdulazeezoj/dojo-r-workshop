# Day 1 -- facilitator-reviewed solution to the Part 3 practice exercise.
# Participants should attempt the task in Starter-Scripts before reading this.

attendance <- c(95, 88, 100, 62, NA, 74, 81, 45)

mean(attendance, na.rm = TRUE)

below_70 <- attendance < 70

students <- data.frame(
  student_id = paste0("S", sprintf("%02d", 1:8)),
  attendance = attendance,
  pass = ifelse(attendance >= 70, TRUE, FALSE)
)
students

mean(students$pass, na.rm = TRUE)
