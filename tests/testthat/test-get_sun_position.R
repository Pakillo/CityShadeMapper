test_that("get_sun_position returns correct output", {

  # single hour
  expect_equal(
    get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 15),
    structure(list(date = "2021-02-19", hour = 15, hour.solar = 13.36,
                   elevation = 37.1, azimuth = 205.37),
              class = "data.frame", row.names = 1L)
  )


  # several days and hours
  expect_equal(
    get_sun_position(lon = -5.99, lat = 37.39,
                     date = c("2021-02-19", "2022-08-05"), hour = 10:12),
    structure(list(date = c("2021-02-19", "2021-02-19", "2021-02-19",
                            "2022-08-05", "2022-08-05", "2022-08-05"),
                   hour = c(10L, 11L, 12L, 10L, 11L, 12L),
                   hour.solar = c(8.36, 8.36, 10.36, 7.5, 9.5, 9.5),
                   elevation = c(19, 19, 35.58, 28.14, 51.53, 51.53),
                   azimuth = c(122.53, 122.53, 150, 89.01, 110.98, 110.98)),
              class = "data.frame", row.names = as.integer(c(1, 3, 5, 2, 4, 6)))
  )

  # omit nights = TRUE
  expect_equal(
    get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 6:10),
    structure(list(date = c("2021-02-19", "2021-02-19"), hour = 9:10,
                   hour.solar = c(7.36, 8.36), elevation = c(8.41, 19),
                   azimuth = c(112.05, 122.53)),
              class = "data.frame", row.names = 4:5)
  )


  # omit nights = FALSE
  expect_equal(
    get_sun_position(lon = -5.99, lat = 37.39, date = "2021-02-19", hour = 6:10,
                     omit.nights = FALSE),
    structure(list(date = c("2021-02-19", "2021-02-19", "2021-02-19",
                            "2021-02-19", "2021-02-19"), hour = 6:10,
                   hour.solar = c(4.36, 5.36, 6.36, 7.36, 8.36),
                   elevation = c(-26.64, -14.73, -2.95, 8.41, 19),
                   azimuth = c(84.67, 93.87, 102.74, 112.05, 122.53)),
              class = "data.frame", row.names = 1:5)
  )

})
