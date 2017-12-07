#required libraries
library(dplyr)
library(ggplot2)
library(plotly)
library(maps)
library(stringr)

#read in raw data
dataset <- read.csv("./data/meteorite-landings.csv", stringsAsFactors = FALSE)

meteor.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations 

#select geo coordinates
meteor.landings <- meteor.data %>% 
  select(reclat, reclong)

#convert geo coordinates to country
countries <- map.where("world", meteor.landings$reclong, meteor.landings$reclat)

#count landings by country
countries.df <- data.frame(country = countries, stringsAsFactors = FALSE) %>% 
  group_by(country) %>% 
  filter(country != "NA") %>% 
  summarize(count = n())

#filter out country subcategories because they don't work with plotly
#filter out Antarctica to properly color map
countries.df <- countries.df%>%
  filter(!grepl(":", country))

CreateColorMap <- function(dataset, antarctica) {
  if(!antarctica) {
    dataset <- dataset %>%
      filter(country != "Antarctica")
  }
  
  # thin black boundaries
  l <- list(color = toRGB("black"), width = 0.5)
  
  # specify map projection/options
  g <- list(
    scope = "world",
    showland = TRUE,
    landcolor = "rgb(230, 230, 230)",
    countrycolor = "rgb(124, 106, 132)",
    showocean = TRUE,
    oceancolor = "rgb(128, 191, 255)",
    showcountries = TRUE,
    
    projection = list(type = "mercator")
  )
  
  p <- plot_geo(dataset, locationmode = "country names", width = 900, height = 750) %>%
    add_trace(
      z = ~count, color = ~count, colors = 'Reds',
      text = ~country, locations = ~country, marker = list(line = l)
    ) %>%
    colorbar(title = 'Fequency') %>%
    layout(
      title = 'Meteorite Landing Frequency',
      geo = g
    )
  return(p)
}