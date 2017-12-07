# Load required packages
library(shiny)
library(plotly)

# Define UI for our meteorite shiny application
shinyUI(navbarPage(
  
  # Application title
  "Meteorite Landings",
  
  tabPanel("Home",
    titlePanel("Project Overview")
    
  ),
  
  # Tab for containing the dynamic map plot
  tabPanel("Map",
    # Page title
    titlePanel("World Map of Meteorite Landings"),
    
    # Sidebar that contains a two number inputs for adjusting the minimum and maximum
    # year used in the map
    sidebarLayout(
      sidebarPanel(
        h4("Select Time Period"),
        numericInput("min", label = h5("Lower Range (year)"), value = 860, 
                     min = 860, max = 2013),
        numericInput("max", label = h5("Upper Range (year)"), value = 2013, 
                     min = 860, max = 2013)
      ),
      
      # Show a world map plot with points at every meteorite location
      mainPanel(
         plotlyOutput("map")
      )
    )  
  ),
  
  # Tab for containing the dynamic bar graph on meteorite characteristics
  tabPanel("Meteorite Types",
    # Page Title       
    titlePanel("Different Characteristics of Meteorites"),
    
    # Sidebar that contains a selectable dropdown list to change the type of data viewed
    sidebarLayout(
      sidebarPanel(
        selectInput("select.column",
                    h4("Select Data Type"),
                    choices = list(Observed = "fall", Condition = "nametype",
                                   Class = "Class"),
                    selected = "fall")
      ),
      
      # Show the selected data as a bar chart
      mainPanel(
        plotOutput("bar.chart")
      )
    )
  ),
  
  # Tab containing the dynamic point to point line graph
  tabPanel("# of Meteorites",
    # Page Title       
    titlePanel("Number of Meteorites Observed in a Time Span"),
           
    # Sidebar that contains a double ended slider to select a year range to be displayed
    sidebarLayout(
      sidebarPanel(
        sliderInput("yearSlider", label = h4("Year Range"), min = 860, 
                    max = 2013, value = c(860, 2013))
      ),

      # Show the point to point line graph
      mainPanel(
        plotOutput("year.graph")
      )
    )
  )
  
))
