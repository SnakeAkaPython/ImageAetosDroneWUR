#SnakeAkaPython
#January 9 2015


Buffer_Intersection <- function(RailwayIndustrial, myplaces) {
  library(rgdal)
  # Define CRS object for RD projection
  
  prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
  
  
  # transform the railway line data to RD
  
  RailwayIndustrial_RD <- spTransform(RailwayIndustrial, prj_string_RD)
  myplaces_RD <- spTransform(myplaces, prj_string_RD)
  
  
  #Create buffer and an intersection of places
  
  RailwayBuffer <- gBuffer(RailwayIndustrial_RD, width = 1000 , byid=TRUE)
  city_point <- gIntersection(myplaces_RD, RailwayBuffer, byid = TRUE)
  
  return(c(RailwayBuffer, city_point))
}

