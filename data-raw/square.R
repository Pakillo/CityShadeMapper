hmat <- matrix(data = rep(0, 100*100), nrow = 100, ncol = 100, byrow = TRUE)

#square
hmat[20,20:80] <- 10
hmat[80,20:80] <- 10
hmat[20:80,20] <- 10
hmat[20:80,80] <- 10

# tree in the middle, 4 m high
hmat[48:52, 48:52] <- 4

square <- CityShadeMapper:::matrix_to_terra(hmat,
                                            crs = "epsg:25830",
                                            extent = c(230000, 230100, 4141250, 4141350))


terra::writeRaster(square, filename = "inst/extdata/square.tif")
