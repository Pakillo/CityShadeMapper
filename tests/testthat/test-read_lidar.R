test_that("read_lidar works", {

  lidar <- read_lidar(system.file("extdata", "PlazaNueva.laz",
                       package = "CityShadeMapper", mustWork = TRUE))
  lidar.ext <- terra::ext(lidar)

  expect_true(inherits(lidar, "LAScatalog"))
  expect_equal(terra::xmin(lidar.ext), 234700)
  expect_equal(round(terra::xmax(lidar.ext)), 234880)
  expect_equal(terra::ymin(lidar.ext), 4142100)
  expect_equal(terra::ymax(lidar.ext), 4142250)
  expect_equal(lidR::st_crs(lidar)$input, "EPSG:3042")

})
