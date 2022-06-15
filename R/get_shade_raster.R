#' Get shade raster
#'
#' Get a shade raster for given dates and hours
#'
#' @param height.ras A [terra::SpatRaster()] with heights data.
#' Note `height.ras` must have a well defined `crs` (see [terra::crs()]).
#' @inheritParams get_sun_position
#' @param zscale Default `1`. The ratio between the x and y spacing (which are assumed to be equal)
#'  and the z axis. For example, if the elevation is in units of meters and the grid values
#'   are separated by 10 meters, `zscale` would be 10.
#' @param filename Character. Optional. Provide a filename to save the output raster on disk.
#' @param ... further arguments to [rayshader::ray_shade()]
#'
#' @return A (possibly multilayer) SpatRaster object with the intensity of shading
#' at each pixel for every date and time
#' @export
#'
#' @examples
#' library(rayshader)
#' library(terra)
#' data(montereybay)
#' height.ras <- rast(t(montereybay),
#' crs = attr(montereybay, "crs"),
#' extent = attr(montereybay, "extent"))
#' shaderas <- get_shade_raster(height.ras, date = "2020-01-05", hour = 11:14, zscale = 200)
#' plot(shaderas, col = rev(colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)))
#'
#' height.ras <- rast(nrows = 10, ncols = 10, xmin = -6, xmax = -5, ymin = 37, ymax = 38,
#' crs = "epsg:4326", vals = rep(0, 10*10))
#' height.ras[5,5] <- 8
#' shaderas <- get_shade_raster(height.ras, date = "2020-01-05", hour = 11:14)
#' shaderas <- get_shade_raster(height.ras, date = "2020-01-05", hour = 06:14)
#' shaderas <- get_shade_raster(height.ras, date = "2020-01-05", hour = 06:14, omit.nights = FALSE)
get_shade_raster <- function(height.ras = NULL,
                             zscale = 1,
                             date = NULL,
                             hour = NULL,
                             omit.nights = TRUE,
                             filename = NULL,
                             ...) {

  if (terra::crs(height.ras) == "") {
    stop("height.ras must have a Coordinate Reference System (crs) defined. See ?terra::crs\n")
  }

  # Find raster centre coordinates in lonlat
  lonlat <- find_city_lonlat(height.ras)

  sunpos <- get_sun_position(lon = lonlat$lon,
                             lat = lonlat$lat,
                             date = date,
                             hour = hour,
                             omit.nights = omit.nights)

  height.mat <- terra_to_matrix(height.ras)

  ## Calculate shade raster for every date and hour
  # producing list of SpatRaster, then joining into single SpatRaster
  # could use future_lapply to parallelise
  # or use multicore = TRUE when calling calc_shade, see ?ray_shade
  # may be necessary to save each raster on disk rather than memory?

  shaderas.list <- vector("list", nrow(sunpos))

  for (i in seq_len(nrow(sunpos))) {
    shaderas.list[[i]] <- calc_shade(height.mat,
                                     sun.altitude = sunpos$elevation[i],
                                     sun.angle = sunpos$azimuth[i],
                                     crs = terra::crs(height.ras),
                                     extent = terra::ext(height.ras),
                                     filename = tempfile(
                                       pattern = "shaderas",
                                       fileext = ".tif"),
                                     ...)
    names(shaderas.list[[i]]) <- paste(sunpos$date[i], sunpos$hour[i], sep = ".")
  }

  # Create single SpatRaster from list of rasters
  shaderas <- shaderas.list[[1]]
  if (length(shaderas.list) > 1) {
    for (i in 2:length(shaderas.list)) {
      terra::add(shaderas) <- shaderas.list[[i]]
    }
  }

  if (!is.null(filename)) {
    terra::writeRaster(shaderas, filename = filename)
    shaderas <- terra::rast(filename)
  }

  shaderas

}
