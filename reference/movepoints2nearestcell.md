# Move point locations to the nearest raster cell with data

Move point locations falling in raster cells without data (i.e. NA) to
the nearest raster cell with data.

## Usage

``` r
movepoints2nearestcell(locs = NULL, ras = NULL, layer = 1)
```

## Arguments

- locs:

  A point `sf` object.

- ras:

  A SpatRaster.

- layer:

  Integer. For multilayer rasters, which layer to use.

## Value

A sf object (with corrected coordinates if move is TRUE).
