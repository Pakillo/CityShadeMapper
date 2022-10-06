#' Single building example
#'
#' An example 9 x 9 meter SpatRaster with a 4 m tall building in the middle.
#'
#' @export
#' @return A SpatRaster.
#'
example_building <- function() {
  terra::rast(system.file("extdata", "building.tif", package = "CityShadeMapper",
                          mustWork = TRUE))
}

#' Single tree example
#'
#' An example 9 x 9 meter SpatRaster with a 4 m tall tree in the middle.
#'
#' @export
#' @return A SpatRaster.
example_tree <- function() {
  terra::rast(system.file("extdata", "single_tree.tif", package = "CityShadeMapper",
                          mustWork = TRUE))
}


#' Square example
#'
#' An example 100 x 100 meter SpatRaster with a 10 m tall rectangular wall and
#' a 4-m tall tree in the middle.
#'
#' @export
#' @return A SpatRaster.
example_square <- function() {
  terra::rast(system.file("extdata", "square.tif", package = "CityShadeMapper",
                          mustWork = TRUE))
}



#' Plaza Nueva LiDAR data
#'
#' LiDAR data of Plaza Nueva in Sevilla, Spain.
#' Data provided by LiDAR-PNOA 2018 CC-BY 4.0 scne.es.
#'
#' @export
#' @return A LAScatalog.
PlazaNueva <- function() {
  lidR::readLAS(system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper",
                          mustWork = TRUE))
}


