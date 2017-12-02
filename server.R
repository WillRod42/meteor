# load required packages
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyr)

# set my working directory as needed
#setwd("~/Desktop/meteor")

# read in raw dataset
dataset <- read.csv("./data/meteorite-landings.csv")

# filter out incorrect data
meteorite.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations

unique.data <- meteorite.data[!duplicated(meteorite.data$GeoLocation), ]
  
shinyServer(function(input, output) {
    
  output$map <- renderPlotly({
    
    filter.by.year <- unique.data %>%
      filter(year >= as.numeric(input$min) & year <= as.numeric(input$max))
    
    #filter.by.year <- test.data %>%
     # filter(year >= as.numeric(input$range[[1]]) & year <= as.numeric(input$range[[2]]))
  
    g <- list(
      scope = "world",
      showland = TRUE,
      landcolor = toRGB("grey83"),
      subunitcolor = toRGB("black"),
      countrycolor = "rgb(124, 106, 132)",
      showlakes = TRUE,
      lakecolor = toRGB("white"),
      showsubunits = TRUE,
      showcountries = TRUE,
      resolution = 50,
      projection = list(type = "mercator")
    )
    
    return(plot_geo(unique.data) %>%  
      layout(title = "Where Meteorite's Land", geo = g, autosize = FALSE, width = 700, height = 600) %>%  
      add_markers(x = ~reclong, y = ~reclat, hoverinfo = "text",
                  text = ~paste("Date: ", year, "</br></br>", "Name of Meteorite: ",
                                name, "</br>Size: ", mass),
                  marker = list(color = "rgb(126, 41, 162)", size = 3)
      ))
    
  })
  
})
