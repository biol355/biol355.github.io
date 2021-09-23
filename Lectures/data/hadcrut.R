# read_cru_hemi.r
#
# Reads a CRU-format hemispheric average file, as provided at
# http://www.cru.uea.ac.uk/cru/data/temperature
#
# Format has two lines for each year.
#  1) monthly mean anomalies plus an annual mean
#  2) coverage percentages
#
# Returns a data frame with columns:
#  year (1850 to final year)
#  annual (mean annual anomaly)
#  month.1 ... month.12 (mean monthly anomaly)
#  cover.1 ... cover.12 (percentage coverage)
#
read_cru_hemi <- function(filename) {
  # read in whole file as table
  tab <- read.table(filename,fill=TRUE)
  nrows <- nrow(tab)
  # create frame
  hemi <- data.frame(
    year=tab[seq(1,nrows,2),1],
    annual=tab[seq(1,nrows,2),14],
    month=array(tab[seq(1,nrows,2),2:13]),
    cover=array(tab[seq(2,nrows,2),2:13])
  )
  # mask out months with 0 coverage
  hemi$month.1 [which(hemi$cover.1 ==0)] <- NA
  hemi$month.2 [which(hemi$cover.2 ==0)] <- NA
  hemi$month.3 [which(hemi$cover.3 ==0)] <- NA
  hemi$month.4 [which(hemi$cover.4 ==0)] <- NA
  hemi$month.5 [which(hemi$cover.5 ==0)] <- NA
  hemi$month.6 [which(hemi$cover.6 ==0)] <- NA
  hemi$month.7 [which(hemi$cover.7 ==0)] <- NA
  hemi$month.8 [which(hemi$cover.8 ==0)] <- NA
  hemi$month.9 [which(hemi$cover.9 ==0)] <- NA
  hemi$month.10[which(hemi$cover.10==0)] <- NA
  hemi$month.11[which(hemi$cover.11==0)] <- NA
  hemi$month.12[which(hemi$cover.12==0)] <- NA
  #
  return(hemi)
}


dat <- read_cru_hemi("https://crudata.uea.ac.uk/cru/data/temperature/HadCRUT5.0Analysis_gl.txt")


library(tidyr)
library(dplyr)

dat_long <- dat %>%
  select(-starts_with("cover"), -annual) %>%
  pivot_longer(month.1:month.12, 
               names_to = "month_number",
               values_to = "anomaly") %>%
  mutate(month_number = as.numeric(gsub("month.", "", month_number))) %>%
  mutate(month = month.abb[month_number])

write.csv(dat_long, "Lectures/data/hadcrut_temp_anomoly_1850_2021.csv")

