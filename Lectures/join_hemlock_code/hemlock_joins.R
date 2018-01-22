library(readxl)
library(leaflet)
library(dplyr)
library(ggplot2)
library(ggmap)

hemlock_data <- read_excel("./hemlock.xlsx")
hemlock_data

hemlock_sites <- read_excel("./hemlock.xlsx", sheet=2)
str(hemlock_sites)

leaflet() %>% addTiles() %>%
  addMarkers(data=hemlock_data, ~Longitude, ~Latitude,
             popup= ~`Dead Hem BA`)


hem_inner <- inner_join(hemlock_data, hemlock_sites)

nrow(hemlock_data)
nrow(hemlock_sites)
nrow(hem_inner)

qplot(Humus, `Tree Den`, data=hem_inner, size=I(4))


hem_left <- left_join(hemlock_data, hemlock_sites)
nrow(hem_left)

hem_right <- right_join(hemlock_data, hemlock_sites)
nrow(hem_right)


hem_full <- full_join(hemlock_data, hemlock_sites)
nrow(hem_full)

hem_semi <- semi_join(hemlock_data, hemlock_sites)
nrow(hem_semi)


hem_anti <- anti_join(hemlock_data, hemlock_sites)
nrow(hem_anti)


forests <- get_map(location = c(mean(hem_full$Longitude), mean(hem_full$Latitude)),
               source="google", maptype="satellite", zoom=7)

ggmap(forests) +
  geom_point(data=hem_full, mapping=aes(y=Latitude, x=Longitude))



ggplot() +
  geom_raster(data=hem_full, mapping=aes(y=Latitude, x=Longitude, 
                                         fill=Area))
