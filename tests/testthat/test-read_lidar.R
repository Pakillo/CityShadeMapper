test_that("read_lidar works", {

  lidar <- read_lidar(system.file("extdata", "PlazaNueva.laz",
                       package = "CityShadeMapper", mustWork = TRUE))
  lidar.ext <- lidR::extent(lidar)

  expect_true(inherits(lidar, "LAScatalog"))
  expect_equal(lidar.ext@xmin, 234700)
  expect_equal(round(lidar.ext@xmax), 234880)
  expect_equal(lidar.ext@ymin, 4142100)
  expect_equal(lidar.ext@ymax, 4142250)
  expect_equal(lidR::st_crs(lidar)$input, "EPSG:3042")

})
