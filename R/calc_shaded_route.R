#' Calculate shaded route
#'
#' @param origin A character vector describing an address, an `sf` or a `SpatVector` object.
#' @param destination A character vector describing an address, an `sf` or a `SpatVector` object.
#' @param shaderas Shade raster
#'
#' @export
#' @return A SpatVector object with the optimal route
#'
#' @examples
#' \dontrun{
#' shaderas <- terra::rast("/vsicurl/https://zenodo.org/record/7213637/files/m7_h13_ground.tif")
#' shade.route <- calc_shaded_route("Plaza Nueva, Sevilla", "Mateos Gago, Sevilla", shaderas)
#'
#' library(leaflet)
#' leaflet(sf::st_as_sf(shade.route)) |>
#'   leaflet::addWMSTiles(baseUrl = "https://www.ign.es/wms-inspire/ign-base",
#'   layers = "IGNBaseTodo-nofondo") |>
#'   leaflet::addTiles(urlTemplate =
#'     "https://mapasdesombra.github.io/Sevilla-jul-ground/13/{z}/{x}/{y}.png",
#'   options = leaflet::tileOptions(minZoom = 15, maxZoom = 18, tms = TRUE, opacity = 0.4)) |>
#'   addPolylines(weight = 8, opacity = 0.8)
#'
#' }

calc_shaded_route <- function(origin = NULL,
                              destination = NULL,
                              shaderas = NULL
                              ) {

  if (is.character(origin)) {
    origin <- geocode_address(origin)
  }
  if (is.character(destination)) {
    destination <- geocode_address(destination)
  }

  if (!inherits(origin, "SpatVector")) origin <- terra::vect(origin)
  if (!inherits(destination, "SpatVector")) destination <- terra::vect(destination)

  # Crop shaderas
  zona <- terra::ext(rbind(origin, destination))
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
  destination.new <- movepoints2nearestcell(destination, shaderas)

  #matrix of cost
  cost <- gdistance::transition(raster::raster(shaderas),
                        transitionFunction = mean,
                        directions = 8)

  #geocorrection
  cost_correction <- gdistance::geoCorrection(cost, type = "c", scl = TRUE)

  #calculate route
  route <- gdistance::shortestPath(cost_correction,
                                   origin = terra::crds(origin.new),
                                   goal = terra::crds(destination.new),
                                  output = "SpatialLines")

  route <- terra::vect(route, crs = "epsg:4326")


}

