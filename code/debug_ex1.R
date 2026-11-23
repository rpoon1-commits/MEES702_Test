# Simulated Chesapeake Bay monitoring station water temperatures (°C)
# Note: Station CB_03 contains a corrupted character entry ("13.8")
station_readings <- list(
  CB_01 = c(14.2, 14.8, 15.1, 14.9),
  CB_02 = c(16.0, 16.3, 15.9, 16.5),
  CB_03 = c(13.5, 13.8, 14.0, 13.7),
  CB_04 = c(17.1, 17.4, 17.2, 17.6)
)

# Helper function to compute mean temperature anomaly relative to a baseline
calc_station_anomaly <- function(temps, baseline = 15.0) {
  
#  if (!is.numeric(temps)) {
#    browser()
#  }
  diffs <- temps - baseline
  mean(diffs)
}

# Wrapper function to iterate across all monitoring stations
summarize_bay_temps <- function(readings_list, baseline = 15.0) {
  anomalies <- numeric(length(readings_list))
  names(anomalies) <- names(readings_list)
  
  for (i in seq_along(readings_list)) {
    anomalies[i] <- calc_station_anomaly(readings_list[[i]], baseline = baseline)
  }
  return(anomalies)
}

# Trigger the error:
summarize_bay_temps(station_readings)

# Debug manual
debug(calc_station_anomaly)
calc_station_anomaly(1:5)
undebug(calc_station_anomaly)


debug()

