#required libraries
library(plotly)
library(dplyr)
library(tidyr)

#setwd("~/Desktop/meteor")
data <- read.csv("./data/meteorite-landings.csv")

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
  add_markers(x = ~reclong, y = ~reclat, hoverinfo = "text",
              text = ~paste("Date: ", year, "</br></br>", "Name of Meteor: ", name, "</br>Size: ", mass..g.),
              marker = list(color = 'rgb(126, 41, 162)')
  )
