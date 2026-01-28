# Make leaflet shade map

Make leaflet shade map

## Usage

``` r
leaflet_shademap(
  url.canopy = NULL,
  url.ground = NULL,
  url.cog = NULL,
  band = 1,
  satellite = FALSE,
  opacity = 0.5
)
```

## Arguments

- url.canopy:

  Character. Url pointing to shade tiles at the canopy level.

- url.ground:

  Character. Url pointing to shade tiles at the ground level.

- url.cog:

  Character. Url pointing to a cloud-optimised geotiff (starting with
  'https://'). The COG raster must have EPSG:4326 projection. Currently
  not implemented.

- band:

  Numeric. Band to show in multilayer rasters (only for COG).

- satellite:

  Logical. Add satellite images as another layer to the map?

- opacity:

  Numeric between 0 and 1. Opacity of the shade layer.

## Value

A leaflet map

## Examples

``` r
if (FALSE) { # \dontrun{
leaflet_shademap(url.canopy = "https://mapasdesombra.github.io/Sevilla-jul-canopy/11/{z}/{x}/{y}.png")
} # }
```
