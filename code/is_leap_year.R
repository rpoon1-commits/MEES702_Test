# A year is a leap year if it is divisible by 4,
# except for the end-of century years (divisible by 100)
# which much also be divisible by 400

# input: Numeric year (y)

is_leap_year <- function(year) {
  if (!is.numeric(year)) {
    stop("Message: Please input a numeric year.")
  }
  
  is_leap <- (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
  
  return(is_leap)
}