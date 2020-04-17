## Mask the PV calculations from the worldbank to the reservoirs in Spain. First estimation of annual PV production over dams.

source('readdata.R')
source('read_solar.R')
source('mask_polygons.R')

load('border.Rdata')

## read the PV data:

path  <- "/home/claudia/ideas/PV-potential-dams/solar_data/Spain_GISdata_LTAym_AvgDailyTotals_GlobalSolarAtlas-v2_GEOTIFF/Spain_GISdata_LTAy_AvgDailyTotals_GlobalSolarAtlas-v2_GEOTIFF/monthly"
files  <- dir(path=path, pattern="^.*\\.tif$")

pvm  <- stack(lapply(1:length(files), FUN=function(i)
    paste(path, '/', files[i], sep="")))

days  <-  c(31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, 31)

pvm  <- stack(lapply(1: length(days), FUN=function(i) {pvm[[i]]*days[i]}))

pvy  <- stackApply(pvm, indices=rep(1,12), fun=sum)

## Mask with polygons:

## a. yearly:
ext <- c(-12, 7, 35.5,44) 
solar  <- crop(pvy, ext)

mpv  <- mask(solar, sp) ## mascara to calc pv
spl  <- as(sp, "SpatialLines")

levelplot(mpv, margin=FALSE)+
    layer(sp.lines(boundaries_lines))+
    layer(sp.lines(spl, lwd=0.1, alpha=0.7))

## sum:

cellStats(mpv, stat='sum')

##3792884: 3,8 GWh/Gh ?

## yearly statistics:

ystats  <- summary(mpv)

## b. montly

solar  <- crop(pvm, ext)

mpv  <- mask(solar, sp) ## mascara to calc pv

levelplot(mpv, margin=FALSE)+
    layer(sp.lines(boundaries_lines))+
    layer(sp.lines(spl, lwd=0.1, alpha=0.7))

mstats  <- summary(mpv)
