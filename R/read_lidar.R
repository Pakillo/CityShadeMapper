#' Read LiDAR data
#'
#' @param folder Character. Path to folder containing las/laz files.
#' Can also be a vector of file paths.
#' @param select Character. Point attributes to read from the las/laz files.
#' Use `select = "*"` to read all attributes. Default is "xyz" to save memory.
#' See [lidR::readLAS()] for more details.
#' @param filter Character. Optional. Use if you want to filter out some data points.
#' For example, we could filter out noisy data points (class = 7) using
#' `filter = "-drop_class 7"`. Use `filter = ""` to read all data points.
#' @param ... Further arguments for [lidR::readLAScatalog()].
#'
#' @return LAScatalog object with LiDAR data
#' @export
#' @examples
#' \dontrun{
#' las <- system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper")
#' lidar <- read_lidar(las)
#' }
#'
#'
read_lidar <- function(folder = NULL,
                       select = "xyz",
                       filter = "-drop_class 7",
                       ...) {

  lidR::readLAScatalog(folder = folder,
                       select = select,
                       filter = filter,
                       ...)

}



