library(CityShadeMap)
library(terra)

height.ras <- rast("lidar/dsm_234000_4140000.tif")
height.ras
height.mat <- terra_to_matrix(height.ras)

sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 15)
sunpos


shademap <- calc_shade(height.mat,
                       sun.altitude = sunpos[1, "elevation"],
                       sun.angle = sunpos[1, "azimuth"],
                       crs = crs(height.ras))

shademap
plot(shademap)


##########

hmat <- matrix(data = rep(0, 9*9), nrow = 9, ncol = 9, byrow = TRUE)
hmat[5,5] <- 4
hmat

sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-07-01", hour = 15)
sunpos

# lambert = FALSE
shademap <- calc_shade(hmat,
                       sun.altitude = sunpos[1, "elevation"],
                       sun.angle = sunpos[1, "azimuth"],
                       lambert = F)
plot(shademap)


# lambert = TRUE
shademap <- calc_shade(hmat,
                       sun.altitude = sunpos[1, "elevation"],
                       sun.angle = sunpos[1, "azimuth"],
                       lambert = T)
plot(shademap)
