#'---------------------
#'
#' Introduction to ANOVA
#' 
#' ---------------------
 
library(tidyverse)
library(readr)
library(ggplot2)
library(car)
library(emmeans)

### 
# One way analysis of variance ####
###

knees <-read_csv("../data/15e1KneesWhoSayNight.csv")

#check the data
ggplot(data = knees, 
       mapping = aes(x=treatment, y = shift)) +
  geom_point()

#fit a model with a 
#normal error process, linear dgp
knees_mod <- lm(shift ~ treatment, data = knees)

#check assumptions next
plot(knees_mod, which = 1)
plot(knees_mod, which = 2)

#f-tests!
anova(knees_mod)
Anova(knees_mod)

#visualize
ggplot(data = knees, 
       mapping = aes(x=treatment, y = shift)) +
  stat_summary(fun.data = mean_se)

#which treatment matters?
summary(knees_mod)

#hacky way to look at means
knees_mod_hack <- lm(shift ~ treatment - 1, data = knees)
summary(knees_mod_hack)

#real posthocs
library(emmeans)

knees_means <- emmeans(knees_mod, specs = "treatment")
#tukey test
contrast(knees_means, method = "pairwise")

#pairwise contrasts with no correction
#least squares means test (LSMEANS)
contrast(knees_means, method = "pairwise",
         adjust = "none")

#-#####
# Two-way ANOVA ####
#-####

zoop <- read_csv("../data/18e2ZooplanktonDepredation.csv") %>%
  mutate(block = factor(block))

#look at the data
ggplot(zoop,
       aes(x = treatment, y = zooplankton,
           color = block)) +
  geom_point() +
  facet_wrap(~block)

ggplot(zoop,
       aes(x = block, y = zooplankton, color = treatment)) +
  geom_point()

#the test!
zoop_mod <- lm(zooplankton ~ treatment + block, data = zoop)

plot(zoop_mod, which=1)
plot(zoop_mod, which = 2)

residualPlots(zoop_mod)

#F test!
Anova(zoop_mod)


#visualize
ggplot(zoop, 
       aes(x = treatment, y = zooplankton)) +
  stat_summary(fun.data = mean_cl_boot)

#posthoc
zoop_em <- emmeans(zoop_mod, specs = "treatment")

contrast(zoop_em, "pairwise")

### 
# 2-way factorial ANOVA
###

intertidal <- read_csv("../data/18e3IntertidalAlgae.csv")

#model
int_mod <- lm(sqrtarea ~ height + herbivores, data = intertidal)

#assumptions
plot(int_mod)
residualPlots(int_mod)

#look at the data
ggplot(data = intertidal,
       mapping = aes(x = herbivores, y = sqrtarea,
       fill = height)) +
  geom_boxplot()


ggplot(data = intertidal,
       mapping = aes(x = herbivores, y = sqrtarea)) +
  geom_point() +
  facet_wrap(~height)



ggplot(data = intertidal,
       mapping = aes(x = height, y = sqrtarea)) +
  geom_point() +
  facet_wrap(~herbivores)

#Ooops! An interaction!

int_lm_1 <- lm(sqrtarea ~ herbivores + height +
                 herbivores:height, data = intertidal)

int_lm_2 <- lm(sqrtarea ~ herbivores * height, 
               data = intertidal)

#F-tests!
Anova(int_lm_2)

#visualize
ggplot(intertidal,
       aes(x = herbivores,
           y = sqrtarea,
           color = height)) +
  stat_summary(fun.data = mean_cl_boot,
               position = position_dodge(width=0.5))


#visualize
ggplot(intertidal,
       aes(x = height,
           y = sqrtarea,
           color = herbivores)) +
  stat_summary(fun.data = mean_cl_boot,
               position = position_dodge(width=0.5))

#posthocs
int_em <- emmeans(int_lm_1,
                  specs = c("height", "herbivores"))

contrast(int_em, "pairwise", adjust = "none")
contrast(int_em, "dunnett", adjust = "none", ref=1)


### diagnostics
library(ggfortify)
autoplot(int_lm_1)
