


project_raster <- function(ras = NULL,
                           proj = c("geo", "leaflet"),
                           filename = NULL) {

  proj <- match.arg(proj)

  if (proj == "geo") epsg = "epsg:4326"
  if (proj == "leaflet") epsg = "epsg:3857"

  new.ext <- terra::ext(terra::project(terra::as.polygons(terra::ext(ras),
                                                          crs = terra::crs(ras)),
                                       y = epsg))
  template <- terra::rast(nrows = terra::nrow(ras),
                          ncols = terra::ncol(ras),
                          crs = epsg,
                          extent = new.ext)

  ras.proj <- terra::project(ras, template)
  ras.proj <- round(ras.proj)

  if (!is.null(filename)) {
    terra::writeRaster(ras.proj, filename = filename, overwrite = TRUE, datatype = "INT1U")
    ras.proj <- terra::rast(filename)
  }

  ras.proj

}

# projecting via transformation to vectorial
# seems slower

# project_raster_geo_vect <- function(ras = NULL, filename = NULL) {
#
#   pts <- terra::as.points(ras, na.rm = FALSE)
#   pts.geo <- terra::project(pts, y = "epsg:4326")
#
#   ext.geo <- terra::ext(terra::project(terra::as.polygons(terra::ext(ras),
#                                                           crs = terra::crs(ras)),
#                                        y = "epsg:4326"))
#   template <- terra::rast(nrows = terra::nrow(ras),
#                           ncols = terra::ncol(ras),
#                           crs = "epsg:4326",
#                           extent = ext.geo)
#
#   ras.geo <- terra::rasterize(pts.geo, y = template, field = names(ras))
#
#   if (!is.null(filename)) {
#     terra::writeRaster(ras.geo, filename = filename, overwrite = TRUE, datatype = "INT1U")
#     ras.geo <- terra::rast(filename)
#   }
#
#   ras.geo
#
# }

