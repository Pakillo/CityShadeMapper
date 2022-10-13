#' Calculate shaded route
#'
#' @param origin origin coordinates.
#' @param destination destination coordinates.
#' @param date Character. Date in YYYY-MM-DD format.
#' @param time Numeric. Hour in local time.
#' @param shadow Shadow raster map
#'
#'

calc_shaded_route <- function(origin = NULL, destination = NULL, date = NULL, time = NULL, shadow = NULL ) {

  # matrix of cost
  cost <- gdistance::transition(1/shadow=shadow,
                        transitionFunction=mean,
                        directions=8)

  #geocorrection
  cost_correction <- gdistance::geoCorrection(cost=cost, type = "c")

  #calculate route
  route <- gdistance::shortestPath(cost_correction=cost_correction, origin = origin, destination = destination,
                                  output="SpatialLines")

}





















