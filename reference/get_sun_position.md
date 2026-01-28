# Get sun position

Get sun position (declination, elevation, and azimuth) for a given day
and time.

## Usage

``` r
get_sun_position(
  lon = NULL,
  lat = NULL,
  date = NULL,
  hour = NULL,
  omit.nights = TRUE
)
```

## Arguments

- lon:

  Longitude (numeric value between -180 and 180)

- lat:

  Latitude (numeric value between -90 and 90)

- date:

  A Date object or character giving the date in YYYY-MM-DD format (e.g.
  "2021-02-19"). Can be a vector too, e.g. c("2021-02-19",
  "2021-08-04"). Note different years have no effect on sun position
  calculations.

- hour:

  Hour of the day. Integer number (or numeric vector) between 0 and 23
  (both included).

- omit.nights:

  Logical. If TRUE, sun positions will only be returned when it is
  daytime (i.e. nighttimes will be omitted)

## Value

A data frame with solar elevation and azimuth per hour as returned by
[`solartime::computeSunPositionDoyHour()`](https://rdrr.io/pkg/solartime/man/computeSunPositionDoyHour.html)
but converted to degrees rather than radians.

## Examples

``` r
sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 15)
sunpos <- get_sun_position(lon = -5.99, lat = 37.39,
date = c("2021-02-19", "2022-08-05"), hour = 10:14)
```
