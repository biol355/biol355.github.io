#'--------------------------
#'
#'  dplyr lab
#'  2018-02-21
#'--------------------------

#load some packages ####
#install.packages("gapminder")
library(gapminder)
library(dplyr)
library(ggplot2)

# look at gapminder
str(gapminder)


# currently this is how subset ####

#look at gapminder, looking only at the Americas
#and get an average lifeExp

le <- gapminder[gapminder$continent == "Americas", ]$lifeExp

mean(le)


mean(subset(gapminder, gapminder$continent=="Americas")$lifeExp)

# Dplyr and the 5 major verbs ####

#1. select()

head(gapminder)

select(gapminder, country, year, gdpPercap)

#2. filter()

filter(gapminder, country == "Uganda" | country=="United Kingdom")

## EXERCISE: Make a data frame that has only the African values
## of lifeExp, country, and year. How many rows does this
## data frame have, and why?

#### detour to pipes!
log10(10)

10 %>% log10

10 %>% log10()

10 %>% log10(.)

#pipes and dplyr

africaminder <- gapminder %>%
  filter(continent == "Africa") %>%
  select(country, year, lifeExp)

africaminder %>%
  ggplot(aes(year, lifeExp)) +
  geom_point()
  

#3. group_by()
str(gapminder)

gapminder %>%
  group_by(continent) %>%
  str

gapminder %>%
  group_by(continent)

#4. summarize()
#data.frame(a = 1:10)

percapminder <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))

percapminder

#Exercise: Calculate the average life exptancy per country
#Which has the longest and which the shortest?
#maybe look at arrange() or use filter with an |
#see also max() and min()

minmaxminder <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  filter(mean_lifeExp == min(mean_lifeExp) |
           mean_lifeExp == max(mean_lifeExp) 
  )

minmaxminder

# lots of groups!
gpd_bycontinent_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))

gpd_bycontinent_byyear %>%
  arrange(desc(mean_gdpPercap))

# lots summaries
gpd_pop_bycontinenty_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))

gpd_pop_bycontinenty_byyear

ggplot(gpd_pop_bycontinenty_byyear,
       aes(x = mean_pop,
           y = mean_gdpPercap,
           color = sd_pop,
           size = sd_pop)) + 
  geom_point() +
  scale_color_gradient(low = "blue", high = "red") +
  scale_x_log10() +
  scale_y_log10() + 
  facet_wrap(~continent)

# counting
gapminder %>%
  filter(year == 2002) %>%
  count(continent)

coutminder <- gapminder %>%
  count(continent, year)

ggplot(coutminder,
       aes(x = continent, y = factor(year), fill = n)) +
  geom_tile()

# n()
gapminder %>%
  group_by(continent) %>%
  summarize(
    num_countries = n(),
    se_pop = sd(pop)/sqrt(n()))

### n versus count()
gapminder %>%
  count(continent, year)

gapminder %>%
  group_by(continent, year) %>%
  summarize(count_countries = n())


#5. mutate()
#we want gdp in billions
billionminder <- gapminder
billionminder$gdp_billion <- billionminder$gdpPercap * billionminder$pop / 10^9


billionminder_dplyr <- gapminder %>%
  mutate(gdp_billion = gdpPercap * pop / 10^9)# %>%
#  rename(life_exp = lifeExp)

billionminder_dplyr_decadal <- 
  billionminder_dplyr %>%
  mutate(decade = cut_width(year, width=10)) %>%
  group_by(country, decade) %>%
  summarize(mean_pop = mean(pop))

billionminder_dplyr_wealth <- billionminder_dplyr %>%
  mutate(is_below_mean = ifelse(gdp_billion < mean(gdp_billion), "lower", "higher"),
         
         wealth = case_when(
           gdp_billion < 1000 ~ "lower",
           gdp_billion < 7000 ~ "middle",
           TRUE ~ "higher"
           
         ))

## Exercise: grab a continent, any continent!
## 1. Make a plot that shows the timeseries of life expectancy
## through time for it's countries separating countries using color,
## facet by gdp per capita split into 5 equal bins
##
## 2. Now, make a timeseries plot of each continents average life expectancy over time

