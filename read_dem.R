## DEM: 200m resolution. (source IGN).

library(raster)
library(rasterVis)
library(dplyr)
## There are different asc. files for each province.

## reading data as raster files:

files  <- dir(pattern="^.*\\.asc$")
dem  <-  lapply(1:length(files),
                FUN=function(x) raster(files[x]))

## explore

levelplot(dem[[3]])

## There is no CRS assigned to the raster files. It has to be included

## Metadata info: Sistema geodésico de referencia ETRS89

mycrs  <- "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

dem  <- lapply(dem,
             FUN=function(i) {crs(i)  <-  mycrs
                 i})

## save dem data as R data files

save(dem, file="dem_list.Rdata")
