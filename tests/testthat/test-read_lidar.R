test_that("read_lidar works", {

  lidar <- PlazaNueva()
  lidar.ext <- lidR::extent(lidar)

  expect_true(inherits(lidar, "LAScatalog"))
  expect_equal(lidar.ext@xmin, 234700)
  expect_equal(round(lidar.ext@xmax), 234880)
  expect_equal(lidar.ext@ymin, 4142100)
  expect_equal(lidar.ext@ymax, 4142250)
  expect_equal(lidR::st_crs(lidar),
               structure(list(input = "EPSG:3042",
                              wkt = "PROJCRS[\"ETRS89 / UTM zone 30N (N-E)\",\n    BASEGEOGCRS[\"ETRS89\",\n        DATUM[\"European Terrestrial Reference System 1989\",\n            ELLIPSOID[\"GRS 1980\",6378137,298.257222101,\n                LENGTHUNIT[\"metre\",1]]],\n        PRIMEM[\"Greenwich\",0,\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n        ID[\"EPSG\",4258]],\n    CONVERSION[\"UTM zone 30N\",\n        METHOD[\"Transverse Mercator\",\n            ID[\"EPSG\",9807]],\n        PARAMETER[\"Latitude of natural origin\",0,\n            ANGLEUNIT[\"degree\",0.0174532925199433],\n            ID[\"EPSG\",8801]],\n        PARAMETER[\"Longitude of natural origin\",-3,\n            ANGLEUNIT[\"degree\",0.0174532925199433],\n            ID[\"EPSG\",8802]],\n        PARAMETER[\"Scale factor at natural origin\",0.9996,\n            SCALEUNIT[\"unity\",1],\n            ID[\"EPSG\",8805]],\n        PARAMETER[\"False easting\",500000,\n            LENGTHUNIT[\"metre\",1],\n            ID[\"EPSG\",8806]],\n        PARAMETER[\"False northing\",0,\n            LENGTHUNIT[\"metre\",1],\n            ID[\"EPSG\",8807]]],\n    CS[Cartesian,2],\n        AXIS[\"northing (N)\",north,\n            ORDER[1],\n            LENGTHUNIT[\"metre\",1]],\n        AXIS[\"easting (E)\",east,\n            ORDER[2],\n            LENGTHUNIT[\"metre\",1]],\n    USAGE[\n        SCOPE[\"unknown\"],\n        AREA[\"Europe - 6°W to 0°W and ETRS89 by country\"],\n        BBOX[35.26,-6,80.53,0]],\n    ID[\"EPSG\",3042]]"),
                         class = "crs"))

})
