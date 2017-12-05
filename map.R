#required libraries
library(plotly)
library(dplyr)

# Set the locale as necessary to prevent string12 error.
#Sys.setlocale('LC_ALL','C')

# Create an interactive map with the given data.
CreateMap <- function(dataset, long, lat, year, name, mass) {
  g <- list(
    scope = "world",
    showland = TRUE,
    landcolor = "rgb(230, 230, 230)",
    subunitcolor = toRGB("black"),
    countrycolor = "rgb(124, 106, 132)",
    showlakes = TRUE,
    lakecolor = "rgb(128, 191, 255)",
    showocean = TRUE,
    oceancolor = "rgb(128, 191, 255)",
    showsubunits = TRUE,
    showcountries = TRUE,
    resolution = 50,
    projection = list(type = "mercator")
  )
  
  map <- plot_geo(dataset, width = 900, height = 750) %>%  
           layout(title = "Where Meteorite's Land", geo = g, autosize = FALSE) %>%  
           add_markers(x = long, y = lat, hoverinfo = "text",
                       text = ~paste("Date: ", year, "</br></br>",  "Meteorite Name: ",
                                     name,"</br>Size: ", mass),
                       marker = list(color = "rgb(82, 0, 102)", size = 3)
           )
  return(map)
}