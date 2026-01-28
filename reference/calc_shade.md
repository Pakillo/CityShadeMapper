# Calculate shades from elevation map

Calculate shades from elevation map

## Usage

``` r
calc_shade(
  height.mat = NULL,
  sun.altitude = NULL,
  sun.angle = NULL,
  zscale = 1,
  crs = "",
  extent = NULL,
  filename = NULL,
  ...
)
```

## Arguments

- height.mat:

  Height matrix, as calculated by
  [`terra_to_matrix()`](https://pakillo.github.io/CityShadeMapper/reference/terra_to_matrix.md).

- sun.altitude:

  Sun altitude (angle from the horizon, in degrees)

- sun.angle:

  Sun angle in degrees (zero degrees is North, increasing clockwise)

- zscale:

  Default `1`. The ratio between the x and y spacing (which are assumed
  to be equal) and the z axis. For example, if the elevation is in units
  of meters and the grid values are separated by 10 meters, `zscale`
  would be 10.

- crs:

  coordinate reference system, see
  [`terra::crs()`](https://rspatial.github.io/terra/reference/crs.html)

- extent:

  raster extent, see
  [`terra::ext()`](https://rspatial.github.io/terra/reference/ext.html)

- filename:

  Character. Optional. Provide a filename to save the output raster on
  disk.

- ...:

  further arguments to
  [`rayshader::ray_shade()`](https://www.rayshader.com/reference/ray_shade.html)

## Value

A SpatRaster of light intensities, as produced by
[`rayshader::ray_shade()`](https://www.rayshader.com/reference/ray_shade.html)

## Examples

``` r
if (FALSE) { # \dontrun{
lidar.file <- system.file("extdata", "PlazaNueva.laz",
package = "CityShadeMapper", mustWork = TRUE)
lidar <- read_lidar(lidar.file)
heights <- calc_heights_from_lidar(lidar)
library(terra)
height.mat <- CityShadeMapper:::terra_to_matrix(subset(heights, 1))
sun.pos <- get_sun_position(lon = -5.99567, lat = 37.38876, date = "2022-10-18", hour = 15)
shaderas <- calc_shade(height.mat, sun.altitude = sun.pos$elevation,
sun.angle = sun.pos$azimuth,
crs = crs(heights), extent = ext(heights))
plot_shademap(shaderas)
} # }
```
