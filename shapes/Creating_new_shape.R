# library(rgdal)
# library(sp)
# library(sf)
# library(raster)
###Loading through a geojson-----------------
# install.packages("geojsonio")

library(geojsonio)
ca_cities <- geojson_read("./shapes/City_Boundaries.geojson",  what = "sp")

saveRDS(ca_cities, file = "./shapes/ca_cities.rds")


### doesn't work for me?
#my_sf_all_city_CA <- readOGR("shapes/City_Boundaries.shp")

### from vingette---------
#
# usa3 <- raster::getData(country = "USA", level = 3)
# ger2 <- raster::getData(country = "Germany", level = 2)
#
# ### reading in an RDS someone made--------------
# if (!require("rspatial")) remotes::install_github('rspatial/rspatial')
# library(rspatial)
#
# davis_polygon <- sp_data('city.rds') #just one city (davis)
# class(davis_polygon )
#
