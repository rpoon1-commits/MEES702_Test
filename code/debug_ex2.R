# Load packages needed for this exercise
library(purrr)
library(tibble)

# Simulated dissolved oxygen (DO) and temperature datasets across 4 stations
station_dfs <- list(
  Station_A = tibble(temp = c(12, 14, 16, 18, 20), do = c(9.8, 9.2, 8.7, 8.1, 7.6)),
  Station_B = tibble(temp = c(11, 13, 15, 17, 19), do = c(10.1, 9.5, 9.0, 8.4, 7.9)),
  Station_C = tibble(temp = c(14, 15, 16, 17, 18), do = rep(NA_real_, 5)), # Sensor outage (all NA)
  Station_D = tibble(temp = c(13, 15, 17, 19, 21), do = c(9.4, 8.9, 8.3, 7.8, 7.2))
)

# Function to extract linear DO-temperature slope
fit_do_slope <- function(df) {
  mod <- lm(do ~ temp, data = df)
  coef(mod)[["temp"]]
}

# Produces an error
# fit_do_slope(station_dfs)



# Create a safe wrapper: safe_fit_slope <- purrr::safely(fit_do_slope).
safe_fit_slope <- purrr::safely(fit_do_slope)
safe_fit_slope(station_dfs[[1]])

# Iterate safe_fit_slope over station_dfs using map().
results = purrr::map(station_dfs, safe_fit_slope)

# Inspect the structure of the returned list (str(results)). Notice that every element is a two-item list containing $result and $error.
str(results)



# Extract all successful slopes into a named numeric vector (map(results, "result") |> compact() |> list_c()) and extract the captured error message for Station_C (map(results, "error") |> compact()).
results_selected = map(results, "result") |>
  compact() |>
  list_c()


# message for Station_C (map(results, "error") |? compact()).
map(results, "error") |> compact()

tryCatch()









