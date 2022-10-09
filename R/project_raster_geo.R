project_raster_geo_vect <- function(ras = NULL, filename = NULL) {

  pts <- terra::as.points(ras, na.rm = FALSE)
  pts.geo <- terra::project(pts, y = "epsg:4326")

  ext.geo <- terra::ext(terra::project(terra::as.polygons(terra::ext(ras),
                                                          crs = terra::crs(ras)),
                                       y = "epsg:4326"))
  template <- terra::rast(nrows = terra::nrow(ras),
                          ncols = terra::ncol(ras),
                          crs = "epsg:4326",
                          extent = ext.geo)

  ras.geo <- terra::rasterize(pts.geo, y = template, field = names(ras))

  if (!is.null(filename)) {
    terra::writeRaster(ras.geo, filename = filename, overwrite = TRUE, datatype = "INT1U")
    ras.geo <- terra::rast(filename)
  }

  ras.geo

}


project_raster_geo <- function(ras = NULL, filename = NULL) {

  ext.geo <- terra::ext(terra::project(terra::as.polygons(terra::ext(ras),
                                                          crs = terra::crs(ras)),
                                       y = "epsg:4326"))
  template <- terra::rast(nrows = terra::nrow(ras),
                          ncols = terra::ncol(ras),
                          crs = "epsg:4326",
                          extent = ext.geo)

  ras.geo <- terra::project(ras, template)
  ras.geo <- round(ras.geo)

  if (!is.null(filename)) {
    terra::writeRaster(ras.geo, filename = filename, overwrite = TRUE, datatype = "INT1U")
    ras.geo <- terra::rast(filename)
  }

  ras.geo

}

