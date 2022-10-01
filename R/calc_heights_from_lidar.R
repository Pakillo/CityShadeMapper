#' Calculate height LiDAR
#'
#' @param las Lidar data as LAS or LAScatalog from lidR package format
#' @param res Resolution of the raster height
#' @param thresholds Set of height thresholds (see lidR package for more information)
#' @param ... further arguments to [lidR::pitfree()]
#' @return SpatRaster object with height LiDAR data
#' @export
#'
#' @examples
#'
#'
calc_heights_from_lidar <- function(las = NULL,
                                    res = 1,
                                    thresholds = c(0,2,5,10,20),
                                    ...
) {
  stopifnot(class(las) == "LAS" | class(las) == "LAScatalog")
  stopifnot(is.numeric(res) | class(res) == "SpatRaster" )
  if (is.numeric(res)) {
    stopifnot(res > 0)
  }
  stopifnot(is.numeric(thresholds), length(thresholds) > 1)

  height_canopy <- lidR::rasterize_canopy(
    las = las,
    res = res,
    lidR::pitfree(thresholds, ...)
    )

  height_ground <- lidR::rasterize_terrain(
    las = las,
    res = res
  )

  height_diff <- height_canopy - height_ground
  is_ground <- height_diff < 1

  heights <- c(height_canopy, height_ground, is_ground)


}



