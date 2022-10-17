get_online_cog <- function(base.url = "https://zenodo.org/record/7213637/files/",
                           month = NULL,
                           hour = NULL,
                           ground = TRUE) {

  stopifnot(is.character(base.url))
  stopifnot(is.numeric(month))
  stopifnot(month > 0 & month < 13)
  stopifnot(is.numeric(hour))
  stopifnot(hour > 7 & hour < 22)
  stopifnot(is.logical(ground))

  canopy <- ifelse(isTRUE(ground), "_ground", "_canopy")

  cog.url = paste0(base.url, "m", month, "_h", hour, canopy, ".tif")

  cog <- terra::rast(paste0("/vsicurl/", cog.url))

  return(cog)

}
