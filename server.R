# load required packages
library(shiny)
library(plotly)
library(dplyr)

# supress warning messages
suppressWarnings(warnings)

#include other necessary files
source("clean_data.R")
source("map.R")
source("chart_one.R")
source("chart_two.R")

# read in raw dataset
dataset <- read.csv("./data/meteorite-landings.csv")

# filter out incorrect data
meteorite.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations

#clean data for easy use
clean.data <- CleanMeteorData(meteorite.data) %>% 
                select(-recclass)
unique.data <- meteorite.data[!duplicated(meteorite.data$GeoLocation), ]


shinyServer(function(input, output) {
  output$map <- renderPlotly({
    
    # Create an interactive map with the given data.
    filter.by.year <- unique.data %>%
      filter(year >= as.numeric(input$min) & year <= as.numeric(input$max))
    
    CreateMap(filter.by.year, filter.by.year[, "reclong"], filter.by.year[, "reclat"], filter.by.year[, "year"], 
              filter.by.year[, "name"], filter.by.year[, "mass"]) %>%
      return()
  })
  
  # Create a bar chart with the given data.
  output$bar.chart <- renderPlot({
    meteor.type <- clean.data %>%
      select_(input$select.column) %>% 
      group_by_(input$select.column) 
    colnames(meteor.type) <- c("type")
    
    return(
      ggplot(meteor.type, aes(x = type)) +
      geom_bar() 
    )  
  })

})

#%>% 
#summarize(count = n())
#, "count")
