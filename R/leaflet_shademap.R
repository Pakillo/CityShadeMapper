#' Make leaflet shade map
#'
#' @param url Character. Url pointing to a cloud-optimised geotiff
#' (starting with 'https://'). The COG raster must have EPSG:4326 projection.
#' @param orthoimages Logical. Add orthoimage layer to the map?
#'
#' @return A leaflet map
#' @export
#'
#' @examples
#' \dontrun{
#' leaflet_shademap(url = "https://www.dropbox.com/s/e6l434gmj9v0bpk/cog.tif?dl=1")
#' }
leaflet_shademap <- function(url = NULL, orthoimages = FALSE) {

  lfmap <- leaflet::leaflet(options = leaflet::leafletOptions(minZoom = 12, maxZoom = 18)) |>
    leaflet::addWMSTiles(baseUrl = "https://www.ign.es/wms-inspire/ign-base",
                         layers = "IGNBaseTodo-nofondo",
                         attribution = "Mapa base: CC BY 4.0 scne.es",
                         group = "Callejero")

  if (isTRUE(orthoimages)) {
    lfmap <- lfmap |>
      leaflet::addWMSTiles(baseUrl = "https://www.ign.es/wms-inspire/pnoa-ma",
                           layers = "OI.OrthoimageCoverage",
                           group = "Ortofotos")
    # addProviderTiles(provider = providers$Esri.WorldImagery)
    basemaps <- c("Callejero", "Ortofotos")
  } else {
    basemaps <- c("Callejero")
  }

  lfmap |>
    leafem::addGeotiff(file = paste0("/vsicurl/", url),
                       project = FALSE,
                       group = "Sombra",
                       # resolution = 300,
                       opacity = 0.2,
                       colorOptions = leafem::colorOptions(
                         palette = grDevices::colorRampPalette(
                           rev(RColorBrewer::brewer.pal(9, "Greys")))(20),
                         na.color = "#bebebe22")
    ) |>

    leaflet::addLayersControl(baseGroups = basemaps,
                              overlayGroups = c("Sombra"),
                              options = leaflet::layersControlOptions(collapsed = FALSE,
                                                                      autoZIndex = FALSE)) |>
    leaflet.extras::addSearchOSM()


}
