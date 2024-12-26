library(tidyverse); library(sf)

lapd_areas <- st_read("LAPD_Div/LAPD_Divisions.shp")
add_draw <- st_as_sf(crime_2023_color,coords = c("LON","LAT"),crs = st_crs(boundary))
boundary <- st_as_sf(lapd_areas)
boundary <- st_transform(boundary, crs = 4326)
zipcode_areas <- st_read("Los_Angeles_City_Zip_Codes/Los_Angeles_City_Zip_Codes.shp")
zip_boundary <- st_as_sf(zipcode_areas)
zip_boundary <- st_transform(zip_boundary, crs = 4326)

ggplot() +
  geom_sf(data = zip_boundary,aes(fill = factor(ZIPCODE)),alpha = 0.3,show.legend = FALSE) +
  geom_sf(data = boundary, color = alpha("red",1), fill = NA) +
  geom_sf_text(data = zip_boundary, aes(label = ZIPCODE), size = 1) +
  theme_minimal()