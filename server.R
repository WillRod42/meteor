# Load required packages
library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)
library(maps)
library(stringr)
library(tidyr)

# Supress warning messages
suppressWarnings(warnings)

# Source in necessary files
source("clean_data.R")
source("map.R")
source("frequency.R")
source("mass_graph.R")
source("year_graph.R")

# Read in raw dataset
dataset <- read.csv("./data/meteorite-landings.csv", stringsAsFactors = FALSE)

# Filter out incorrect data, such as weird years and weird locations
meteorite.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% 
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) %>% 
  CleanMeteorData() %>% 
  select(-recclass)

# Filter out repeated coordinates to render map faster
unique.data <- meteorite.data[!duplicated(meteorite.data$GeoLocation), ]


# Define server logic
shinyServer(function(input, output) {
  output$map <- renderPlotly({
    
    # Filter data depening on inputed year range
    filter.by.year <- unique.data %>%
      filter(year >= as.numeric(input$min) & year <= as.numeric(input$max))

    if(input$select.class != "All") {
      filter.by.year <- filter.by.year %>% 
        filter(filter.by.year$Class == input$select.class)
    }
    
    CreateMap(filter.by.year, filter.by.year[, "reclong"], filter.by.year[, "reclat"], filter.by.year[, "year"], 
              filter.by.year[, "name"], filter.by.year[, "Class"]) %>%
      return()
  })
  
  #
  output$freq.map <- renderPlotly({
    CreateColorMap(countries.df, input$checkbox)
  })
  
  # Create a bar chart with the given data.
  output$bar.chart <- renderPlot({
    meteorite.type <- meteorite.data %>%
      select_(input$select.column) %>%
      group_by_(input$select.column)
    colnames(meteorite.type) <- c("type")

    return(
      ggplot(meteorite.type, aes(x = type)) +
        geom_bar()
    )
  })

  # Create a point to point line graph with the selected year range
  output$year.graph <- renderPlot({
    MakeYearGraph(meteorite.data, 860, 2013)
  })
  
  # Create mass distrubtion across different classes
  output$mass.subgroups <- renderPlot({
    return(masses_against_subgroups)
  })
  
  # Create timeline of meteorite masses classified with different subgroups
  output$mass.year <- renderPlot({
    MassAgainstYear(meteorite_with_subgroups, input$yearSliderMass[1], input$yearSliderMass[2])
  })
  
})
