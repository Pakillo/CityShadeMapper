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
