library(readxl)
library(leaflet)
library(dplyr)
library(ggplot2)
library(ggmap)

hemlock_data <- read_excel("./hemlock.xlsx")
hemlock_data

hemlock_sites <- read_excel("./hemlock.xlsx", sheet=2)
str(hemlock_sites)


hem_full <- full_join(hemlock_data, hemlock_sites) %>%
  mutate(hasArea = ifelse(is.na(Area), "No", "Yes"),
         hasDeadHemlock = ifelse(is.na(`Dead Hem BA`), "No", "Yes"))




forests <- get_map(location = c(mean(hem_full$Longitude), mean(hem_full$Latitude)),
                   source="google", maptype="satellite", zoom=10)

ggmap(forests) +
  geom_point(data=hem_full, mapping=aes(y=Latitude, x=Longitude, 
                                        shape=hasDeadHemlock, color=hasArea),
             size=6) +
  theme_bw(base_size=19)


