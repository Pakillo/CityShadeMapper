test_that("rasterize_lidar_cover_class works", {
  pza <- system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper")
  pza.cover <- rasterize_lidar_cover_class(pza, res = 1, group.classes = TRUE)

  expect_equal(as.numeric(head(terra::values(pza.cover), n = 40)),
               c(6, NA, 6, 6, 6, 6, NA, NA, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
                 6, NA, 4, 2, NA, NA, NA, 6, 6, 6, 6, 6, 6, NA, 6, 6, 6, NA, 4,
                 6, NA))
})
