#' Move point locations to the nearest raster cell with data
#'
#' Move point locations falling in raster cells without data (i.e. NA) to the
#' nearest raster cell with data.
#'
#' @param locs A point `sf` object.
#' @param ras A SpatRaster.
#' @param layer Integer. For multilayer rasters, which layer to use.
#' @return A sf object (with corrected coordinates if move is TRUE).
#' @keywords internal


movepoints2nearestcell <- function(locs = NULL,
                                   ras = NULL,
                                   layer = 1
) {

  if (!inherits(locs, "SpatVector")) locs <- terra::vect(locs)

  miss <- point_in_cell(locs, ras, layer)

  ## if there are NA cells...

  if (sum(miss) > 0) {

    coord.miss <- terra::crds(locs[miss, ])  # points without data
    if (terra::nlyr(ras) > 1) ras <- terra::subset(ras, layer)
    # get coordinates of raster cells with data
    cells.notNA <- terra::as.points(ras, values = FALSE, na.rm = TRUE)
    coord.ras <- terra::crds(cells.notNA)
    cell.id <- factor(seq_len(nrow(coord.ras)))

    # find the nearest raster cell for each point with missing data
    nearest.cell <- class::knn1(coord.ras, coord.miss, cell.id)

    new.coords.mat <- matrix(coord.ras[nearest.cell, ], ncol = 2)
    # colnames(new.coords) <- c("longitude_new", "latitude_new")
    new.coords <- terra::vect(new.coords.mat, type = "points",
                              crs = terra::crs(locs))
    terra::values(new.coords) <- terra::values(locs[miss, ])

    if (terra::nrow(locs) > 1) {   # assign new coordinates to those points
      # locs.new <- locs
      # locs.new[miss, ] <- new.coords
      locs.new <- rbind(locs[!miss], new.coords)
      # TO DO: return same order as original locs
    } else {
      locs.new = new.coords
    }

  } else {
    message("All points fall within a raster cell")
  }

  return(locs.new)

}


#' Do points (occurrences) fall within raster cells?
#'
#' This function examines which points fall within a raster cell with data (not NA).
#' Returns TRUE for points falling in a raster cell with data, and FALSE otherwise.
#'
#' @param locs A point `sf` or `SpatVector` object with (x, y) coordinates
#' @param ras SpatRaster object
#' @param layer Integer. For multilayer rasters, which layer to use to compare
#' with point locations (default = 1).
#'
#' @return A logical vector.
#' @keywords internal
#'
point_in_cell <- function(locs = NULL, ras = NULL, layer = 1){

  # if (!isTRUE(raster::compareCRS(locs, ras))){
  #   stop("Coordinate data and raster object must have the same projection. Check their CRS or proj4string")
  #
  # } else {

  if (!inherits(locs, "SpatVector")) locs <- terra::vect(locs)

  if (terra::nlyr(ras) > 1) ras <- terra::subset(ras, layer)
  ## Get NA cells
  rasvals <- terra::extract(ras, locs, ID = FALSE)
  missing <- is.na(rasvals)
  missing

}
