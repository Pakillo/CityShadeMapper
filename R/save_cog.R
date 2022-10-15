#' Save raster as Cloud Optimised GeoTiff
#'
#' Requires GDAL >= 3.1
#'
#' @param ras A SpatRaster (e.g. a shade raster as produced by [make_shademap()]).
#' @param filename Character. Output filename. Must end with '.tif' extension.
#'
#' @return A cloud optimised geotiff saved on disk.
#' @keywords internal
#'
save_cog <- function(ras = NULL, filename = NULL) {

  if (terra::crs(ras, describe = TRUE)$code != "4326") {
    warning("This raster does not have EPSG:4326 projection.")
  }

  terra::writeRaster(ras,
                     filename = filename,
                     filetype = "COG",
                     datatype = "INT1U")

}
