#' Get raster of cover classification from lidar points
#'
#' @param las A [lidR::LAScatalog-class()] object, or a character vector with
#' paths to LAS/LAZ objects.
#' @param res Resolution of the resulting raster.
#' @param fill.holes Logical. Try to fill holes in lidar point classification.
#' @param filename Character. Output filename. Note that if a file already exists
#' with that name, it will be overwritten.
#'
#' @return A SpatRaster with the classification of cover types:
#' 2 = ground (including low vegetation < 1m)
#' 4 = high vegetation (> 1m)
#' 6 = buildings
#' 9 = water
#' and NA values.
#' Note that points classified as bridges (class 17) will be reclassified as ground.
#' @export
#'
#' @examples
#' \dontrun{
#' pza <- system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper")
#' pza.cover <- rasterize_lidar_cover_class(pza)
#' }
rasterize_lidar_cover_class <- function(las = NULL,
                                        res = 1,
                                        fill.holes = TRUE,
                                        filename = NULL) {

  pts <- lidR::readLAS(las, select = "xyc", filter = "-keep_class 2 3 4 5 6 9 17")
  #table(pts$Classification)
  # see classes https://github.com/Pakillo/CityShadeMapper/issues/2#issuecomment-1117648511
  # reclassify bridges as ground
  pts$Classification[pts$Classification == 17] <- as.integer(2)
  # reclassify low vegetation (<1m) as ground
  pts$Classification[pts$Classification == 3] <- as.integer(2)
  # join classes 4 & 5 (vegetation > 1m high)
  pts$Classification[pts$Classification == 5] <- as.integer(4)

  pts.class <- lidR::pixel_metrics(pts, func = max.class(Classification), res = res)

  if (isTRUE(fill.holes)) {
    pts.class <- fill_holes(pts.class)
  }

  if (!is.null(filename)) {
    terra::writeRaster(pts.class, filename = filename, overwrite = TRUE, datatype = "INT1U")
    pts.class <- terra::rast(filename)
  }

  pts.class

}


max.class <- function(x) {max(x, na.rm = TRUE)}

fill_holes <- function(ras = NULL) {

  # try to fill holes (NA) in lidar classification of points
  ras.agg <- terra::aggregate(ras, fact = 2, fun = "modal", na.rm = TRUE)
  ras.disagg <- terra::disagg(ras.agg, fact = 2, method = "near")

}
