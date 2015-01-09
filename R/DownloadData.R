#SnakeAkaPython
#January 9 2015

DownloadData <- function (url1, url2) {
  
  
  
  #Download and unzip in the data directory
  
  download.file(url = url1, destfile = 'data/netherlands-railways-shape.zip', method = 'auto')
  download.file(url = url2, destfile = 'data/netherlands-places-shape.zip', method = 'auto')
  
  
  setwd("C:/Users/gyric001/Desktop/SnakeAkaPython/Lesson5Vector/data")
  
  
  Railway <- unzip(zipfile = 'netherlands-railways-shape.zip')
  Places <- unzip(zipfile = 'netherlands-places-shape.zip')
  
  
  #Seting the directory back to the main directory
  
  setwd("C:/Users/gyric001/Desktop/SnakeAkaPython/Lesson5Vector")
  
  
  dsn = file.path("data/" ,"railways.shp")
  myroute <- readOGR(dsn, layer = ogrListLayers(dsn))
  RailwayIndustrial <- myroute[myroute$type == "industrial", ]
  
  dsn_Plc = file.path("data/" ,"places.shp")
  myplaces <- readOGR(dsn_Plc, layer = ogrListLayers(dsn_Plc))
  
  # Define CRS object for RD projection
  
  prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
  
  
  # transform the railway line data to RD
  
  RailwayIndustrial_RD <- spTransform(RailwayIndustrial, prj_string_RD)
  myplaces_RD <- spTransform(myplaces, prj_string_RD)
  
  
  #Create buffer and an intersection of places
  
  RailwayBuffer <- gBuffer(RailwayIndustrial_RD, width = 1000 , byid=TRUE)
  city_point <- gIntersection(myplaces_RD, RailwayBuffer, byid = TRUE)
  
  place_buffer <-gIntersects(myplaces_RD, RailwayBuffer, byid=TRUE)
  city <- myplaces_RD@data[place_buffer,]
  
  plot1 <- plot(RailwayBuffer, main = 'Utrecht')
  plot2 <- plot(city_point, add = TRUE, lty = 3, lwd = 2, col= "red") 
  
  return(c(plot1, plot2))
}






