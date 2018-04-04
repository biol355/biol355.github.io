library(dplyr)
library(ggplot2)

birth_df <- data_frame(day = c('Sun', 'Mon', 'Tues', 'Weds', 'Thurs', 'Fri', 'Sat'), 
                       births = c(33, 41, 63, 63, 47, 56, 47))

str(birth_df)

birth_df <- 
  mutate(birth_df, day = factor(day, levels = c('Sun', 'Mon', 'Tues', 'Weds', 'Thurs', 'Fri', 'Sat')))

ggplot(data = birth_df, aes(x = day, y = births)) + 
  geom_point() + 
  geom_bar(stat = 'identity')

?chisq.test

observed <- (1 / 365)
expected <- (1 / 365) * c(52, 52, 52, 52, 52, 53, 52)

test_stat <- chisq.test(x = birth_df$births, p = expected)

str(test_stat)

test_stat

# warning message
# chi square approximation may be incorrect

# assignment
