geocode_address <- function(address = NULL) {
  stopifnot(is.character(address))
  out <- nominatimlite::geo_lite_sf(address, return_addresses = FALSE)
  if (!inherits(out, "sf")) stop("Geocoding address did not work.")
  return(out)
}
