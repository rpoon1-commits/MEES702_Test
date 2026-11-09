# Load necessary packages and open the NetCDF file connection:
library(ncdf4)
library(geosphere)
library(tibble)
library(ggplot2)

nc_path <- "dataraw/cbefs_2024_v20251101.nc"
nc <- nc_open(nc_path)

# Inspect variable names and dimensions: 


# View available variable names
names(nc$var)

# View available dimension names
ls(nc$dim)

# Inspect specific dimension attributes
nc$dim$depths
nc$dim$time
nc$dim$x
nc$dim$y





# Extract the 2D coordinate matrices (336 x 564) and set the target coordinates for CBL:
# Extract coordinate grids
lon_matrix <- ncvar_get(nc, "longitude")
lat_matrix <- ncvar_get(nc, "latitude")

plot(x = as.vector(lon_matrix), y = as.vector(lat_matrix))

# Define target coordinates for Chesapeake Biological Laboratory (CBL)
cbl_lon <- -76.4533
cbl_lat <- 38.3191

# Find the grid cell index (row, col) closest to CBL by actual geodesic distance (in meters):
# Unroll 2D grids into a 2-column coordinate matrix
coords_grid <- cbind(as.vector(lon_matrix), as.vector(lat_matrix))

# Compute true distances on a sphere/ellipsoid
dist_meters <- distGeo(c(cbl_lon, cbl_lat), coords_grid)
dist_matrix <- matrix(dist_meters, nrow = nrow(lon_matrix), ncol = ncol(lon_matrix))

# Locate array indices of minimum distance
nearest_idx <- which(dist_matrix == min(dist_matrix, na.rm = TRUE), arr.ind = TRUE)
target_row  <- nearest_idx[1, "row"]
target_col  <- nearest_idx[1, "col"]


# Slice temperature without loading the full 4D dataset. This is the fun part! Extract temperature values for the selected grid cell across both water layers and all 365 days using start and count offsets to prevent loading the full 4D dataset (~138 million values) into memory:
# Dimensions are [336, 564, 2, 365] -> [row, col, layer, time]
# start: row, col, start_layer, start_day
# count: row_count, col_count, layer_count, day_count
cbl_temp <- ncvar_get(
  nc,
  varid = "temperature",
  start = c(target_row, target_col, 1, 1),
  count = c(1, 1, 2, 365)
)

# Always close the NetCDF file connection when finished
nc_close(nc)



#Format the extracted slice into a tidy data frame:
# Layer 1 = Bottom water layer, Layer 2 = Surface water layer
cbl_df <- tibble(
  Day = rep(1:365, times = 2),
  Layer = rep(c("Layer 1 (Bottom)", "Layer 2 (Surface)"), each = 365),
  Temperature = c(cbl_temp[1, ], cbl_temp[2, ])
)


cbl_df |>
  ggplot(aes(y = Temperature, x = Day, color = Layer)) + 
  geom_line()


