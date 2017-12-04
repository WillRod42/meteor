#required libraries
library(plotly)
library(dplyr)

CreateMap <- function(dataset, long, lat, year, name, mass) {
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
  
  map <- plot_geo(dataset) %>%  
    layout(title = "Where Meteor's Land", geo = g) %>%  
    add_markers(x = long, y = lat, hoverinfo = "text",
                text = paste("Date: ", year, "</br></br>", "Name of Meteor: ", name, "</br>Size: ", mass),
                marker = list(color = 'rgb(126, 41, 162)')
    )
}