library(plotly)
library(dplyr)

# Set the locale as necessary to prevent string12 error.
Sys.setlocale('LC_ALL','C')

# Create an interactive map with the given data.
CreateMap <- function(dataset, long, lat, year, name, class) {
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
  
  # Plot the map using the inputted data
  map <- plot_geo(dataset, width = 900, height = 750) %>%  
           layout(title = "Where Meteorite's Land", geo = g, autosize = FALSE) %>%  
           add_markers(x = long, y = lat,
                       text = ~paste("Date: ", year),
                       hoverinfo = "text",
                       marker = list(color = "rgb(82, 0, 102)", size = 3)
           )
  
  #hoverinfo bug workaround found on plotly forums#
  map <- plotly_build(map)$x
  l <- length(map$data)
  for (i in 1:l) {
    map$data[[i]]$hoverinfo <- NULL
  }
  map <- as_widget(map)
  #-----------------------------------------------#
  
  return(map)
}