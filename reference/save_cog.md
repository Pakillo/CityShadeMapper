# Save raster as Cloud Optimised GeoTiff

Requires GDAL \>= 3.1

## Usage

``` r
save_cog(ras = NULL, filename = NULL)
```

## Arguments

- ras:

  A SpatRaster (e.g. a shade raster as produced by
  [`make_shademap()`](https://pakillo.github.io/CityShadeMapper/reference/make_shademap.md)).

- filename:

  Character. Output filename. Must end with '.tif' extension.

## Value

A cloud optimised geotiff saved on disk.
