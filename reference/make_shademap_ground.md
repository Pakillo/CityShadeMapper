# Calculate shade map at the ground level

Calculate shade map at the ground level

## Usage

``` r
make_shademap_ground(shademap.canopy = NULL, cover.ras = NULL, filename = NULL)
```

## Arguments

- shademap.canopy:

  A SpatRaster with the illumination at the canopy level, made with
  [`make_shademap()`](https://pakillo.github.io/CityShadeMapper/reference/make_shademap.md).

- cover.ras:

  A SpatRaster containing cover classes (ground, vegetation,
  buildings...). See
  [`rasterize_lidar_cover_class()`](https://pakillo.github.io/CityShadeMapper/reference/rasterize_lidar_cover_class.md).

- filename:

  Character. Output filename. Note that if a file already exists with
  that name, it will be overwritten.

## Value

A (possibly multilayer) SpatRaster object with the intensity of
illumination at the ground level

## Examples

``` r
if (FALSE) { # \dontrun{
lidar <- read_lidar(system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper"))
cover.ras <- rasterize_lidar_cover_class(lidar)
shaderas.canopy <- make_shademap(heights, date = "2022-10-15", hour = 13)
shaderas.ground <- make_shademap_ground(shaderas.canopy, cover.ras)

## Alternatively, call make_shademap directly:
heights <- calc_heights_from_lidar(lidar)
shaderas.ground <- make_shademap(heights, date = "2022-10-15", hour = 13,
  type = "ground", cover.ras = cover.ras)
} # }
```
