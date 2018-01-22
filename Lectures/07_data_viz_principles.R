###################
# Code for Data Viz week
###################

library(readxl)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(lubridate)

plankton <- read_excel("../Data/EST-PR-PlanktonChemTax.xls", sheet=2)
plankton <- mutate(plankton, Month = month(Date))


pairs(plankton[,-c(1:4)] %>% select(-one_of("SampleName", 
                                            "SubsampleName", "BottleName", 
                                            "SampleType", "Comments")))


pretty_cut_interval <- function(...){
  int <- cut_interval(...)
  
  levels(int) <- gsub(",", " - ", levels(int))
  levels(int) <- gsub("\\(", "", levels(int))
  levels(int) <- gsub("\\]", "", levels(int))
  levels(int) <- gsub("\\[", "", levels(int))
  
  int
  
  
}


plankton$SalInterval <- pretty_cut_interval(plankton$Salinity, 5)
levels(plankton$SalInterval) <- paste0("Salinity = ", 
                                       levels(plankton$SalInterval),
                                       " PSU")

monthly_plankton <- plankton %>% 
  group_by(Month) %>% 
  summarize(TotalChlA=mean(TotalChlA))

#########Plots


#Barplot

ggplot(data=monthly_plankton, aes(xmin=Month-0.3, xmax=Month+0.3,
                                  ymin=0, ymax=TotalChlA)) +
  geom_rect() +
  scale_x_continuous(breaks=seq(1,12), labels=month.name) +
  theme_few(base_size=18) +
  xlab("Month") +
  ylab("Average Chlorophyll A") +
  theme(axis.text.x=element_text(angle=45, hjust=1))

#Histogram
ggplot(data=plankton, aes(x=TotalChlA)) +
  geom_histogram()+
  theme_few(base_size=18) +
  xlab("Count") +
  ylab("Chlorophyll A") 

#Boxplot

ggplot(data=plankton, aes(x = Month, y=TotalChlA, group=Month)) +
  geom_boxplot()+
  scale_x_continuous(breaks=seq(1,12), labels=month.name) +
  theme_few(base_size=18) +
  xlab("Month") +
  ylab("Chlorophyll A") +
  theme(axis.text.x=element_text(angle=45, hjust=1))

#Dot and line Plot
ggplot(data=plankton, aes(x = Month, y=TotalChlA)) +
  geom_point(alpha=0) +
  stat_summary(fun.data =mean_cl_normal) +
  ylim(c(0,25)) +
  scale_x_continuous(breaks=seq(1,12), labels=month.name) +
  theme_few(base_size=18) +
  xlab("Month") +
  ylab("Chlorophyll A") +
  theme(axis.text.x=element_text(angle=45, hjust=1))

#Scatterplot
scatter_plankton <- ggplot(data=plankton, aes(x = Temp, y=TotalChlA)) +
  geom_point(size=3) +
  xlab("Temperature (C)") +
  ylab("Chlorophyll A") 

scatter_plankton_orig <- scatter_plankton

scatter_plankton <- scatter_plankton+  theme_few(base_size=18) 

scatter_plankton

#Show 0
scatter_plankton <- scatter_plankton + 
  scale_x_continuous(breaks=seq(0,30,5)) +
  xlim(c(0,30))

scatter_plankton

#Log scale
scatter_plankton +
  scale_y_log10()


#Color scale 1
scatter_plankton +
  scale_y_log10() +
  aes(color=log10(Temp)) +
  scale_color_gradientn(colors=c("blue", "grey", "red"),
                        guide=guide_colorbar(title="Log10\nTemperature"))


#Color scale 2
scatter_plankton +
  scale_y_log10() +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms"))


#Statistical Features

scatter_plankton +
  scale_y_log10() +
  stat_smooth(method="lm", color="red", fill=NA)

#Facets
scatter_plankton +
  scale_y_log10() +
  stat_smooth(method="lm", color="red", fill=NA) +
  facet_wrap(~SalInterval) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms"))

###Minimalism
scatter_plankton_orig   +
  scale_y_log10() +
  xlim(c(0,30)) +
  stat_smooth(method="lm", color="red", fill="darkgrey", level=0.99) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms")) +
  theme_grey(base_size=17)


###Minimalism 2
scatter_plankton_orig   +
  scale_y_log10() +
  stat_smooth(method="lm", color="red", fill=NA) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms")) +
  theme_grey(base_size=17)



###Minimalism 3
scatter_plankton_orig   +
  scale_y_log10() +
  stat_smooth(method="lm", color="red", fill=NA) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms")) +
  theme_bw(base_size=17)


###Minimalism 4
scatter_plankton_orig   +
  scale_y_log10() +
  stat_smooth(method="lm", color="red", fill=NA) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms")) +
  theme_few(base_size=17)



###Minimalism 5
scatter_plankton_orig   +
  scale_y_log10() +
  stat_smooth(method="lm", color="red", fill=NA) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms")) +
  theme_tufte(base_size=17)



###Minimalism 6
scatter_plankton_orig   +
  scale_y_log10() +
  xlim(c(0,25)) +
  stat_smooth(method="lm", color="red", fill=NA) +
  aes(color=log10(DiatomsandChrysophytes)) +
  scale_color_gradientn(colors=c("black", "lightblue", "forestgreen"),
                        guide=guide_colorbar(title="Log10\nDiatoms")) +
  theme_tufte(base_size=17)



#########
# Map map map!
#########

#https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/ggmap/ggmapCheatsheet.pdf
library(ggmap)

bounds <- plankton %>%
  summarize(lowerleftlon = min(Longitude)-0.01,
            lowerleftlat = min(Latitude)-0.01,
            upperrightlon = max(Longitude)+0.01,
            upperrightlat = max(Latitude)+0.01)

pie <- get_map(location = as.matrix(bounds), 
               source="google", maptype="satellite")


ggmap(pie) + 
  geom_point(data=plankton, mapping=aes(x=Longitude, y=Latitude), 
             size=2, color="pink") +
  xlab("Latitude") +
  ylab("Longitude") +
  theme_tufte(base_size=17)
