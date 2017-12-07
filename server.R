# Load required packages
library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

# Supress warning messages
suppressWarnings(warnings)

# Source in necessary files
source("clean_data.R")
source("map.R")
#source("chart_one.R")
#source("chart_two.R")
source("year_graph.R")
source("bar_chart.R")

# Read in raw dataset
dataset <- read.csv("./data/meteorite-landings.csv", stringsAsFactors = FALSE)

# Filter out incorrect data, such as weird years and weird locations
meteorite.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% 
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) %>% 
  CleanMeteorData() %>% 
  select(-recclass)

# Clean data for more efficient use, stops the map from plotting more then one point at 
# exactly the same location
unique.data <- meteorite.data[!duplicated(meteorite.data$GeoLocation), ]

shinyServer(function(input, output) {
  output$map <- renderPlotly({
    # Create an interactive map with the given data.
    filter.by.year <- unique.data %>%
      filter(year >= as.numeric(input$min) & year <= as.numeric(input$max))
    
    # Create the map with only the meteorite data inside the inputted year range (inclusive)
    CreateMap(filter.by.year, filter.by.year[, "reclong"], filter.by.year[, "reclat"], 
              filter.by.year[, "year"], filter.by.year[, "name"], filter.by.year[, "mass"],
              filter.by.year[, "Class"])
  })
  
  # Create a bar chart with the selected data
  output$bar.chart <- renderPlot({
    meteorite.type <- meteorite.data %>%
      select_(input$select.column) %>% 
      group_by_(input$select.column) 
    colnames(meteorite.type) <- c("Characteristic")
    
    MakeBarChart(meteorite.type)
  })
  
  # Create a point to point line graph with the selected year range
  output$year.graph <- renderPlot({
    MakeYearGraph(meteorite.data, input$yearSlider[1], input$yearSlider[2])
  })
  
  output$range <- renderPrint({
    input$yearSlider
  })
})
