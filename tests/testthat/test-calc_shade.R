test_that("calc_shade works", {

  building <- example_building()
  buildmat <- CityShadeMapper:::terra_to_matrix(building)
  sunpos <- get_sun_position(lon = -6.0493, lat = 37.3788, date = "2022-10-18", hour = 15)
  shaderas <- calc_shade(buildmat,
                         sun.altitude = sunpos$elevation,
                         sun.angle = sunpos$azimuth,
                         crs = terra::crs(building),
                         extent = terra::ext(building)
  )

  expect_true(inherits(shaderas, "SpatRaster"))
  expect_equal(dim(shaderas), c(9, 9, 1))
  expect_equal(terra::res(shaderas), c(1,1))
  expect_equal(terra::xmin(shaderas), 230000)
  expect_equal(terra::xmax(shaderas), 230009)
  expect_equal(terra::ymin(shaderas), 4141250)
  expect_equal(terra::ymax(shaderas), 4141259)
  expect_equal(
    terra::crs(shaderas, proj = TRUE),
    "+proj=utm +zone=30 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

  expect_equal(as.numeric(terra::values(shaderas)),
               c(0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88,
                 0.88, 0.88, 0.88, 0.88, 0.88, 0.09, 0.09, 0.88, 0.88, 0.88, 0.88,
                 0.88, 0.88, 0.88, 0.09, 0.09, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88,
                 0.01, 0.01, 0.09, 0.88, 0.88, 0.88, 0.88, 0.88, 0.68, 0, 0.09,
                 0.04, 0.88, 0.88, 0.88, 0.88, 0.88, 0.68, 0.94, 0.53, 0.41, 0.88,
                 0.88, 0.88, 0.88, 0.88, 0.88, 1, 1, 0.88, 0.88, 0.88, 0.88, 0.88,
                 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88, 0.88,
                 0.88, 0.88, 0.88, 0.88, 0.88)
  )

})
