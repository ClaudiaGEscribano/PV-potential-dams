## plotting the reservoir polygons
library(maps)
library(mapdata)
library(maptools)

source("readdata.R")

data('worldMapEnv')

## plot(boundaries_lines, bg="lightgrey", cex=0.2, col='black', xlab='Longitude', ylab='Latitude', main='Reservoirs in Spain')
## polygon(SpainPolygon[[1]][1], cex=0.5, pch=19, col='orange')
## map.axes()


plot(SpainPolygon, col = sf.colors(12, categorical = TRUE), border = 'orange', lwd=3, xlab='Longitude', ylab='Latitude',xlim=c(-12,7), ylim=c(36, 43.5))#, axes = TRUE)
map('worldHires', regions="Spain", add=TRUE)
map.axes()
