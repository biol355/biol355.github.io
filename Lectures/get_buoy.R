#'----------------------------------------
#' File of functions to read in buoy data
#' @author Jarrett Byrnes
#' 
#' @description Mutiple functions needed to read in NOAA buoy data
#' and process it to return monthly buoy data
#' 
#' @date 2018-04-04
#' 
#'----------------------------------------

library(tidyverse)
library(readr)

###
# Wrapper Function to get one buoy 
# data file with monthly averaging
###

get_buoy <- function(a_year){
  one_buoy <- read_buoy(a_year) %>%
    format_buoy %>%
    make_monthly_buoy 
  
  return(one_buoy)
}

###
#  Function read in one buoy data file
#  given a year as arguments
###
read_buoy <- function(a_year, buoy_number = 44013, 
                      buoy_dir = "./data/buoydata/"){
  
  #make a file name
  buoy_file <- str_c(buoy_dir, buoy_number, "_", a_year, ".csv")
  
  #read in the file
  one_buoy <- read_csv(buoy_file, 
                       na = c("99", "999", 
                              "99.00", "9999.00",
                              "99.0", "9999.0",
                              "999.0"))
  
  #return the file
  return(one_buoy)
  
}

###
# Wrapper function
# to format the problems
# out of buoy data
###

format_buoy <- function(a_buoy_df){
  
  a_buoy_df <- a_buoy_df %>%
    fix_year_names %>%
    fix_bad_rows %>%
    fix_bad_years
  
  return(a_buoy_df)
}

###
# Modular formatting
# functions
###
#fix bad column nams for year
fix_year_names <- function(a_buoy_df){
  
  names(a_buoy_df) <- names(a_buoy_df) %>%
    str_replace("^YY$", "YYYY") %>%
    str_replace("X\\.YY", "YYYY")
  
  return(a_buoy_df)
}

#fix bad rows
fix_bad_rows <- function(a_buoy_df){
  if(is.character(a_buoy_df$MM[1])){
    
    a_buoy_df <- a_buoy_df[-1,] %>% 
      mutate_all(as.numeric)
    
  }
  
  return(a_buoy_df)
}

# fix years off by 1900
#bad years
fix_bad_years <- function(a_buoy_df){
  return(a_buoy_df %>%
           mutate(YYYY = ifelse(YYYY < 1900, YYYY+1900, YYYY)))
}

###
# function to 
# summarize buoy data 
# to a monthly level and
# make nice column names
###

make_monthly_buoy <- function(a_buoy_df){
  buoydata <- a_buoy_df %>%
    select(YYYY, MM, WVHT, WTMP) %>%
    rename(Year = YYYY,
           Month = MM,
           Wave_Height = WVHT,
           Temperature_c = WTMP) %>%
    group_by(Year, Month) %>%
    summarise(Wave_Height = mean(Wave_Height, na.rm=T),
              Temperature_c = mean(Temperature_c, na.rm=T)) %>%
    ungroup()
  
  return(buoydata)
}