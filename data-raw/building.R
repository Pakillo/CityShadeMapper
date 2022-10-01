hmat <- matrix(data = rep(0, 9*9), nrow = 9, ncol = 9, byrow = TRUE)
hmat[5,5] <- 4
hmat[6,5] <- 4
hmat[5,6] <- 4
hmat[6,6] <- 4

building <- CityShadeMapper:::matrix_to_terra(hmat,
                                                 crs = "epsg:25830",
                                                 extent = c(230000, 230009, 4141250, 4141259))


save(building, file = "data/building.rda")
