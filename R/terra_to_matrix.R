#' Convert a SpatRaster to matrix
#'
#' @param ras A [terra::SpatRaster()] object, or a path (character) to a raster file.
#'
#' @return A matrix
#' @export
#'
terra_to_matrix <- function(ras = NULL) {

  if (is.character(ras)) {
    ras <- terra::rast(ras)
  }

  out <- terra::as.matrix(ras, wide = TRUE)

  out

}


#' Convert a matrix into a SpatRaster
#'
#' @param mat A matrix
#' @param crs CRS of the resulting SpatRaster
#' @param ... Further arguments for [terra::rast()]
#'
#' @return A SpatRaster object
#' @export
#'

matrix_to_terra <- function(mat = NULL, crs = "", ...) {

  ras <- terra::rast(mat, crs = crs, ...)

  ras
}
