###########
# From the buoy outside of Salem Sound
# Station 44013 (LLNR 420) - BOSTON 16 NM East of Boston, MA
###########

library(RCurl)

years <- 1986:2013

URL <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=44013hYYYY.txt.gz&dir=data/historical/stdmet/"

for(ayear in years){
  
  buoy <- getURL(gsub("YYYY", ayear, URL))
  
  buoydata <- read.delim(textConnection(buoy), sep="")
  
  write.csv(buoydata, paste0("data/44013_", ayear, ".csv"), row.names=F)
  
}