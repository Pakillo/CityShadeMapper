#' Plot shade map
#'
#' @param shade.ras A [terra::SpatRaster()] object with shade intensity, as produced by [get_shade_raster()].
#' @param legend Logical. Show legend?
#' @param animate Logical. Show animation of all the `shade.ras` layers?
#' @param ... Further arguments to [terra::plot()], or to [terra::animate()] if `animate` is `TRUE`.
#'
#' @return A static or animated plot.
#' @export
#'
plot_shademap <- function(shade.ras = NULL, legend = TRUE, animate = FALSE, ...) {

  if (animate) {

    terra::animate(shade.ras,
                   col = rev(grDevices::colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)),
                   axes = FALSE,
                   legend = legend,
                   ...)

  } else {

    terra::plot(shade.ras,
                col = rev(grDevices::colorRampPalette(RColorBrewer::brewer.pal(9, "Greys"))(20)),
                axes = FALSE,
                legend = legend,
                ...)

  }

}
