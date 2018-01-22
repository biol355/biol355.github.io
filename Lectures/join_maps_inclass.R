library(dplyr)
library(readxl)

#load the data
heart_disease <- 
  read_excel("./join_maps/hd_all.xlsx")

#look at the data
heart_disease

#hunt for the character
idx <- grep("[a-z,A-Z]", heart_disease$Death_Rate)
idx

heart_disease$Death_Rate[idx]


#load the data, with NA values
heart_disease <- 
  read_excel("./join_maps/hd_all.xlsx",
             na = "Insufficient Data")

heart_disease


### Load in mapdata
library(mapdata)
library(ggplot2)

map_df <- map_data("county")

head(map_df)

 #plot a map
ggplot(map_df, 
       mapping = aes(x=long,y=lat, 
                     group = group)) +
  geom_polygon()


## First attempt at a join
map_heart_df <- full_join(heart_disease, map_df)

map_df <- map_df %>%
  rename(State = region, 
         County = subregion)

#try again
map_heart_df <- full_join(heart_disease, map_df)

map_heart_df

#make heart disease match capialization
#of map_df
heart_disease <- heart_disease %>%
  mutate(State = tolower(State), 
         County = tolower(County)) %>%
  mutate(County = gsub("\\.", "", County)) %>%
  mutate(County = gsub("\\'", "", County))


#testing with anti_join
View(anti_join(heart_disease, map_df))
View(anti_join(map_df, heart_disease))


##Make the join
heart_map_df <- right_join(heart_disease, map_df)

heart_map_df


#plot a map
ggplot(heart_map_df, 
       mapping = aes(x=long,y=lat, 
                     group = group, fill=Death_Rate)) +
  geom_polygon() +
  scale_fill_gradient2(low = "navy", 
                       mid = "white", midpoint=500, 
                       high="pink")

#make some discrete categories
heart_map_df <- heart_map_df %>%
  mutate(Discrete_Deaths = cut_interval(Death_Rate, 5))


heart_choro <- ggplot(heart_map_df, 
       mapping = aes(x=long,y=lat, 
                     group = group, fill=Discrete_Deaths)) +
  geom_polygon() +
  scale_fill_brewer(palette = "RdYlBu") 

#add state outlines
heart_choro +
  borders("state", colour="black")


##############
#Shapefiles!


library(sp)
library(rgdal)

#Reads in a shapefile
ecoregions <- readOGR("./join_maps/MEOW-TNC/meow_ecos.shp",
                      layer="meow_ecos")

slotNames(ecoregions)
View(ecoregions@data)

#first, create an ID column in the ecoregion data
ecoregions@data$id = rownames(ecoregions@data)

#second, make a data frame of borders with an ID
ecoregions_points = fortify(ecoregions, ECOREGION="id")

#make a data frame with a join
ecoregions_df <- inner_join(ecoregions_points, 
                            ecoregions@data,
                            by="id")

#OK! Add in temperature
sst_data <- read.csv("./join_maps/hadsst_regions.csv",
                     stringsAsFactors=FALSE)

head(sst_data)

sst_decadal <- sst_data %>%
  mutate(Decade = round(Year/10)*10) %>%
  group_by(ECOREGION, Decade) %>%
  summarise(tempC = mean(tempC, na.rm=T)) %>%
  ungroup() %>%
  group_by(ECOREGION) %>%
  mutate(tempC_anomoly = tempC - mean(tempC)) %>%
  ungroup()

#join!
sst_map_data <- inner_join(sst_decadal, ecoregions_df)

#map it

ggplot(data=sst_map_data, 
       mapping = aes(x = long, y = lat, 
                     group = group, fill = tempC_anomoly)) +
  borders("world", lwd=0.1, color="lightgrey") +
  geom_polygon(alpha=0.9) +
  facet_wrap(~Decade) +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_bw()

#Oh, let's make a plot
ggplot(data=sst_decadal, mapping=aes(x=Decade, y=tempC_anomoly)) +
  geom_line(mapping=aes(group=ECOREGION), colour="lightgrey") +
  theme_bw() +
  stat_smooth(method="lm", color="red", fill=NA) +
  ylab("Decadal Temperature Anomoly")