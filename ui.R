library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Meteorite Landings"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      numericInput("min", label = h3("Lower Range (year)"), value = 860, 
                   min = 860, max = 2016),
      numericInput("max", label = h3("Upper Range (year)"), value = 2016, 
                   min = 860, max = 2016),
      
      #sliderInput("range",
       #           "Time Span (years)",
        #          min = 860,
         #         max = 2016,
          #        value = c(860, 2016))
      
      plotOutput("ring.chart")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("map")
    )
  )
))
