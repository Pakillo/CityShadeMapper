#' Calculate shades from elevation map
#'
#' @param heights Height matrix, as calculated by [terra_to_matrix()].
#' @param sun.altitude Sun altitude (angle from the horizon, in degrees)
#' @param sun.angle Sun angle in degrees (zero degrees is North, increasing clockwise)
#' @param lambert Logical
#' @param crs coordinate reference system, see [terra::crs()]
#' @param ... further arguments to [rayshader::ray_shade()]
#'
#' @return A SpatRaster of light intensities, as produced by [rayshader::ray_shade()]
#' @export
#'

calc_shade <- function(heights = NULL,
                       sun.altitude = NULL, sun.angle = NULL,
                       lambert = TRUE,
                       crs = "", ...) {

   # Need to vectorize for sun altitude and angle

  shademat <- rayshader::ray_shade(heightmap = heights,
                                   sunaltitude = sun.altitude,
                                   sunangle = sun.angle,
                                   lambert = lambert,  # correct?
                                   ...)

  shaderas <- matrix_to_terra(shademat, crs)

}
