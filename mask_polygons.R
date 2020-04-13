## Este script crea una máscara de polígonos para pasarla a los datos de radiación de la PI.

library(maps)
library(mapdata)
library(maptools)

source("readdata.R")

data('worldMapEnv')


## la máscara debe ser SpainPolygons.

## creo un objeto Spatial, para poder hacer la máscara al raster.


sp  <- as(SpainPolygon "Spatial"))

