# Calculate shaded route

Calculate shaded route

## Usage

``` r
calc_shaded_route(origin = NULL, destination = NULL, shaderas = NULL)
```

## Arguments

- origin:

  A character vector describing an address, an `sf` or a `SpatVector`
  object.

- destination:

  A character vector describing an address, an `sf` or a `SpatVector`
  object.

- shaderas:

  Shade raster

## Value

A SpatVector object with the optimal route

## Examples

``` r
if (FALSE) { # \dontrun{
shaderas <- terra::rast("/vsicurl/https://zenodo.org/record/7213637/files/m7_h13_ground.tif")
shade.route <- calc_shaded_route("Plaza Nueva, Sevilla", "Mateos Gago, Sevilla", shaderas)

library(leaflet)
leaflet(sf::st_as_sf(shade.route)) |>
  leaflet::addWMSTiles(baseUrl = "https://www.ign.es/wms-inspire/ign-base",
  layers = "IGNBaseTodo-nofondo") |>
  leaflet::addTiles(urlTemplate =
    "https://mapasdesombra.github.io/Sevilla-jul-ground/13/{z}/{x}/{y}.png",
  options = leaflet::tileOptions(minZoom = 15, maxZoom = 18, tms = TRUE, opacity = 0.4)) |>
  addPolylines(weight = 8, opacity = 0.8)

} # }
```
