#SnakeAkaPython
#January 9 2015


# Libraries that will be required
library(sp)
library(maptools)
library(rgdal)
library(rgeos)


#Function call up
source('R/Buffer_Intersection.R')
source('R/DownloadData.R')


url_railways = 'http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip'
url_places = 'http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip'

getdata <-DownloadData(url_railways, url_places)

#RailwayBuffer <- getdata[1]
#city_point <- getdata[2]

#The result of the above
#        osm_id    name type population
#5973 235861650 Utrecht city     100000