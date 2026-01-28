# Calculate shade map

Calculate shade raster for given dates and hours

## Usage

``` r
make_shademap(
  height.ras = NULL,
  date = NULL,
  hour = NULL,
  type = c("canopy", "ground"),
  cover.ras = NULL,
  zscale = 1,
  omit.nights = TRUE,
  filename = NULL,
  ...
)
```

## Arguments

- height.ras:

  A
  [`terra::SpatRaster()`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
  with heights data. Note `height.ras` must have a well defined `crs`
  (see
  [`terra::crs()`](https://rspatial.github.io/terra/reference/crs.html)).

- date:

  A Date object or character giving the date in YYYY-MM-DD format (e.g.
  "2021-02-19"). Can be a vector too, e.g. c("2021-02-19",
  "2021-08-04"). Note different years have no effect on sun position
  calculations.

- hour:

  Hour of the day. Integer number (or numeric vector) between 0 and 23
  (both included).

- type:

  Character. Either 'canopy' to get illumination at the canopy/roof
  level, or 'ground' to get illumination at the ground level (i.e. for
  pedestrians).

- cover.ras:

  A SpatRaster containing cover classes (ground, vegetation,
  buildings...). See
  [`rasterize_lidar_cover_class()`](https://pakillo.github.io/CityShadeMapper/reference/rasterize_lidar_cover_class.md).

- zscale:

  Default `1`. The ratio between the x and y spacing (which are assumed
  to be equal) and the z axis. For example, if the elevation is in units
  of meters and the grid values are separated by 10 meters, `zscale`
  would be 10.

- omit.nights:

  Logical. If TRUE, sun positions will only be returned when it is
  daytime (i.e. nighttimes will be omitted)

- filename:

  Character. Output filename. Note that if a file already exists with
  that name, it will be overwritten.

- ...:

  further arguments to
  [`rayshader::ray_shade()`](https://www.rayshader.com/reference/ray_shade.html)

## Value

A (possibly multilayer) SpatRaster object with the intensity of
illumination at each pixel for every date and time

## Examples

``` r
if (FALSE) { # \dontrun{
lidar <- PlazaNueva()
heights <- calc_heights_from_lidar(lidar)
shaderas <- make_shademap(heights, date = "2022-10-15", hour = 13)
plot_shademap(shaderas, smooth = TRUE)
shaderas <- make_shademap(heights, date = "2022-10-15", hour = 8:20)
plot_shademap(shaderas, animate = TRUE, smooth = TRUE)
shaderas <- make_shademap(heights, date = "2022-07-15", hour = 8:21)
plot_shademap(shaderas, animate = TRUE, smooth = TRUE)
shaderas <- make_shademap(heights, date = c("2022-07-15", "2022-10-15"), hour = 13)
plot_shademap(shaderas, legend = FALSE)

## Ground-level shade maps require additional raster with cover classes
lidar <- read_lidar(system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper"))
cover.ras <- rasterize_lidar_cover_class(lidar)
shaderas <- make_shademap(heights, date = "2022-10-15", hour = 13,
  type = "ground", cover.ras = cover.ras)

} # }
```
