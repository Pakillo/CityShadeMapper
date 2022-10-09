library(lidR)

zona <- readLAS("CityShadeMap_data/Sevilla/PNOA_2020_AND-NW_234-4142_ORT-CLA-RGB.laz",
               select = "xyzc")
cate <- clip_roi(zona, matrix(c(234900, 235200, 4141700, 4142000), nrow = 2, byrow = TRUE))
writeLAS(cate, file = "inst/extdata/catedral.laz")
