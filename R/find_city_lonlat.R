#' Find city centre coordinates
#'
#' Find the city centre coordinates (longitude & latitude) from the provided raster.
#'
#' @param ras A [terra::SpatRaster()] object. Must have a defined CRS
#'
#' @return A list with two elements: lon and lat, in geographic coordinates.
#' @keywords internal
#'
find_city_lonlat <- function(ras = NULL) {

  ras.center <- matrix(
    c(mean(c(terra::xmin(ras), terra::xmax(ras))),
      mean(c(terra::ymin(ras), terra::ymax(ras)))),
    nrow = 1, ncol = 2, byrow = TRUE
  )

  ras.vec <- terra::vect(ras.center, type = "points", crs = terra::crs(ras))

  ras.proj <- terra::project(ras.vec, y = "epsg:4326")

  # as there's only 1 point, xmin == xmax & ymin == ymax
  stopifnot(terra::xmin(ras.proj) == terra::xmax(ras.proj),
            terra::ymin(ras.proj) == terra::ymax(ras.proj))

  lonlat <- list(lon = terra::xmin(ras.proj), lat = terra::ymin(ras.proj))

  stopifnot(is.numeric(lonlat$lon), lonlat$lon > -180, lonlat$lon < 180)
  stopifnot(is.numeric(lonlat$lat), lonlat$lat > -90, lonlat$lat < 90)

  lonlat

}
