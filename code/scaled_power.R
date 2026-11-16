rm(list = ls())

global_scale <- 10

scaled_power <- function(x, 
                         power = 2,
                         method = c("simple", "precise"),
                         scale = 10,
                         plot = TRUE,
                         ...) {
  if (!is.numeric(x)) { 
    stop("Input 'x' must be numeric.", call. = FALSE)
    }
  
  # check that the user input is from the specified options
  method = match.arg(method)
  
  
  
  # Local variables are isolated within the function environment
  pow_res <- x^power
  
  global_scale = 2
  final_res <- pow_res * scale
  
  if(method == "simple") {
    final_res = round(final_res)
  }
  
  if (plot) {
    par(mfrow = c(1, 2))
    plot(x, final_res, xlab = "Input(x)", ...)
    plot(x, final_res, xlab = "another plot", ...)
  }
  
  lm(x ~ final_res, ...)
  
  return(final_res)
}



scaled_power(x = "three")
scaled_power(x = c(1, 2, 3))
scaled_power(x = c(1, 2, 3), power = 3, scale = 5)

scaled_power(x = c(1, 2, 3), power = 0.5, method = "simple")

scaled_power(x = c(1, 2, 3), power = 0.5, method = "precise")

scaled_power(x = c(1, 2, 3), power = 3, scale = 5, pch = 18, cex = 2)

scaled_power(x = c(1, 2, 3), power = 3, scale = 5, pch = 18, cex = 2, xlab = "My x")


res <- scaled_power(
  x = seq(-3, 3, by = 0.5), 
  power = 2, 
  scale = 5, 
  method = "precise",
  col = "firebrick", 
  pch = 19, 
  type = "b"
)

