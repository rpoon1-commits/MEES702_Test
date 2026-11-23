system.time({
  x = rnorm(10^9)
})


system.time({
  x = rt(n = 10^9, df = 5)
})





library(profvis)
library(bench)
library(microbenchmark)

set.seed(702)
oyster_heights <- rnorm(500, mean = 78, sd = 14)

# 1. Slow implementation (data.frame subsetting + growing vector)
boot_mean_slow <- function(x, n_boot = 2000) {
  boot_means <- numeric(0)
  df <- data.frame(val = x)
  
  for (i in seq_len(n_boot)) {
    resampled_df <- df[sample(nrow(df), size = nrow(df), replace = TRUE), , drop = FALSE]
    boot_means <- c(boot_means, mean(resampled_df$val))
  }
  return(boot_means)
}


boot_mean_mod <- function(x, n_boot = 2000) {
  boot_means <- numeric(0)
  
  for (i in seq_len(n_boot)) {
    resampled_val  = sample(x, replace = TRUE) |> mean()
    boot_means <- c(boot_means, resampled_val)
  }
  return(boot_means)
}


boot_mean_mod2 <- function(x, n_boot = 2000) {
  boot_means <- numeric(n_boot)
  
  for (i in seq_len(n_boot)) {
    resampled_val  = sample(x, replace = TRUE) |> mean()
    boot_means[i] <- resampled_val
  }
  return(boot_means)
}





system.time({
boot_mean_slow(oyster_heights)
})


profvis(boot_mean_slow(oyster_heights))
profvis(boot_mean_mod(oyster_heights))
profvis(boot_mean_mod2(oyster_heights))


microbenchmark::microbenchmark(
  v1 = boot_mean_slow(oyster_heights, n_boot = 3000),
  v2 = boot_mean_mod(oyster_heights, n_boot = 3000),
  v3 = boot_mean_mod(oyster_heights, n_boot = 3000),
  times = 5
)


microbenchmark::microbenchmark(
  v1 = boot_mean_slow(oyster_heights, n_boot = 3000),
  v2 = boot_mean_mod(oyster_heights, n_boot = 3000),
  v3 = boot_mean_mod(oyster_heights, n_boot = 3000),
  iterations = 5
)

