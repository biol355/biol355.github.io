library(ggplot2)
fat <- read.csv("./lm/17q04BodyFatHeatLoss Sloan and Keatinge 1973 replica.csv")

fat_plot <- ggplot(data=fat, aes(x=leanness, y=lossrate)) + 
  geom_point()
fat_plot

fat_mod <- lm(lossrate ~ leanness, data=fat)

#assumptions
plot(fat_mod, which=1)
plot(fat_mod, which=2)

#f-tests of model
anova(fat_mod)

#t-tests of parameters
summary(fat_mod)

#plot with line
fat_plot + 
  stat_smooth(method=lm, formula=y~x)


######


library(ggplot2)
deet <- read.csv("./lm/17q24DEETMosquiteBites.csv")

deet_plot <- ggplot(data=deet, aes(x=dose, y=bites)) + 
  geom_point()
deet_plot

deet_mod <- lm(bites ~ dose, data=deet)

#assumptions
plot(deet_mod, which=1)
plot(deet_mod, which=2)

#f-tests of model
anova(deet_mod)

#t-tests of parameters
summary(deet_mod)

#plot with line
deet_plot + 
  stat_smooth(method=lm, formula=y~x)

#######

deet_mod_log <- lm(log(bites) ~ dose, data=deet)

#assumptions
plot(deet_mod_log, which=1)
plot(deet_mod_log, which=2)

#f-tests of model
anova(deet_mod_log)

#t-tests of parameters
summary(deet_mod_log)

#plot with line
deet_plot + 
  scale_y_continuous(trans="log") +
  stat_smooth(method=lm, formula=y~x)

########
zoo <- read.csv("./lm/17q02ZooMortality Clubb and Mason 2003 replica.csv")

zoo_plot <- ggplot(data=zoo, aes(x=mortality, y=homerange)) + 
  geom_point()
zoo_plot

zoo_mod <- lm(homerange ~ mortality, data=zoo)

#assumptions
plot(zoo_mod, which=1)
plot(zoo_mod, which=2)

#f-tests of model
anova(zoo_mod)

#t-tests of parameters
summary(zoo_mod)

#plot with line
zoo_plot + 
  stat_smooth(method=lm, formula=y~x)


######
zoo_mod_log <- lm(log(homerange) ~ mortality, data=zoo)

#assumptions
plot(zoo_mod_log, which=1)
plot(zoo_mod_log, which=2)

#f-tests of model
anova(zoo_mod_log)

#t-tests of parameters
summary(zoo_mod_log)

#plot with line
zoo_plot + 
  scale_y_continuous(trans="log")+
  stat_smooth(method=lm, formula=y~x)
