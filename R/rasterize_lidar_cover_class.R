#' Rasterize cover classification of lidar points
#'
#' @param las.file Path to a LAS/LAZ object.
#' @param res Resolution of the resulting raster.
#' @param group.classes Logical. Group classes in the output raster?
#'
#' @return A SpatRaster with the classification of cover types:
#' 9 = water, 6 = buildings, 5 = vegetation > 3m, 4 = vegetation between 1 and 3 m high,
#' 3 = vegetation < 1m, 2 = ground.
#' Note that points classified as bridges (class 17) will be reclassified as ground.
#' If group.classes is TRUE, the output SpatRaster will only have three values:
#' 2 = ground (including low vegetation < 1m)
#' 4 = high vegetation (> 1m)
#' 6 = buildings
#' and NA values.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' pza <- system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper")
#' pza.cover <- rasterize_lidar_cover_class(pza)
#' }
rasterize_lidar_cover_class <- function(las.file = NULL, res = 1, group.classes = TRUE) {

  pts <- lidR::readLAS(las.file, select = "xyc", filter = "-keep_class 2 3 4 5 6 9 17")
  #table(pts$Classification)
  # reclassify bridges as ground
  pts$Classification[pts$Classification == 17] <- as.integer(2)
  # see classes https://github.com/Pakillo/CityShadeMapper/issues/2#issuecomment-1117648511

  pts.class <- lidR::pixel_metrics(pts, func = max.class(Classification), res = res)

  if (isTRUE(group.classes)) {
    pts.class <- reclassify_cover(pts.class)
  }

  pts.class

}


reclassify_cover <- function(ras = NULL) {
  terra::subst(ras, from = c(3, 5), to = c(2, 4))
  # Classify low vegetation < 1m (class 3) as ground (class 2)
  # Unify high vegetation (> 1m) as value 4
  # Value = 6 are buildings
}

max.class <- function(x) {max(x, na.rm = TRUE)}
