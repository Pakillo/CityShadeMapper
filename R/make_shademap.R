#' Calculate shade map
#'
#' Calculate shade raster for given dates and hours
#'
#' @param height.ras A [terra::SpatRaster()] with heights data.
#' Note `height.ras` must have a well defined `crs` (see [terra::crs()]).
#' @inheritParams get_sun_position
#' @param type Character. Either 'canopy' to get illumination at the canopy/roof level, or
#' 'ground' to get illumination at the ground level (i.e. for pedestrians).
#' @param cover.ras A SpatRaster containing cover classes (ground, vegetation, buildings...).
#' See [rasterize_lidar_cover_class()].
#' @param zscale Default `1`. The ratio between the x and y spacing (which are assumed to be equal)
#'  and the z axis. For example, if the elevation is in units of meters and the grid values
#'   are separated by 10 meters, `zscale` would be 10.
#' @param filename Character. Output filename. Note that if a file already exists
#' with that name, it will be overwritten.
#' @param ... further arguments to [rayshader::ray_shade()]
#'
#' @return A (possibly multilayer) SpatRaster object with the intensity of illumination
#' at each pixel for every date and time
#' @export
#'
#' @examples
#' \dontrun{
#' lidar <- PlazaNueva()
#' heights <- calc_heights_from_lidar(lidar)
#' shaderas <- make_shademap(heights, date = "2022-10-15", hour = 13)
#' plot_shademap(shaderas, smooth = TRUE)
#' shaderas <- make_shademap(heights, date = "2022-10-15", hour = 8:20)
#' plot_shademap(shaderas, animate = TRUE, smooth = TRUE)
#' shaderas <- make_shademap(heights, date = "2022-07-15", hour = 8:21)
#' plot_shademap(shaderas, animate = TRUE, smooth = TRUE)
#' shaderas <- make_shademap(heights, date = c("2022-07-15", "2022-10-15"), hour = 13)
#' plot_shademap(shaderas, legend = FALSE)
#'
#' ## Ground-level shade maps require additional raster with cover classes
#' lidar <- read_lidar(system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper"))
#' cover.ras <- rasterize_lidar_cover_class(lidar)
#' shaderas <- make_shademap(heights, date = "2022-10-15", hour = 13,
#'   type = "ground", cover.ras = cover.ras)
#'
#' }
make_shademap <- function(height.ras = NULL,
                          date = NULL,
                          hour = NULL,
                          type = c("canopy", "ground"),
                          cover.ras = NULL,
                          zscale = 1,
                          omit.nights = TRUE,
                          filename = NULL,
                          ...) {

  shademap <- make_shademap_canopy(height.ras = height.ras,
                                   date = date,
                                   hour = hour,
                                   zscale = zscale,
                                   omit.nights = omit.nights,
                                   filename = NULL,
                                   ...)

  type <- match.arg(type)

  if (type == "ground") {
    shademap <- make_shademap_ground(shademap.canopy = shademap,
                                     cover.ras = cover.ras,
                                     filename = NULL)
  }

  if (!is.null(filename)) {
    terra::writeRaster(shademap, filename = filename, overwrite = TRUE, datatype = "INT1U")
    shademap <- terra::rast(filename)
  }

  shademap

}


make_shademap_canopy <- function(height.ras = NULL,
                                 date = NULL,
                                 hour = NULL,
                                 zscale = 1,
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

  height.mat <- terra_to_matrix(terra::subset(height.ras, "height_canopy"))

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
    terra::writeRaster(shaderas, filename = filename, overwrite = TRUE, datatype = "INT1U")
    shaderas <- terra::rast(filename)
  }

  shaderas

}


#' Calculate shade map at the ground level
#'
#' @param shademap.canopy A SpatRaster with the illumination at the canopy level,
#' made with [make_shademap()].
#' @param cover.ras A SpatRaster containing cover classes (ground, vegetation, buildings...).
#' See [rasterize_lidar_cover_class()].
#' @param filename Character. Output filename. Note that if a file already exists
#' with that name, it will be overwritten.
#'
#' @return A (possibly multilayer) SpatRaster object with the intensity of illumination
#' at the ground level
#' @export
#'
#' @examples
#' \dontrun{
#' lidar <- read_lidar(system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper"))
#' cover.ras <- rasterize_lidar_cover_class(lidar)
#' shaderas.canopy <- make_shademap(heights, date = "2022-10-15", hour = 13)
#' shaderas.ground <- make_shademap_ground(shaderas.canopy, cover.ras)
#'
#' ## Alternatively, call make_shademap directly:
#' heights <- calc_heights_from_lidar(lidar)
#' shaderas.ground <- make_shademap(heights, date = "2022-10-15", hour = 13,
#'   type = "ground", cover.ras = cover.ras)
#' }
make_shademap_ground <- function(shademap.canopy = NULL,
                                 cover.ras = NULL,
                                 filename = NULL) {

  if (is.null(cover.ras)) stop("cover.ras is required.")
  if (!all(unique(terra::values(cover.ras)) %in% c(2, 4, 6, 9, NA, NaN)))
    stop("Allowed values for 'cover.ras' are only 2, 4, 6, 9, NaN or NA.")

  # Set buildings as NA
  shademap.canopy[cover.ras == 6] <- NA
  # Set water also as NA
  shademap.canopy[cover.ras == 9] <- NA

  # Reassign values under vegetation
  shademap.canopy[cover.ras == 4] <- 05  # fixed value by now

  if (!is.null(filename)) {
    terra::writeRaster(shademap.canopy, filename = filename, overwrite = TRUE, datatype = "INT1U")
    shademap.canopy <- terra::rast(filename)
  }

  shademap.canopy

}
