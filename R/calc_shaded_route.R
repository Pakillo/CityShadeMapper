#' Calculate shaded route
#'
#' @param origin origin coordinates.
#' @param destination destination coordinates.
#' @param shaderas Shade raster
#'
#' @export
#' @return A SpatVector object with the optimal route
#'

calc_shaded_route <- function(origin = NULL,
                              dest = NULL,
                              shaderas = NULL ) {

  if (!inherits(origin, "SpatVector")) origin <- terra::vect(origin)
  if (!inherits(dest, "SpatVector")) dest <- terra::vect(dest)

  # Crop shaderas
  zona <- terra::ext(rbind(origin, dest))
  expansion = 0.002
  zona$xmin = zona$xmin - expansion
  zona$xmax = zona$xmax + expansion
  zona$ymin = zona$ymin - expansion
  zona$ymax = zona$ymax + expansion
  shaderas <- terra::crop(shaderas, zona)

  shaderas = 100 - shaderas
  shaderas[!is.na(shaderas) & shaderas < 1] <- 1

  # Move points to nearest raster cell with data
  origin.new <- movepoints2nearestcell(origin, shaderas)
  dest.new <- movepoints2nearestcell(dest, shaderas)

  #matrix of cost
  cost <- gdistance::transition(raster::raster(shaderas),
                        transitionFunction = mean,
                        directions = 8)

  #geocorrection
  cost_correction <- gdistance::geoCorrection(cost, type = "c", scl = TRUE)

  #calculate route
  route <- gdistance::shortestPath(cost_correction,
                                   origin = terra::crds(origin.new),
                                   goal = terra::crds(dest.new),
                                  output = "SpatialLines")

  route <- terra::vect(route)


}

