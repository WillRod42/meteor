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


shinyServer(function(input, output) {
    
  output$map <- renderPlotly({
    
    filter.by.year <- meteorite.data %>%
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
    
    return(plot_geo(filter.by.year) %>%  
      layout(title = "Where Meteorite's Land", geo = g) %>%  
      add_markers(x = ~reclong, y = ~reclat, hoverinfo = "text",
                  text = ~paste("Date: ", year, "</br></br>", "Name of Meteorite: ",
                                name, "</br>Size: ", mass),
                  marker = list(color = "rgb(126, 41, 162)")
      ))
    
  })
  
  output$ring.chart <- renderPlot({
    found.or.fell <- meteor.data %>% 
      select(fall) %>% 
      group_by(fall) %>% 
      summarize(count = n())
    
    colnames(found.or.fell) <- c("type", "count")
    
    found.or.fell$fraction <- found.or.fell$count / sum(found.or.fell$count)
    found.or.fell <- found.or.fell[order(found.or.fell$fraction), ]
    found.or.fell$ymax <- cumsum(found.or.fell$fraction)
    found.or.fell$ymin <- c(0, head(found.or.fell$ymax, n=-1))
    
    return(ggplot(found.or.fell, aes(fill=type, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
           geom_rect() +
           coord_polar(theta="y") +
           xlim(c(0, 4)) +
           theme(panel.grid=element_blank()) +
           theme(axis.text=element_blank()) +
           theme(axis.ticks=element_blank()) +
           annotate("text", x = 0, y = 0, label = "Observed Falling \n vs \n Found After Impact") +
           labs(title="How Meteorites Were Discovered")
    )
  })
  
})
