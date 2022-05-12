#' Get sun position
#'
#' Get sun position (declination, elevation, and azimuth) for a given day and time.
#'
#' @param lon Longitude (numeric value between -180 and 180)
#' @param lat Latitude (numeric value between -90 and 90)
#' @param date A Date object or character giving the date in YYYY-MM-DD format (e.g. "2021-02-19").
#' Can be a vector too, e.g. c("2021-02-19", "2021-08-04").
#' Note different years have no effect on sun position calculations.
#' @param hour Hour of the day. Integer number (or numeric vector) between 0 and 23 (both included).
#' @param omit.nights Logical. If TRUE, sun positions will only be returned when it is daytime
#' (i.e. nighttimes will be omitted)
#'
#' @return A numeric matrix as returned by [solartime::computeSunPositionDoyHour()],
#' but converted to degrees rather than radians.
#' @export
#'
#' @examples
#' sunpos <- get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 15)
#' sunpos <- get_sun_position(lon = -5.99, lat = 37.39,
#' date = c("2021-02-19", "2022-08-05"), hour = 10:14)
get_sun_position <- function(lon = NULL,
                             lat = NULL,
                             date = NULL,
                             hour = NULL,
                             omit.nights = TRUE) {

  stopifnot(is.numeric(lon), lon > -180, lon < 180)
  stopifnot(is.numeric(lat), lat > -90, lat < 90)
  stopifnot(hour %in% seq(from = 0, to = 23, by = 1))


  # Find time zone from lon-lat
  tz <- lutz::tz_lookup_coords(lat = lat, lon = lon, method = "fast", warn = FALSE)

  # Get time difference with UTC
  time.offset <- lutz::tz_offset(date, tz = tz)$utc_offset_h

  # Prepare dates and times
  if (length(date) > 1 | length(hour) > 1) {

    dates.hours <- expand.grid(date = date, hour = hour, stringsAsFactors = FALSE)
    dates.hours <- dplyr::arrange(dates.hours, date, hour)

  } else {

    dates.hours <- data.frame(date = date, hour = hour)

  }


  # If omit.nights = TRUE, remove those dates & times
  if (omit.nights) {

    dates.hours$is.day <- solartime::computeIsDayByLocation(
      timestamp = as.POSIXct(paste0(dates.hours$date, " ", dates.hours$hour, ":00:00"),
                             tz = tz),
      latDeg = lat,
      longDeg = lon,
      timeZone = time.offset
    )

    dates.hours <- dates.hours[dates.hours$is.day == TRUE, c("date", "hour")]

  }

  # Calculate sun position for each date and time
  sunpos.rad <- solartime::computeSunPositionDoyHour(
    doy = lubridate::yday(dates.hours$date),   # alternatively, as.numeric(strftime(date, format = "%j"))
    hour = dates.hours$hour,
    latDeg = lat,
    longDeg = lon,
    timeZone = time.offset,
    isCorrectSolartime = TRUE
  )

  sunpos.deg <- apply(subset(sunpos.rad,
                             select = c("elevation", "azimuth")),
                  MARGIN = c(1, 2),
                  FUN = rad2deg)

  sunpos.deg <- cbind(dates.hours, hour.solar = sunpos.rad[, "hour"], sunpos.deg)

  sunpos.deg

}
