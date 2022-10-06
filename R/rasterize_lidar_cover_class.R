#' Rasterize cover classification of lidar points
#'
#' @param las Path to a LAS/LAZ object.
#' @param res Resolution of the resulting raster.
#'
#' @return A SpatRaster with the classification of cover types:
#' 9 = water, 6 = buildings, 5 = vegetation > 3m, 4 = vegetation between 1 and 3 m high,
#' 3 = vegetation < 1m, 2 = ground.
#'
#' @examples
#' pza <- PlazaNueva()
#' pza.cover <- rasterize_lidar_cover_class(pza)
rasterize_lidar_cover_class <- function(las = NULL, res = 1) {

  pts <- lidR::readLAS(las, select = "xyc", filter = "-keep_class 2 3 4 5 6 9 17")
  #table(pts$Classification)
  # reclassify bridges as ground
  pts$Classification[pts$Classification == 17] <- as.integer(2)
  # see classes https://github.com/Pakillo/CityShadeMapper/issues/2#issuecomment-1117648511

  f <- function(x) {max(x)}
  pts.class <- lidR::pixel_metrics(pts, func = f(Classification), res = res)

  pts.class

}


