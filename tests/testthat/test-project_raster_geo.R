test_that("project_raster_geo works", {
  b <- example_building()
  b.geo <- project_raster_geo(b)

  expect_equal(class(b), class(b.geo))
  expect_equal(dim(b), dim(b.geo))
  expect_equal(terra::crs(b.geo, describe = TRUE)$code, "4326")
  expect_equal(terra::values(b), terra::values(b.geo))

})
