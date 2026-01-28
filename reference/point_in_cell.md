# Do points (occurrences) fall within raster cells?

This function examines which points fall within a raster cell with data
(not NA). Returns TRUE for points falling in a raster cell with data,
and FALSE otherwise.

## Usage

``` r
point_in_cell(locs = NULL, ras = NULL, layer = 1)
```

## Arguments

- locs:

  A point `sf` or `SpatVector` object with (x, y) coordinates

- ras:

  SpatRaster object

- layer:

  Integer. For multilayer rasters, which layer to use to compare with
  point locations (default = 1).

## Value

A logical vector.
