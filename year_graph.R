#required libraries
library(dplyr)
library(ggplot2)


dataset <- read.csv("./data/meteorite-landings.csv", stringsAsFactors = FALSE)

meteor.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations 




make_year_Graph <- function(meteor.data, min_year, max_year) {
  meteor.year <- meteor.data %>% filter(year >= min_year & year <= max_year)
  meteor.year <- meteor.year %>% group_by(year) %>% summarize(count = n())
  
  return (ggplot(meteor.year, aes(x = year, y = count,)) + 
  geom_line(color = "#660066") +
  geom_point(color = "#FF8000"))
  
}

