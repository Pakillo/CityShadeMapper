#' Save raster as Cloud Optimised GeoTiff
#'
#' @param ras A shade raster as produced by [make_shademap()].
#' @param filename Character. Output filename.
#'
#' @return A cloud optimised geotiff saved on disk.
#' @export
#'
save_cog <- function(ras = NULL, filename = NULL) {

  if (terra::crs(ras, describe = TRUE)$code != "4326") {
    ras <- project_raster_geo(ras)
  }

  terra::writeRaster(ras,
                     filename = filename,
                     filetype = "GTiff",
                     datatype = "INT1U",
                     gdal = c("TILED=YES",
                              "COPY_SRC_OVERVIEWS=YES",
                              "COMPRESS=DEFLATE"))

}
