library(readxl)
library(dplyr)
heart_disease <- read_excel("./join_maps/hd_all.xlsx", na="Insufficient Data")


library(mapdata)
library(ggplot2)
map_df <- map_data("county")


head(heart_disease)
head(map_df)

#make them sync
map_df <- map_df %>%
  rename(State = region, County = subregion) %>%
  mutate(State = toupper(State),
         County = toupper(County))

heart_disease <- heart_disease %>%
  mutate(State = toupper(State),
         County = toupper(County))

#check for mismatch
mismatch <- anti_join(heart_disease, map_df)

#Diagnose missing . counties
mismatch
mismatch$County
unique((map_df %>% filter(State=="WISCONSIN"))$County)

heart_disease <- heart_disease %>%
  mutate(County = gsub("\\.", "", County)) %>%
  mutate(County = gsub("\\'", "", County))

mismatch <- anti_join(heart_disease, map_df)
mismatch


county_heart_disease <- full_join(heart_disease, map_df)

#plot
ggplot(county_heart_disease, aes(x=long, y=lat, 
                                 fill=Death_Rate, group=group)) +
  geom_polygon()

county_heart_disease$Death_group <- cut_interval(county_heart_disease$Death_Rate, 5)

ggplot(county_heart_disease, aes(x=long, y=lat, 
                                 fill=Death_group, group=group)) +
  geom_polygon() +
  scale_fill_brewer(palette="Reds") +
  coord_equal() +
  borders("state", colour="white") +
  theme_void()

#merge high resolution with low resolution shapefile
library(sp)
library(rgdal)
ecoregions <- readOGR("./MEOW-TNC/meow_ecos.shp", layer="meow_ecos")

library(leaflet)

leaflet(ecoregions) %>%
  addPolygons() %>%
  addTiles()


class(ecoregions)
slotNames(ecoregions)

ecoregions@data$id = rownames(ecoregions@data)
ecoregions_points = fortify(ecoregions, ECOREGION="id")

ecoregions_df = inner_join(ecoregions_points, ecoregions@data, by="id")

ggplot(data=ecoregions_df, mapping=aes(long, lat, group=group)) +
  geom_polygon() 


temp_data <- read.csv("hadsst_regions.csv", stringsAsFactors=FALSE)

temp_data_decadal <- temp_data %>%
  mutate(Decade = round(Year/10)*10) %>%
  group_by(ECOREGION) %>%
  mutate(regional_mean_temp = mean(tempC, na.rm=T)) %>%
  ungroup() %>%
  group_by(Decade, ECOREGION) %>%
  summarise(decadal_temp_anomoly = mean(tempC, na.rm=T) - mean(regional_mean_temp)) %>%
  ungroup()

ecoregions_df_temp <- inner_join(ecoregions_df, temp_data_decadal)

ggplot(data=ecoregions_df_temp, mapping=aes(long, lat, 
                                            group=group, 
                                            fill=decadal_temp_anomoly)) +
  geom_polygon() +
  facet_wrap(~Decade) +
  borders("world") +
  theme_void() +
  scale_fill_gradient(low="blue", high="red")
#show temperature by decade in marine ecoregions of the world

#show trends by ecoregion and site

