c(1:50) * 2
summary(iris)

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


is_leap_year(20)
is_leap_year(20.1)
is_leap_year(1900)
is_leap_year(2000)
is_leap_year(2004)
is_leap_year(2023)
is_leap_year("two thousand")
