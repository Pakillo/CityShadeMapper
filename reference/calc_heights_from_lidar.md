# Generate height raster from LiDAR data

Generate height raster from LiDAR data

## Usage

``` r
calc_heights_from_lidar(
  las = NULL,
  res = 1,
  ground = FALSE,
  thresholds = c(0, 2, 5, 10, 20),
  filename = NULL,
  ...
)
```

## Arguments

- las:

  LiDAR data (a
  [`lidR::LAS-class()`](https://rdrr.io/pkg/lidR/man/LAS-class.html) or
  [`lidR::LAScatalog-class()`](https://rdrr.io/pkg/lidR/man/LAScatalog-class.html)
  object).

- res:

  Spatial resolution of the raster

- ground:

  Logical. Calculate ground height in addition to canopy/roof heights?

- thresholds:

  Set of height thresholds (see
  [`lidR::dsm_pitfree()`](https://rdrr.io/pkg/lidR/man/dsm_pitfree.html)).

- filename:

  Character. Output filename. Note that if a file already exists with
  that name, it will be overwritten.

- ...:

  further arguments to
  [`lidR::pitfree()`](https://rdrr.io/pkg/lidR/man/dsm_pitfree.html)

## Value

SpatRaster with height data

## Examples

``` r
if (FALSE) { # \dontrun{
heights <- calc_heights_from_lidar(PlazaNueva())
} # }
```
