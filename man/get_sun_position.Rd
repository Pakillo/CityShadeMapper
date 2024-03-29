% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_sun_position.R
\name{get_sun_position}
\alias{get_sun_position}
\title{Get sun position}
\usage{
get_sun_position(
  lon = NULL,
  lat = NULL,
  date = NULL,
  hour = NULL,
  omit.nights = TRUE
)
}
\arguments{
\item{lon}{Longitude (numeric value between -180 and 180)}

\item{lat}{Latitude (numeric value between -90 and 90)}

\item{date}{A Date object or character giving the date in YYYY-MM-DD format (e.g. "2021-02-19").
Can be a vector too, e.g. c("2021-02-19", "2021-08-04").
Note different years have no effect on sun position calculations.}

\item{hour}{Hour of the day. Integer number (or numeric vector) between 0 and 23 (both included).}

\item{omit.nights}{Logical. If TRUE, sun positions will only be returned when it is daytime
(i.e. nighttimes will be omitted)}
}
\value{
A data frame with solar elevation and azimuth per hour
as returned by \code{\link[solartime:computeSunPositionDoyHour]{solartime::computeSunPositionDoyHour()}}
but converted to degrees rather than radians.
}
\description{
Get sun position (declination, elevation, and azimuth) for a given day and time.
}
\examples{
sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 15)
sunpos <- get_sun_position(lon = -5.99, lat = 37.39,
date = c("2021-02-19", "2022-08-05"), hour = 10:14)
}
