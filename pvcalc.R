## Calculate potovoltaic potential over the polygons.

library(solaR)
library(purrr)

## load solar and reservoirs data

source('readdata.R')
source('read_solar.R')
source('mask_polygons.R')

load('border.Rdata')
## 1. Yearly PV from annual daily mean solar irradiation:

## GHI/DNI/DIF from the worldbank

solar  <-  wbdata[1:3]
temp   <- wbdata[7]

## GHI solar[3]

levelplot(solar[[3]])

levelplot(do.call(unlist, solar[3]))

## mask solar with reservoirs

## la máscara de los polígonos puede hacerse directamente usando SpatialPolygons: sp.

## As there is no reservoir data over the CI, I first reduce the extent of the solar data:

ext <- c(-12, 7, 35.5,44)
solar  <- lapply(solar, FUN=function(x) crop(x, ext))
msolar  <- mask(solar[[3]], sp) ## mascara to calc pv
spl  <- as(sp, "SpatialLines")

levelplot(mask(solar[[3]], sp), margin=FALSE)+
    layer(sp.lines(boundaries_lines))+
    layer(sp.lines(spl, lwd=0.1, alpha=0.7))


## zoom to look at the details:

ext <- c(3, 3.3, 39.3,39.5)
solarZoom  <- lapply(solar, FUN=function(x) crop(x, ext))

levelplot(mask(solarZoom[[3]], sp), margin=FALSE)+
    layer(sp.lines(boundaries_lines))+
    layer(sp.lines(spl, lwd=0.1, alpha=0.7))

## calc pv (to the croped region for testing):

## Simple equation from annual daily mean irradiation.

## PR = 0.8
msz  <- mask(solarZoom[[3]], sp) ## there aren't reservoirs in this section
latLayer <- init(msz, v='y') ## extraigo la latitud


foo <- function(x, ...)
{
    gef <- calcGef(lat = x[1], dataRad = list(G0dm = x[2:13]))
    result <- as.data.frameY(gef)[c('Gefd', 'Befd', 'Defd')] ##the results are yearly values
    as.numeric(result)
}


gefS <- calc(stack(latLayer, msz), foo, overwrite=TRUE)
names(gefS) <- c('Gefd', 'Befd', 'Defd')##Three layers
