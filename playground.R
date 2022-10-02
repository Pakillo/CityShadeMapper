library(CityShadeMapper)
library(terra)

height.ras <- rast("lidar/dsm_228000_4140000.tif")
height.ras
height.ras <- crop(height.ras, c(229300, 229400, 4141250, 4141350))

shaderas <- get_shade_raster(height.ras, date = "2022-05-08", hour = 8:22)

shaderas
plot(shaderas, col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)), axes = FALSE)
animate(shaderas, col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)),
        n = 1, axes = FALSE, legend = FALSE)
animation::saveGIF(
  animate(shaderas,
          col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)),
          axes = FALSE, legend = FALSE
          )
)

library(maptiles)

shade <- project(shaderas, "epsg:3857")
bg <- get_tiles(shade, provider = "Esri.WorldImagery", crop = TRUE)
plot(shade[[3]], axes = FALSE, col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)))
plot(bg)

osmpos <- list(src = 'IGN',
               q = 'https://tms-pnoa-ma.idee.es/1.0.0/pnoa-ma/{z}/{x}/{-y}.jpeg',
               # q = 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
               sub = c(''),
               cit = '© OpenStreetMap contributors © CARTO.'
               )

bg <- get_tiles(shade, provider = osmpos, crop = TRUE)


height.mat <- terra_to_matrix(height.ras)

sunpos <- get_sun_position(lon = -6.06, lat = 37.38, date = "2020-01-08", hour = 18)
sunpos
sunpos <- get_sun_position(lon = -6.06, lat = 37.38, date = c("2022-01-08", "2022-05-08"),
                           hour = 10:14)
sunpos


shademap <- calc_shade(height.mat,
                       sun.altitude = sunpos[1, "elevation"],
                       sun.angle = sunpos[1, "azimuth"],
                       crs = crs(height.ras),
                       extent = ext(height.ras))
plot(shademap, col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)))




shademap <- ray_shade(height.mat,
                                 sunaltitude = 30,
                                 sunangle = 90) |>
  plot_map()

shademap <- calc_shade(height.mat,
                       sun.altitude = 70,
                       sun.angle = 270,
                       crs = crs(height.ras),
                       extent = ext(height.ras))


shademap
plot(shademap, col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)))


##########

hmat <- matrix(data = rep(0, 9*9), nrow = 9, ncol = 9, byrow = TRUE)
hmat[5,5] <- 2
hmat

sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-07-01", hour = 10)
sunpos

ray_shade(t(hmat),
          sun.altitude = sunpos[1, "elevation"],
          sun.angle = sunpos[1, "azimuth"]) |>
  plot_map()

# lambert = FALSE
shademap <- calc_shade(t(hmat),
                       sun.altitude = sunpos[1, "elevation"],
                       sun.angle = sunpos[1, "azimuth"],
                       lambert = F)
plot(shademap)


# lambert = TRUE
shademap <- calc_shade(t(hmat),
                       sun.altitude = sunpos[1, "elevation"],
                       sun.angle = sunpos[1, "azimuth"],
                       lambert = T)
plot(shademap,
     col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)))
