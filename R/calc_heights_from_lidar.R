#' Generate height raster from LiDAR data
#'
#' @param las LiDAR data (a [lidR::LAS-class()] or [lidR::LAScatalog-class()] object).
#' @param res Spatial resolution of the raster
#' @param thresholds Set of height thresholds (see [lidR::dsm_pitfree()]).
#' @param ... further arguments to [lidR::pitfree()]
#' @return SpatRaster with height data
#' @export
#'
#' @examples
#' \dontrun{
#' lidar.file <- system.file("extdata", "PlazaNueva.laz",
#' package = "CityShadeMapper", mustWork = TRUE)
#' lidar <- read_lidar(lidar.file)
#' heights <- calc_heights_from_lidar(lidar)
#' }
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
    lidR::pitfree(thresholds, ...)  # try different algorithm?
    )



  # height_ground <- lidR::rasterize_terrain(
  #   las = las,
  #   res = res
  # )
  #
  # height_diff <- height_canopy - height_ground
  # is_ground <- height_diff < 1
  #
  # heights <- c(height_canopy, height_ground, is_ground)
  # a SpatRaster with 3 layers

}



