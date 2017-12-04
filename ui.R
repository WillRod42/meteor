library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  #Application title
  "Meteorite Landings",
  
  tabPanel("Map",
    # Page title
    titlePanel("Interactive Map"),
    
    # Sidebar with a  2 number inputs for adjusting the year from the minimum to maximum year.
    sidebarLayout(
      sidebarPanel(
        numericInput("min", label = h3("Lower Range (year)"), value = 860, 
                     min = 860, max = 2013),
        numericInput("max", label = h3("Upper Range (year)"), value = 2013, 
                     min = 860, max = 2013)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotlyOutput("map")
      )
    )  
  ),
  
  # Creates a tab containing a bar graph.
  tabPanel("Charts",
    #Page Title       
    "Charts",
    
    sidebarLayout(
      sidebarPanel(
        selectInput("select.column",
                    h3("Select data"),
                    choices = list(discovery = "fall", condition = "nametype", class = "Class"),
                    selected = "fall")
      ),
      
      mainPanel(
        plotOutput("ring.chart")
      )
    )
  )
))
