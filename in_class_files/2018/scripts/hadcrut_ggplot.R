#'-------------------------
#'
#' Intro to ggplot2 using HADCRUT
#' 
#' 2018-02-14
#' 
#' --------------------------

# Load a library ####
library(readr)

#install.packages("ggplot2")
library(ggplot2)

library(forcats)

# load our data ####
had_crut <- read_csv("../data/hadcrut_temp_anomoly_1850_2015.csv")


# do any data cleaning we need ####
had_crut$month_name <- factor(had_crut$month_name)
levels(had_crut$month_name)

had_crut$month_name <- fct_inorder(had_crut$month_name)
levels(had_crut$month_name)

#-------------------------------------
# first visualizations!
# Looking at distribution of anomolys
#-------------------------------------

had_dens <- ggplot(data = had_crut,
       mapping = aes(x = anomaly))

had_dens +
  geom_histogram()

#group by density
had_dens_group <- ggplot(data = had_crut,
                         mapping = aes(x = anomaly,
                                       group = month_name))

had_dens_group +
  geom_density()

#introducing positions
had_dens_group +
  geom_density(position = position_stack())

had_dens_group +
  geom_density(position = position_dodge(width=3))

had_dens_group +
  geom_histogram(position = position_stack(),
                 color = "red")

#----------------
# Moving into the second dimension
#----------------

had_plot_base <- ggplot(data = had_crut,
                        mapping = aes(x = month_name,
                                      y = anomaly))

had_plot_base +
  geom_point()

had_plot_base +
  geom_point(alpha = 0.3)

had_plot_base +
  geom_jitter(alpha = 0.4, width = 0.2, height = 0)

had_plot_base +
  geom_line()

had_plot_base +
  geom_line(mapping = aes(group = year))

#--------------------
# Color!
#--------------------

had_lines <- had_plot_base +
  geom_line(mapping = aes(group = year, color = year))

had_lines +
  scale_color_continuous(low = "blue", high = "red")

had_lines +
  scale_color_gradient2(low = "blue",
                        mid = "yellow",
                        high = "red",
                        midpoint = 1925)
had_lines +
  scale_color_gradientn(colors = c("red", "blue", "orange", "purple"))

had_lines +
  scale_color_gradientn(colors = rainbow(7))

#Color brewer!
library(RColorBrewer)

display.brewer.all(n = 10, exact.n=FALSE)

had_lines +
  scale_color_gradientn(colors = brewer.pal(n = 9, 
                                            name = "BrBG"))

library(viridis)

had_lines +
  scale_color_viridis(guide = "none")

#----------------
# Facets
#----------------

had_months <- ggplot( data = had_crut,
                      mapping = aes(x = year,
                                    y = anomaly,
                                    group = month_name)) +
  geom_line()

had_months +
  facet_wrap(~ month_name)

#facet_grid(row ~ column)
#if no row, or no col, use .
had_months +
  facet_grid(. ~ month_name)

#facets by decade
had_lines +
  facet_wrap(~cut_width(year, 10))

# Exercise: 
#   1. Try out cut_interval and cut_number. What do they do?
#   2. Make a plot where facets and colors reflect the same information.


ggplot(data = had_crut,
       mapping = aes(x = month, y = anomaly, group = year,
                     color = cut_width(year, 50))) +
  geom_line() +
  facet_wrap(~cut_width(year, 50))

#---------
# smoothing
#---------

had_plot_base +
  stat_summary()

had_months +
  facet_wrap( ~ month_name) +
  stat_smooth()

had_months +
  facet_wrap( ~ month_name) +
  stat_smooth(method = "lm")


#--------------
# themes
#--------------

had_lines_good <- had_lines +
  scale_color_viridis()


had_lines_good +
  theme_bw(base_size = 17)

had_lines_good +
  theme_void()

#make a defaut theme
theme_set(theme_bw())

had_lines_good

#lots of fun!
library(ggthemes)

had_lines_good +
  theme_few()

had_lines_good +
  theme_fivethirtyeight()

had_lines_good <- had_lines_good +
  theme_solarized(base_size=13, light=TRUE)


#----------
# make it look good
#-----------

had_lines_good +
  ylim(-1, 2) +
  xlab("") +
  ylab("Temperature Anomaly") +
  guides(color = guide_colorbar("Year")) +
  scale_x_discrete(expand = c(0,0)) +
  coord_polar() +
  ggtitle("Global Temperature Change from 1850-2015")

