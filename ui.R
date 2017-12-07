library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  
  # Addtional css styling
  #includeCSS("style.css"),
  
  # Application title
  "Meteorite Landings",
  
  tabPanel("Home",
    titlePanel("Project Overview")
    
    #vvv text below vvv
    
  ),
  
  tabPanel("Map",
    # Page title
    titlePanel("World Map of Meteorite Landings"),
    
    # Sidebar with a  2 number inputs for adjusting the year from the minimum to maximum year.
    sidebarLayout(
      sidebarPanel(
        numericInput("min", label = h5("Lower Range (year)"), value = 860, 
                     min = 860, max = 2013),
        numericInput("max", label = h5("Upper Range (year)"), value = 2013, 
                     min = 860, max = 2013)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotlyOutput("map")
      )
    )  
  ),
  
  # Creates a tab containing a bar graph.
  tabPanel("Meteorite Types",
    # Page Title       
    titlePanel("Different Characteristics of Meteorites"),
    
    sidebarLayout(
      sidebarPanel(
        # Creates slider bar for year graph
        selectInput("select.column",
                    h3("Select Data Type"),
                    choices = list(Observed = "fall", Condition = "nametype",
                                   Class = "Class"),
                    selected = "fall")
      ),
      
      mainPanel(
        plotOutput("bar.chart")
      )
    )
  ),
  
  # Creates a tab containing a point to point line graph
  tabPanel("# of Meteorites",
    # Page Title       
    titlePanel("Number of Meteorites Observed in a Time Span"),
           
    sidebarLayout(
      sidebarPanel(
        # Creates slider bar for year graph
        sliderInput("yearSlider", label = h3("Year Range"), min = 860, 
                    max = 2013, value = c(860, 2013))
      ),

      mainPanel(
        plotOutput("year.graph")
      )
    )
  )
  
))
