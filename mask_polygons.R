## Este script crea una máscara de polígonos para pasarla a los datos de radiación de la PI.

library(maps)
library(mapdata)
library(maptools)

source("readdata.R")

data('worldMapEnv')


## la máscara debe ser SpainPolygons.

a1 <- st_sf(1,geom = SpainPolygon)
a2 <- st_sf(2,geom = SpainPolygon)

ii <- rbind(a1, a2)


a2  <- st_read(a1)
