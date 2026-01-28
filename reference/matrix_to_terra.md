# Convert a matrix into a SpatRaster

Convert a matrix into a SpatRaster

## Usage

``` r
matrix_to_terra(mat = NULL, crs = "", extent = NULL, ...)
```

## Arguments

- mat:

  A matrix

- crs:

  CRS of the resulting SpatRaster

- extent:

  extent

- ...:

  Further arguments for
  [`terra::rast()`](https://rspatial.github.io/terra/reference/rast.html)

## Value

A SpatRaster object
