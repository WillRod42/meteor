library(plotly)
library(dplyr)
library(tidyr)

setwd("~/Desktop/meteor")
data <- read.csv("./data/meteor.csv")

# Change the format of the date to be month/day/year.
data$year <- format(as.Date(data$year), "%m/%d/%Y")

# Separate the geoLocation to two columns Longitude, Latitude.
meteor.data <- data %>%
  extract(GeoLocation, c("Latitude", "Longitude"), "\\(([^,]+), ([^)]+)\\)")

# Create a map that displays the location of the meteor landings.
g <- list(
  scope = 'world',
  showland = TRUE,
  landcolor = toRGB("grey83"),
  subunitcolor = toRGB("black"),
  countrycolor = 'rgb(124, 106, 132)',
  showlakes = TRUE,
  lakecolor = toRGB("white"),
  showsubunits = TRUE,
  showcountries = TRUE,
  resolution = 50,
  projection = list(
    type = 'mercator')
)

map <- plot_geo(meteor.data) %>%  
  layout(title = "Where Meteor's Land", geo = g) %>%  
  add_markers(x = ~Longitude, y = ~Latitude, hoverinfo = "text",
              text = ~paste("Date: ", year, "</br></br>", "Name of Meteor: ", name, "</br>Size: ", mass..g.),
              marker = list(color = 'rgb(126, 41, 162)')
  )  
map
