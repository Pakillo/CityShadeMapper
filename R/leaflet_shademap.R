#' Make leaflet shade map
#'
#' @param url.canopy Character. Url pointing to shade tiles at the canopy level.
#' @param url.ground Character. Url pointing to shade tiles at the ground level.
#' @param url.cog Character. Url pointing to a cloud-optimised geotiff
#' (starting with 'https://'). The COG raster must have EPSG:4326 projection.
#' Currently not implemented.
#' @param band Numeric. Band to show in multilayer rasters (only for COG).
#' @param satellite Logical. Add satellite images as another layer to the map?
#' @param opacity Numeric between 0 and 1. Opacity of the shade layer.
#'
#' @return A leaflet map
#' @export
#'
#' @examples
#' \dontrun{
#' leaflet_shademap(url.canopy = "https://mapasdesombra.github.io/prueba/tiles/{z}/{x}/{y}.png")
#' }
leaflet_shademap <- function(url.canopy = NULL,
                             url.ground = NULL,
                             url.cog = NULL,
                             band = 1,
                             satellite = FALSE,
                             opacity = 0.5) {

  if (is.null(url.canopy) & is.null(url.ground)) {
    stop("Either url.canopy or url.ground (or both) must be provided.")
  }
  if (!is.null(url.cog)) stop("COG currently not implemented")
  stopifnot(opacity >= 0 & opacity <= 1)

  lfmap <- leaflet::leaflet(options = leaflet::leafletOptions(minZoom = 15, maxZoom = 18)) |>
    leaflet::setView(lng = -5.99311, lat = 37.38599, zoom = 17) |>
    leaflet::addWMSTiles(baseUrl = "https://www.ign.es/wms-inspire/ign-base",
                         layers = "IGNBaseTodo-nofondo",
                         attribution = "Mapa base: CC BY 4.0 scne.es",
                         group = "Callejero")

  if (isTRUE(satellite)) {
    lfmap <- lfmap |>
      leaflet::addWMSTiles(baseUrl = "https://www.ign.es/wms-inspire/pnoa-ma",
                           layers = "OI.OrthoimageCoverage",
                           group = "Ortofotos")
    # addProviderTiles(provider = providers$Esri.WorldImagery)
    basemaps <- c("Callejero", "Ortofotos")
  } else {
    basemaps <- c("Callejero")
  }

  if (!is.null(url.canopy)) {
    lfmap <- lfmap |>
      leaflet::addTiles(urlTemplate = url.canopy,
                        options = leaflet::tileOptions(minZoom = 15, maxZoom = 18,
                                                       tms = TRUE, opacity = opacity),
                        group = "Sombra")
  }

  if (!is.null(url.ground)) {
    lfmap <- lfmap |>
      leaflet::addTiles(urlTemplate = url.ground,
                        options = leaflet::tileOptions(minZoom = 15, maxZoom = 18,
                                                       tms = TRUE, opacity = opacity),
                        group = "Sombra")
  }

  if (!is.null(url.canopy) & !is.null(url.ground)) {
    shademaps <- c("Tejados", "Suelo")
  } else {
    shademaps <- c("Sombra")
  }


  lfmap |>
    leaflet::addLayersControl(baseGroups = basemaps,
                              overlayGroups = shademaps,
                              options = leaflet::layersControlOptions(collapsed = FALSE,
                                                                      autoZIndex = FALSE)) |>
    leaflet.extras::addSearchOSM()


}




# leafem::addGeotiff(file = paste0("/vsicurl/", url),
#                    project = FALSE,
#                    group = "Sombra",
#                    # resolution = 300,
#                    bands = band,
#                    opacity = opacity,
#                    colorOptions = leafem::colorOptions(
#                      palette = grDevices::colorRampPalette(
#                        rev(RColorBrewer::brewer.pal(9, "Greys")))(20),
#                      na.color = "#bebebe22")
# ) |>
