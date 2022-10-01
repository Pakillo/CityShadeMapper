test_that("find_city_lonlat returns correct output", {

  building <- example_building()
  expect_equal(
    dput(CityShadeMapper:::find_city_lonlat(building)),
    list(lon = -6.04928479224813, lat = 37.3787575349453)
  )

})
