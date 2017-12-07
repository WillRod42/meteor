#required libraries
library(dplyr)
library(ggplot2)
library(maps)

dataset <- read.csv("./data/meteorite-landings.csv", stringsAsFactors = FALSE)

meteor.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations 

meteor.landings <- meteor.data %>% 
  select(reclat, reclong)

countries <- map.where(database="world", meteor.landings$reclong, meteor.landings$reclat)
