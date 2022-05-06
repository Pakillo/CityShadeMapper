#' Get sun position
#'
#' Get sun position (declination, elevation, and azimuth) for a given day and time.
#'
#' @param lon Longitude (numeric value between -180 and 180)
#' @param lat Latitude (numeric value between -90 and 90)
#' @param date A character giving the date (e.g. "2021-02-19")
#' @param hour Hour of the day. Integer number between 0 and 23, both included.
#'
#' @return A numeric matrix as returned by [solartime::computeSunPositionDoyHour()],
#' but converted to degrees rather than radians.
#' @export
#'
#' @examples
#' sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 15)
get_sun_position <- function(lon = NULL, lat = NULL, date = NULL, hour = NULL) {

  stopifnot(hour %in% seq(from = 0, to = 23, by = 1))
  stopifnot(is.numeric(lat), lat > -90, lat < 90)

  # Find time zone from lon-lat
  tz <- lutz::tz_lookup_coords(lat = lat, lon = lon, method = "fast", warn = FALSE)

  # Get time difference with UTC
  time.offset <- lutz::tz_offset(date, tz = tz)$utc_offset_h

  sunpos.rad <- solartime::computeSunPositionDoyHour(
    doy = lubridate::yday(date),  # alternatively, as.numeric(strftime(date, format = "%j"))
    hour = hour,
    latDeg = lat,
    longDeg = lon,
    timeZone = time.offset,
    isCorrectSolartime = TRUE
  )

  sunpos.deg <- apply(subset(sunpos.rad,
                             select = c("declination", "elevation", "azimuth")),
                  MARGIN = c(1, 2),
                  FUN = rad2deg)

  sunpos.deg

}
