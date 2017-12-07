library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  #Application title
  "Meteorite Landings",
  
  tabPanel("Home",
    titlePanel("Project Overview")
    
    #vvv text below vvv
    
  ),
  
  tabPanel("Map",
    # Page title
    titlePanel("Map of Meteor Landings"),
    
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
  tabPanel("Simple Analysis",
    #Page Title       
    "Type of Meteors",
    
    sidebarLayout(
      sidebarPanel(
        selectInput("select.column",
                    h3("Select data"),
                    choices = list(discovery = "fall", condition = "nametype", class = "Class"),
                    selected = "fall"),
        
        #Creates slider bar for year graph (visually simpler than input)
        sliderInput("yearSlider", label = h3("Year Range"), min = 860, 
                    max = 2013, value = c(860, 2013))
      ),
      
      
      mainPanel(
        plotOutput("bar.chart"),
        plotOutput("year.graph")
      )
    )
    
   
  )
  
))
