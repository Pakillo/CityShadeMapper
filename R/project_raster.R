


project_raster <- function(ras = NULL,
                           proj = c("geo", "leaflet"),
                           epsg = NULL,
                           res = NULL,
                           method = c("near", "bilinear"),
                           filename = NULL) {

  # if epsg provided, use it (over proj arg)
  if (!is.null(epsg)) {
    epsg = paste0("epsg:", epsg)
  } else {
    proj <- match.arg(proj)
    if (proj == "geo") epsg = "epsg:4326"
    if (proj == "leaflet") epsg = "epsg:3857"
  }

  new.ext <- terra::ext(terra::project(terra::as.polygons(terra::ext(ras),
                                                          crs = terra::crs(ras)),
                                       y = epsg))

  if (!is.null(res)) {
    template <- terra::rast(resolution = res,
                            crs = epsg,
                            extent = new.ext)
  } else {
    template <- terra::rast(nrows = terra::nrow(ras),
                            ncols = terra::ncol(ras),
                            crs = epsg,
                            extent = new.ext)
  }


  method = match.arg(method)
  ras.proj <- terra::project(ras, template, method = method)
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

