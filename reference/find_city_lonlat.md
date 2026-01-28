# Find city centre coordinates

Find the city centre coordinates (longitude & latitude) from the
provided raster.

## Usage

``` r
find_city_lonlat(ras = NULL)
```

## Arguments

- ras:

  A
  [`terra::SpatRaster()`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
  object. Must have a defined CRS

## Value

A list with two elements: lon and lat, in geographic coordinates.
