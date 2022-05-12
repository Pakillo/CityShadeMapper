#' Convert a SpatRaster to matrix
#'
#' @param ras A [terra::SpatRaster()] object, or a path (character) to a raster file.
#'
#' @return A matrix
#' @keywords internal
#'
terra_to_matrix <- function(ras = NULL) {

  if (is.character(ras)) {
    ras <- terra::rast(ras)
  }

  out <- t(terra::as.matrix(ras, wide = TRUE))

  out

}


#' Convert a matrix into a SpatRaster
#'
#' @param mat A matrix
#' @param crs CRS of the resulting SpatRaster
#' @param extent extent
#' @param ... Further arguments for [terra::rast()]
#'
#' @return A SpatRaster object
#' @keywords internal
#'

matrix_to_terra <- function(mat = NULL, crs = "", extent = NULL, ...) {

  ras <- terra::rast(mat, crs = crs, extent = extent, ...)

  ras
}
