#' Read LiDAR data
#'
#' @param folder Character. Path to folder containing las/laz files.
#' Can also be a vector of file paths.
#' @param filter Character. Optional. Use if you want to filter out some data points.
#' For LiDAR data from Spain's PNOA, we recommend filtering out noisy data points (class = 7).
#' @param ... Further arguments for [lidR::readLAScatalog()].
#'
#' @return LAScatalog object with LiDAR data
#' @export
#'
#'
read_lidar <- function(folder = NULL,
                       filter = "-drop_class 7",
                       ...) {

  lidR::readLAScatalog(folder = folder,
                       filter = filter,
                       ...)

}




