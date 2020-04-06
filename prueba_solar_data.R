library(raster)
library(rasterVis)


sis  <-  raster("./solar_data/SISdm201012310000003UD1000101UD.nc")

## tomo la PI:


ext <- c(-12, 7, 36,43.5)
e  <-  extent(ext)

sisPI  <-  crop(sis, e)

## recorto al polígono 2 los datos de radiación para ver la resolución:

r  <-  extent(c(-8.4, -8.2,43.26,43.29))
poly2  <-  crop(sisPI, r)

levelplot(poly2)

## global atlas data:

gsd  <-  xmlToDataFrame()

## los .tif se leen con raster:
    
s  <-  raster("solar_data/Spain_GISdata_LTAym_AvgDailyTotals_GlobalSolarAtlas-v2_GEOTIFF/Spain_GISdata_LTAy_AvgDailyTotals_GlobalSolarAtlas-v2_GEOTIFF/monthly/PVOUT_01.tif")
    

s  <-  crop(s, poly2)

ver  <-  stack(s, poly2)


