#' Calculate shades from elevation map
#'
#' @param height.mat Height matrix, as calculated by [terra_to_matrix()].
#' @param sun.altitude Sun altitude (angle from the horizon, in degrees)
#' @param sun.angle Sun angle in degrees (zero degrees is North, increasing clockwise)
#' @param zscale Default `1`. The ratio between the x and y spacing (which are assumed to be equal)
#'  and the z axis. For example, if the elevation is in units of meters and the grid values
#'   are separated by 10 meters, `zscale` would be 10.
#' @param crs coordinate reference system, see [terra::crs()]
#' @param extent raster extent, see [terra::ext()]
#' @param filename Character. Optional. Provide a filename to save the output raster on disk.
#' @param ... further arguments to [rayshader::ray_shade()]
#'
#' @return A SpatRaster of light intensities, as produced by [rayshader::ray_shade()]
#' @keywords internal
#' @examples
#' \dontrun{
#' lidar.file <- system.file("extdata", "PlazaNueva.laz",
#' package = "CityShadeMapper", mustWork = TRUE)
#' lidar <- read_lidar(lidar.file)
#' heights <- calc_heights_from_lidar(lidar)
#' library(terra)
#' height.mat <- CityShadeMapper:::terra_to_matrix(subset(heights, 1))
#' sun.pos <- get_sun_position(lon = -5.99567, lat = 37.38876, date = "2022-10-18", hour = 15)
#' shaderas <- calc_shade(height.mat, sun.altitude = sun.pos$elevation,
#' sun.angle = sun.pos$azimuth,
#' crs = crs(heights), extent = ext(heights))
#' plot_shademap(shaderas)
#' }

calc_shade <- function(height.mat = NULL,
                       sun.altitude = NULL,
                       sun.angle = NULL,
                       zscale = 1,
                       crs = "",
                       extent = NULL,
                       filename = NULL,
                       ...) {

  shademat <- rayshader::ray_shade(heightmap = height.mat,
                                   sunaltitude = sun.altitude,
                                   sunangle = sun.angle,
                                   zscale = zscale,
                                   ...)

  shademat <- round(shademat*100, digits = 0)

  shaderas <- matrix_to_terra(t(shademat), crs = crs, extent = extent)

  shaderas <- terra::flip(shaderas, direction = "horizontal")

  if (!is.null(filename)) {
    terra::writeRaster(shaderas, filename = filename)
    shaderas <- terra::rast(filename)
  }

  shaderas

}
