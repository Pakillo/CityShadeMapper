

library(lidR)

#descargo los datos lidar
las <- readLAScatalog("C:/Users/Jesus/Documents/paquilo/laz", progress = TRUE)

#filtro datos innecesarios o erroneos
opt_filter(las) <- "-drop_z_below 0 -drop_class 1 -drop_class 7 -drop_class 12"

# calculo del MDT de la zona de estudio

las@output_options$drivers$Raster$param$overwrite <- TRUE # esto es para sobreescribir los archivos, pero no funciona
opt_output_files(las) <- "C:/Users/Jesus/Documents/lidar/dtm_{XLEFT}_{YBOTTOM}"# primero guardar el archivo en disco
dtm <- grid_terrain(las, 1, tin()) # hacer el MDT con una resolucion de 1 metro
plot(dtm)

# calculo la altura de los edificios y arboles
opt_output_files(las) <- "C:/Users/Jesus/Documents/paquilo/chm_{XLEFT}_{YBOTTOM}"
chm <- rasterize_canopy(las, res = 1, pitfree(c(0,10,20), c(0, 1)))
plot(chm)

#PARA VERLO EN 3D, pero da fallos
library(rassta)
plot3D(dtm)


