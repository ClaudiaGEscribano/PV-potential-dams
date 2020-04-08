## Calculate potovoltaic potential over the polygons.

library(solaR)
library(purrr)

## load solar and reservoirs data

source('readdata.R')
source('read_solar.R')

## GHI/DNI/DIF from the worldbank

solar  <-  wbdata[1:3]

## GHI solar[3]

levelplot(solar[3])

levelplot(do.call(unlist, solar[3]))

## mask solar with reservoirs

