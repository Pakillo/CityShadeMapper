
library(lidR)

setwd("C:/Users/Jesus/Documents/lidar")

#descargo los datos lidar
las <- readLAScatalog("C:/Users/Jesus/Documents/lidar/laz", progress = TRUE)

#filtro datos innecesarios o erroneos
opt_filter(las) <- "-drop_z_below 0 -drop_class 1 -drop_class 7 -drop_class 12"


# esto es para sobreescribir los archivos, pero no funciona
las@output_options$drivers$Raster$param$overwrite <- TRUE #

# calculo la altura de los edificios y arboles
opt_output_files(las) <- "C:/Users/Jesus/Documents/lidar/dsm_{XLEFT}_{YBOTTOM}"# guardamos el resultado en disco
dsm <- rasterize_canopy(las, res = 1, pitfree(c(0,10,20), c(0, 1))) # resolucion de 1 metro (podria ser hasta 0,5 m)
plot(dsm)

#plot en 3d de lidr, aunque es feo
plot_dtm3d(dsm, bg = "white")

library (terra)
dsm <- rast("dsm_234000_4140000.tif") # cargo el archivo de disco


library(rayshader) #paquete para calcular las sombras
library(raster)

dsm <- raster(dsm) #hay que pasar el formato al paquete de raster

dsm #ha perdido la proyeccion

raster::crs(dsm) <- "+proj=utm +zone=30 +ellps=GRS80 +units=m +no_defs " #quise meter el etrs89/utm30 pero no me dejaba

#el raster hay que transformarlo a matriz
heightmap = raster_to_matrix(dsm)

#con esta funcion se calcula la sombra, puedes meter la altitud y angulo del sol
sombras <- ray_shade(dsm, sunaltitude,sunangles,lambert = FALSE, zscale = 1)
#tambien puedes obtener las sombras sin los datos del sol
sombras <- ray_shade(heightmap,lambert = FALSE, zscale = 1,multicore = TRUE)

#vemos los resultados
sombras %>%
  plot_map()


library(suncalc) #este paquete calcula el angulo y la altura del sol

#con esta funcion sacas el angulo y la altura del sol (aunque habria que pasarlo a grados)
data <- data.frame(date = seq.Date(Sys.Date()-9, Sys.Date(), by = 1),
                   lat = c(rep(234000, 10), rep(236000, 10)),
                   lon = c(rep(4140000, 10), rep(4142000, 10)))

getSunlightPosition(data = data,
                    keep = c("altitude", "azimuth"))

#con esta funcion sacas la hora de amanecer y atardecer
getSunlightTimes(as.Date("2019-06-21"), lat = 234000, lon = 4140000,tz = "EST")


#encontre este codigo en github para una ciudad americana que integra los pasos, pero no me ha funcionado:

#Start and hour after sunrise and end an hour before sunset
philly_time_start = ymd_hms("2019-06-21 05:30:00", tz = "EST")
philly_time_end= ymd_hms("2019-06-21 18:30:00", tz = "EST")

temptime = philly_time_start
philly_existing_shadows = list()
sunanglelist = list()
counter = 1

# while(temptime < philly_time_end) {
#   sunangles[[counter]] = suncalc::getSunlightPosition(date = temptime, lat = 39.9526, lon = -75.1652)[4:5]*180/pi
#   print(temptime)
#   philly_existing_shadows[[counter]] = ray_shade(building_mat_small,
#                                   sunangle = sunangles[[counter]]$azimuth+180,
#                                   sunaltitude = sunangles[[counter]]$altitude,
#                                   lambert = FALSE, zscale = 2,
#                                   multicore = TRUE)
#   temptime = temptime + duration("3600s")
#   counter = counter + 1
# }




# tambien encontre este codigo que saca las sombras como un raster

# por algun motivo el raster se traspone, con esta funcion lo corregimos
fliplr = function(x) {
  if(length(dim(x)) == 2) {
    x[,ncol(x):1]
  } else {
    x[,ncol(x):1,]
  }
}


# get the shadow layer as a raster, we can do so using the following function
# that pulls together some of the previous steps and adds an additional left-right flip :
rasterify_rayshade = function(rayshade, original_raster){
  # Transpose and flip the shade matrix
  reorient_rayshade = fliplr(t( rayshade ))
  # Generate the raster
  rayshade_raster  = raster( reorient_rayshade )
  # Set the extent
  extent(rayshade_raster) = extent(original_raster)
  # Set the CRS
  crs(rayshade_raster) = crs(original_raster)

  rayshade_raster
}

ray_shade_raster = rasterify_rayshade(sombras, dsm)

plot(ray_shade_raster)

writeRaster(ray_shade_raster, shadow_tif, overwrite= TRUE)

shadow_tif = "stage_shadow.tif"











