## Create a map with the latlon points of dams in Spain.
 
library(maps)
library(mapdata)
library(maptools)
library(rasterVis)

source("readdata.R")

data('worldMapEnv')
## select latlon points
 
latlon  <-  dataSpain[,2:3]
lat  <-  as.numeric(as.vector(latlon$lat))
lon  <-  as.numeric(as.vector(latlon$lon))

crs.lonlat  <- CRS("+proj=longlat +datum=WGS84 +no_defs")
    
latlon  <-  SpatialPoints(cbind(lat, lon), proj4string=crs.lonlat)


## Extent of the map I will create

ext <- c(-12, 7, 36,43.5)

## Retrieve the boundaries restricted to this extent
boundaries <- map('worldHires',
                  regions="Spain",
                  fill=TRUE,
                  exact=FALSE,
                  xlim = ext[1:2], ylim = ext[3:4],
                  plot = FALSE)

## Convert the result to a SpatialPolygons object:

IDs <- sapply(strsplit(boundaries$names, ":"), function(x) x[1])

boundaries_sp<- map2SpatialPolygons(boundaries,
                                    IDs=IDs, proj4string=crs.lonlat)

## Convert the result to a SpatialLines object

boundaries_lines <- map2SpatialLines(boundaries,
                               proj4string = crs.lonlat)

save(boundaries_lines, file='border.Rdata')

############################
## PI + baleares
 
## plot(boundaries_lines, bg="lightgrey", cex=0.2, col='black', xlab='Longitude', ylab='Latitude')
## points(latlon$lon, latlon$lat, cex=0.5, pch=19, col='orange')
## map.axes()

plot(boundaries_sp, bg="lightgrey", cex=0.2, col='black', xlab='Longitude', ylab='Latitude', main='Reservoirs in Spain')
points(latlon$lon, latlon$lat, cex=0.5, pch=19, col='orange')
map.axes()


## CI: to explore data points over the islands
 
ext <- c(-18.5, -13.5, 27.3, 29.5)
## Retrieve the boundaries restricted to this extent
boundaries_CI <- map('worldHires',
                     regions="Canary Islands",
                     xlim = ext[1:2], ylim = ext[3:4],
                     fill=TRUE,
                     exact=FALSE,
                     plot = TRUE)

## Convert the result to a SpatialPolygons object:

IDs <- sapply(strsplit(boundaries_CI$names, ":"), function(x) x[1])
boundaries_spCI<- map2SpatialPolygons(boundaries_CI,
                                    IDs=IDs, proj4string=crs.lonlat)

 
## or convert the result to a SpatialLines object:
boundaries_linesCI <- map2SpatialLines(boundaries_CI,
                               proj4string = crs.lonlat)

plot(boundaries_spCI, col="black", bg="white", ylab='Latitude', xlab='Longitude')
points(latlon$lon, latlon$lat, cex=0.75, pch=19, col='red')
map.axes()

## no data observed over the CI.

######################
## plot with rasterVis if I have a background for the points.

ext <- c(-12, 7, 35.5,44)
 
IDs <- sapply(strsplit(boundaries$names, ":"), function(x) x[1])
boundaries_sp<- map2SpatialPolygons(boundaries, IDs=IDs, proj4string=crs.lonlat) 

## transform sf objects into sp.
sp <- as(SpainPolygon, "Spatial")
 
R  <-  raster(extent(ext), crs=crs.lonlat, vals=rep(1,100))
 
levelplot(R)+
    layer(sp.lines(boundaries_lines))+
    layer(sp.polygons(sp))

levelplot(R) + layer(sp.polygons(sp))
