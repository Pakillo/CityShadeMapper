building <- example_building()
build.mat <- CityShadeMapper:::terra_to_matrix(building)
build.ras <- CityShadeMapper:::matrix_to_terra(build.mat,
                                               crs = "epsg:25830",
                                               extent = c(230000, 230009, 4141250, 4141259))

test_that("terra to matrix conversion works", {

  expect_equal(
    build.mat,
    structure(c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0), dim = c(9L, 9L))
  )

})


test_that("matrix to terra conversion works", {

  expect_true(inherits(build.ras, "SpatRaster"))
  expect_equal(dim(build.ras), c(9, 9, 1))
  expect_equal(terra::res(build.ras), c(1,1))
  expect_equal(terra::xmin(build.ras), 230000)
  expect_equal(terra::xmax(build.ras), 230009)
  expect_equal(terra::ymin(build.ras), 4141250)
  expect_equal(terra::ymax(build.ras), 4141259)
  expect_equal(
    terra::crs(build.ras, proj = TRUE),
    "+proj=utm +zone=30 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

})
