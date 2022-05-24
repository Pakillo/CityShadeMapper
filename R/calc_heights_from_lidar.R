#' Calculate height LiDAR
#'
#' @param las Lidar data
#' @param res Resolution of the raster height
#' @param thresholds
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

  dsm_height <- lidR::rasterize_canopy(las = las,
                                       res = res,
                                       lidR::pitfree(thresholds, ...))

}



