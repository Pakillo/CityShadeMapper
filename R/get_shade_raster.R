#' Get shade raster
#'
#' Get a shade raster for given dates and hours
#'
#' @param height.ras A [terra::SpatRaster()] with heights data
#' @inheritParams calc_shade
#' @inheritDotParams calc_shade
#'
#' @return A (possibly multilayer) SpatRaster object with the intensity of shading
#' at each pixel for every date and time
#' @export
#'
get_shade_raster <- function(height.ras = NULL,
                         date = NULL,
                         hour = NULL,
                         filename = NULL,
                         ...) {

  # Find raster centre coordinates in lonlat
  lonlat <- find_city_lonlat(height.ras)

  sunpos <- get_sun_position(lon = lonlat$lon,
                             lat = lonlat$lat,
                             date = date,
                             hour = hour)

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
