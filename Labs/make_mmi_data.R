#---------
# File to make datasets for mmi lab
#---------

library(rethinking)
library(dplyr)

data(milk)

milk <- milk %>%
  filter(!is.na(neocortex.perc)) %>%
  mutate(neocortex = neocortex.perc/100)

data("tulips")
data(nettle)
data(rugged)


library(readr)
write_csv(milk, "./data/milk.csv")
write_csv(nettle, "./data/nettle.csv")
write_csv(rugged, "./data/rugged.csv")
write_csv(tulips, "./data/tulips.csv")
