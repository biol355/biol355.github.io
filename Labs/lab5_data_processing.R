library(lubridate)
library(dplyr)

pesticides <- read.csv("./data/Kaua_i_Agricultural_Good_Neighbor_Program_RUP_Use_Reporting.csv", stringsAsFactors=F)

head(pesticides$Month.Year)

p <-pesticides %>%
  mutate(Month.Year = (parse_date_time(pesticides$Month.Year, orders="mdy hms")),
  Month = month(Month.Year),
  Year = year(Month.Year)) %>%
    select(-Month.Year) %>%
  rename(Primary_Chemical = A.I...1..Name,
         Primary_Pounds_Used = A.I...1..Pounds,
         Secondary_Chemical = A.I...2..Name,
         Secondary_Pounds_Used = A.I...2..Pounds,
         Tertiary_Chemical = A.I...3..Name,
         Tertiary_Pounds_Used = A.I...3..Pounds)

names(p) <- gsub("\\.", "_", names(p))
names(p) <- gsub("__", "_", names(p))
names(p) <- gsub("_$", "", names(p))   
p <- cbind(Month = p$Month, Year = p$Year, p[,1:(ncol(p)-2)])

write.csv(p, file="./data/kaua_i_agricultural_RUP_use.csv", row.names=F)
