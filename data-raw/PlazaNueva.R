library(lidR)

pza <- readLAS("CityShadeMap_data/Sevilla/plaza/PNOA_2020_AND-NW_234-4144_ORT-CLA-RGB.laz")
pza2 <- clip_roi(pza, matrix(c(234700, 234880, 4142100, 4142250), nrow = 2, byrow = TRUE))
writeLAS(pza2, file = "inst/extdata/PlazaNueva.laz")
