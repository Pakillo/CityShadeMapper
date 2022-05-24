#' Calculate shadow/not shadow place from LiDAR data
#'
#' @param las Lidar data as LAS or LAScatalog from lidR package format
#' @param algorithm An algorithm for spatial interpolation. lidR has tin, kriging, knnidw or a raster representing a digital terrain model.
#'
#' @return SpatRaster object
#' @export
#'
#' @examples
#'
#'
#'ctg_norm <- normalize_height(ctg, tin())
calc_shadow_place <- function(las = NULL,
                              algorithm = NULL,
                              ...
) {
  stopifnot(class(las) == "LAS" | class(las) == "LAScatalog")
  }
  las_normalize <- lidR::normalize_height(las = las,
                                          algorithm = tin())

}


x = NULL,

# classify the values into two groups
m <- c(0, 1, 0,
       1, ..., 1) # ¿maxima altura?
rclmat <- matrix(m, ncol=2, byrow=TRUE)
rc1 <- classify(r, rclmat, include.lowest=TRUE)


rc2 <- classify(r, c(0, 1, ...), include.lowest=TRUE, brackets=TRUE)





