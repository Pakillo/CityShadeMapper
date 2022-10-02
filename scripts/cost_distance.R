#
#
# library(raster)
# library(gdistance)
#
#
# setwd("C:/Users/Jesus/Documents")
#
# shadow <- raster("shadow.tif") # tiene que ser con el paquet raster
#
# cost_matrix <- gdistance::transition(1/shadow,# hay que poner inverso para calcular la resistencia
#                                      transitionFunction=mean, # hay diversos tipos, este es el mas normal (ver funcion)
#                                      directions=8 #numero de pixeles contiguos que se tomaran para el recorrido
# )
# # visualizamos
# par(mar=c(2,2,1,1))
# raster::plot(raster::raster(cost_matrix))
#
# cost_matrix <- gdistance::geoCorrection(cost_matrix, type = "c")#hay que aplicar una geocorrecion
#
# #creo dos puntos (tienen que ser: SpatialPoints, vector or matrix with coordinates, at the moment only the first cell is taken into account)
# coords1 = c(
#   x=235504.6,
#   y=4140897.2
# )
#
# coords2 = c(
#   x=235087.7,
#   y=4141912.5
# )
#
# #calculo la ruta optima
# path <- gdistance::shortestPath(cost_matrix, coords1, coords2,
#                                 output="SpatialLines") # el formato de salida
#
# # visualizamos
# plot(shadow, xlab="Longitude", ylab="Latitude")
# lines(path.1, col="red")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
