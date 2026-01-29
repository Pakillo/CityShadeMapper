# Get raster of cover classification from lidar points

Get raster of cover classification from lidar points

## Usage

``` r
rasterize_lidar_cover_class(
  las = NULL,
  res = 1,
  fill.holes = TRUE,
  low.veg.as.ground = TRUE,
  filename = NULL
)
```

## Arguments

- las:

  A
  [`lidR::LAScatalog-class()`](https://rdrr.io/pkg/lidR/man/LAScatalog-class.html)
  object, or a character vector with paths to LAS/LAZ objects, or a LAS
  object including point classifications.

- res:

  Resolution of the resulting raster.

- fill.holes:

  Logical. Try to fill holes in lidar point classification.

- low.veg.as.ground:

  Logical. Classify low vegetation (\<1 m high) as ground? Default is
  TRUE. If FALSE, low vegetation will be grouped together with medium
  and high vegetation.

- filename:

  Character. Output filename. Note that if a file already exists with
  that name, it will be overwritten.

## Value

A SpatRaster with the classification of cover types: 2 = ground
(including low vegetation \< 1m) 4 = high vegetation (\> 1m) 6 =
buildings 9 = water and NA values. Note that points classified as
bridges (class 17) will be reclassified as ground.

## Examples

``` r
if (FALSE) { # \dontrun{
pza <- system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper")
pza.cover <- rasterize_lidar_cover_class(pza)
} # }
```
