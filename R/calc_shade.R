#' Calculate shades from elevation map
#'
#' @param heights Height matrix, as calculated by [terra_to_matrix()].
#' @param sun.altitude Sun altitude (angle from the horizon, in degrees)
#' @param sun.angle Sun angle in degrees (zero degrees is North, increasing clockwise)
#' @param ... further arguments to [rayshader::ray_shade()]
#'
#' @return
#' @export
#'
#' @examples
calc_shade <- function(heights = NULL, sun.altitude = NULL, sun.angle = NULL, ...) {

  shademap <- rayshader::ray_shade(heightmap = heights,
                                   sunaltitude = sun.altitude,
                                   sunangle = sun.angle,
                                   ...)

}
