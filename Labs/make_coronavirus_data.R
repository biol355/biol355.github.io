library(sf)
library(rnaturalearth)
library(coronavirus)
library(dplyr)
library(tidyr)

coronavirus <- update_coronavirus()

coronavirus_sf <- coronavirus_spatial()

worldmap <- rnaturalearth::ne_countries(returnclass = "sf")

coronavirus_points <- coronavirus_spatial()

coronavirus_polys <- coronavirus_spatial(return_shape = "polygon")

usa <- ne_states(country = "United States of America", returnclass = "sf")

usa_confirmed_sf <- coronavirus %>%
  filter(Country.Region=="US") %>%
  #filter(type=="confirmed") %>%
  st_as_sf(coords = c(x = "Long", y = "Lat"),
           crs = st_crs(usa))

usa_points <- st_join(usa_confirmed_sf, usa) %>%
  group_by(name, date)

usa_polygons <- st_join(usa, usa_confirmed_sf) %>%
  group_by(name, date)


#counties
library(tigris)
library(tidycensus)
ma_county_maps <- st_as_sf(counties(state="Massachusetts",  cb=TRUE)) %>%
  st_transform(st_crs(usa_confirmed_sf))

ma_counties_coronavirus <- st_join(ma_county_maps, usa_confirmed_sf) %>%
  filter(!is.na(STATEFP))



st_write(coronavirus_sf, "./data/coronavirus_shapefiles/coronavirus_worldwide.shp", delete_dsn = TRUE)
st_write(worldmap, "./data/coronavirus_shapefiles/worldmap.shp",  delete_dsn = TRUE)
st_write(coronavirus_points, "./data/coronavirus_shapefiles/coronavirus_points.shp", delete_dsn = TRUE)
st_write(coronavirus_polys, "./data/coronavirus_shapefiles/coronavirus_polys.shp", delete_dsn = TRUE)
st_write(usa, "./data/coronavirus_shapefiles/usa.shp", delete_dsn = TRUE)
st_write(usa_points, "./data/coronavirus_shapefiles/usa_coronavirus_points.shp", delete_dsn = TRUE)
st_write(usa_polygons, "./data/coronavirus_shapefiles/usa_coronavirus_polygons.shp", delete_dsn = TRUE)
st_write(ma_county_maps, "./data/coronavirus_shapefiles/ma_county_maps.shp", delete_dsn = TRUE)
st_write(ma_counties_coronavirus, "./data/coronavirus_shapefiles/ma_counties_coronavirus.shp", delete_dsn = TRUE)
