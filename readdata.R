## Read the data of medium to large dams in Spain.
 
library("sf")

data  <-  read_sf("/home/claudia/ideas/PV-potential-dams/GRanD_Version_1_3/GRanD_reservoirs_v1_3.shp")

## Para ver la estructura de los datos.

str(data)

## Agrupo por país y obtengo los datos de lat y long.

## dataSelection  <-  as.data.frame(unlist(cbind(data$COUNTRY, data$LONG_DD, data$LAT_DD, data$AREA_SKM))) ##, data$geometry)))

dataSelection <- cbind(data$COUNTRY, data$LONG_DD, data$LAT_DD, data$AREA_SKM) %>%
    unlist %>%
    as.data.frame 

names(dataSelection)  <-  c("country", "lon", "lat", "area") ##,"poly")

## Select the Spanish reservoirs

dataSpain  <-  dataSelection[dataSelection$country == "Spain", ]

## Spain Polygons:

## Extract the polygons with the indexes of the Spanish reservoirs:

id  <- as.numeric(rownames(dataSpain))
SpainPolygon  <-  data$geometry[id]

save(dataSpain, file="data_Spanish_dams.Rdata")
save(SpainPolygon, file="data_Spanish_dams_polygons.Rdata")

## ahora mismo los embalses son muchos polígonos, tendría que crear uno capa (raster) con todos los polígonos para poder representarlos junto a por ejemplo datos de cmsaf. Puedo usar alguna función que una todos los polígonos: multipoligon.
