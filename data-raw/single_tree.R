hmat <- matrix(data = rep(0, 9*9), nrow = 9, ncol = 9, byrow = TRUE)
hmat[5,5] <- 4

single_tree <- CityShadeMapper:::matrix_to_terra(hmat,
                                                 crs = "epsg:25830",
                                                 extent = c(230000, 230009, 4141250, 4141259))


save(single_tree, file = "data/single_tree.rda")
