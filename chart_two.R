# load required packages
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyr)

# set my working directory as needed
#setwd("~/Desktop/meteor")

# mass for meteorites are in grams

# read in raw dataset
dataset <- read.csv("./data/meteorite-landings.csv", stringsAsFactors = FALSE)

# filter out incorrect data
meteorite.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations

masses_byYear <- meteorite.data %>% 
  select(mass, year) 

#makes a color point map
#graph just off mass and do a count for year 
#Add data points to map with value affecting size
masses_mapped <- ggplot(masses_byYear) + 
  geom_point(mapping = aes(x = year, y = mass, size=mass), colour="Deep Pink", 
             fill="Pink", pch=21, size=5, alpha=I(0.7)) + 
            scale_size_continuous(range = c(0, 60000000))


