#' #' Read LiDAR data
#'
#' @param path Copiado de lidr: The path of a folder containing a set of las/laz files. Can also be a vector of file paths.
#' @param filter Filter options of LiDAR data point class classification. By default it is established the filter of noisy data.
#'
#' @return LAScatalog object with LiDAR data
#' @export
#'
#' @examples
#'
#'
read_lidar <- function(path = NULL,
                       filter= "-drop_class 7",
                       ...) {
  laz <- lidR::readLAScatalog(patch = patch,
                              filter = filter)

}


laz <- readLAScatalog("C:/Users/Jesus/Documents", filter = "-drop_class 7")

