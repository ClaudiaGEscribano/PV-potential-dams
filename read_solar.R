## read solar data.

library(raster)
library(rasterVis)

## 1. data from worldbank

path  <- "solar_data/Spain_GISdata_LTAy_AvgDailyTotals_GlobalSolarAtlas-v2_AAIGRID"
files  <- dir(path=path, pattern="^.*\\.asc$")

wbdata  <-  lapply(1:length(files),
                FUN=function(x) raster(paste(path, "/",files, sep="")[x]))

## explore:

## GHI (daily mean)

levelplot(wbdata[[3]])

