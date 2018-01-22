library(dplyr)
library(ggplot2)
library(car)


mole <- read.csv("./Data/18e4MoleRatLayabouts.csv")

ggplot(mole, aes(x=lnmass, y=lnenergy, color=caste))+
  geom_point(size=17) +
  theme_bw(base_size=14) +
  stat_smooth(method="lm")


mole_mod <- lm(lnenergy ~ lnmass*caste, data=mole)
mole_mod2 <- lm(lnenergy ~ lnmass +
                            caste +
                            lnmass : caste, data=mole)

Anova(mole_mod)

mole_mod_add <-lm(lnenergy ~ lnmass+caste, data=mole)
mole_mod_add_noint <-lm(lnenergy ~ lnmass+caste+0, data=mole)

Anova(mole_mod_add)

summary(mole_mod_add)$coef
summary(mole_mod_add_noint)$coef






mole_anova <- lm(lnenergy ~ caste, data=mole)
mole_anova_noint <- lm(lnenergy ~ caste+0, data=mole)

summary(mole_anova)$coef
summary(mole_anova_noint)$coef






mod1 <- lm(lnenergy ~ 1, data=mole)
mod2 <- lm(lnenergy ~ caste, data=mole)
mod3 <- lm(lnenergy ~ lnmass, data=mole)
mod4 <- lm(lnenergy ~ caste+lnmass, data=mole)
mod5 <- lm(lnenergy ~ caste*lnmass, data=mole)

AIC(mod1)
AIC(mod2)
AIC(mod3)
AIC(mod4)
AIC(mod5)


summary(mod5)$coef



#USE ggplot and mod4 to show an ANCOVA with 
#parellel lines

fitted(mod4)
predict(mod4, 
        newdata=data.frame(caste="worker", lnmass=4.2))

mole <- mutate(mole,
                fit_lnenergy = fitted(mod4))

ggplot(data = mole, mapping=aes(x=lnmass, 
                                y=lnenergy,
                                color = caste)) +
  geom_point(cex=1.3) +
  theme_bw(base_size=14) +
  geom_line(mapping=aes(y=fit_lnenergy)) +
  scale_color_manual(values=c("red", "blue"))