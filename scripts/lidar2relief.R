

library(lidR)

# descarga de los archivos laz
las <- readLAScatalog("C:/Users/Jesus/Documents/lidar")

# calculo del MDT de la zona de estudio
# primero guardar el archivo en disco
opt_output_files(las) <- "C:/Users/Jesus/Documents/lidar/dtm_{XLEFT}_{YBOTTOM}"
dtm <- grid_terrain(las, 1, tin()) # hacer el MDT con una resolucion de 1 metro
plot(dtm)

# hago la normalizacion de los datos
rois@output_options$drivers$Raster$param$overwrite <- TRUE
opt_output_files(las) <- "C:/Users/Jesus/Documents/lidar/norm_{XLEFT}_{YBOTTOM}"
norm <- normalize_height(las_cat, dtm,na.rm = TRUE)

plot(norm)


