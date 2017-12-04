# load required packages
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyr)

# set my working directory as needed.
#setwd("~/Desktop/meteor")

# set locale as needed.
#Sys.setlocale('LC_ALL','C') 

# read in raw dataset
dataset <- read.csv("./data/meteorite-landings.csv")

# filter out incorrect data
meteorite.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations

unique.data <- meteorite.data[!duplicated(meteorite.data$GeoLocation), ]
  
shinyServer(function(input, output) {
  
  output$map <- renderPlotly({
    
    # Create an interactive map with the given data.
    filter.by.year <- unique.data %>%
      filter(year >= as.numeric(input$min) & year <= as.numeric(input$max))
    
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
    
    return(plot_geo(filter.by.year, width = 900, height = 750) %>%  
      layout(title = "Where Meteorite's Land", geo = g, autosize = FALSE) %>%  
      add_markers(x = ~reclong, y = ~reclat, hoverinfo = "text",
                  text = ~paste("Date: ", year, "</br></br>",  "Meteorite Name: ",
                                name,"</br>Size: ", mass),
                  marker = list(color = "rgb(82, 0, 102)", size = 3)
      ))
    
  })
  
  # Create a ring chart with the given data.
  output$ring.chart <- renderPlot({
    meteor.type <- meteorite.data %>% 
      select_(input$select.column) %>% 
      group_by_(input$select.column) %>% 
      summarize(count = n())
    
    colnames(meteor.type) <- c("type", "count")
    
    meteor.type$fraction <- meteor.type$count / sum(meteor.type$count)
    meteor.type <- meteor.type[order(meteor.type$fraction), ]
    meteor.type$ymax <- cumsum(meteor.type$fraction)
    meteor.type$ymin <- c(0, head(meteor.type$ymax, n=-1))
    
    return(
      ggplot(meteor.type, aes(fill=type, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
      geom_rect() +
      coord_polar(theta="y") +
      xlim(c(0, 4)) +
      theme(panel.grid=element_blank()) +
      theme(axis.text=element_blank()) +
      theme(axis.ticks=element_blank()) +
      labs(title= paste0(meteor.type[1, "type"], " vs ", meteor.type[2, "type"]))
    )
  })
  
})
