#' Generate height raster from LiDAR data
#'
#' @param las LiDAR data (a [lidR::LAS-class()] or [lidR::LAScatalog-class()] object).
#' @param res Spatial resolution of the raster
#' @param ground Logical. Calculate ground height in addition to canopy/roof heights?
#' @param thresholds Set of height thresholds (see [lidR::dsm_pitfree()]).
#' @param filename Character. Output filename. Note that if a file already exists
#' with that name, it will be overwritten.
#' @param ... further arguments to [lidR::pitfree()]
#'
#' @return SpatRaster with height data
#' @export
#'
#' @examples
#' \dontrun{
#' heights <- calc_heights_from_lidar(PlazaNueva())
#' }
#'
calc_heights_from_lidar <- function(las = NULL,
                                    res = 1,
                                    ground = FALSE,
                                    thresholds = c(0,2,5,10,20),
                                    filename = NULL,
                                    ...) {
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

  if (isTRUE(ground)) {

    height_ground <- lidR::rasterize_terrain(
      las = las,
      res = res
    )

    height_diff <- height_canopy - height_ground
    is_ground <- height_diff < 1

    heights <- c(height_canopy, height_ground, is_ground)
    names(heights) <- c("height_canopy", "height_ground", "is_ground")
    # a SpatRaster with 3 layers

  } else {
    heights <- height_canopy
    names(heights) <- "height_canopy"
  }

  if (!is.null(filename)) {
    terra::writeRaster(heights, filename = filename, overwrite = TRUE)
    heights <- terra::rast(filename)
  }


  return(heights)


}



