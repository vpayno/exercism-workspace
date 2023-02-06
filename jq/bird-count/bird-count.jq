# The input will be an array of arrays representing the daily bird counts.
# The data is organized into weekly arrays.
# The data is organized chronologically:
# - this week's data is the last element of the array, and
# - today's count is the last element of this week's data

# The output of this exercise is a JSON object,
# one key:value pair per task.

{
  # Task 1: output the array for last week's data
  # Solution: get the 2nd to last array from the main array.
  last_week: (.[-2]),

  # Task 2: output count for yesterday in this week's data
  # Solution: Get the second to last day from the last array in the main array.
  yesterday: (.[-1][-2]),

  # Task 3: output sum of counts for this week's data
  # Solution: Sum the numbers in the last array in the main array.
  total: (.[-1] | add),

  # Task 4: output number of days with 5 or more birds in this week's data
  # Solution: Get the last array and create a new array using select and get the length.
  busy_days: ([.[-1][] | select(. >= 5)] | length),

  # Task 5: output true if any day this week has zero birds
  # Solution: Use any on the last array.
  has_day_without_birds: (.[-1] | any(. == 0))
}
