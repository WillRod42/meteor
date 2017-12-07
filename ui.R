# Load required packages
library(shiny)
library(plotly)

# Define UI for our meteorite shiny application
shinyUI(navbarPage(
  
  # Application title
  "Meteorite Landings",
  
  tabPanel("Home",
    titlePanel("Project Overview"),
    
    #vvv text below vvv
    #purpose
    p("The purpose of this project is to explore a dataset about meteorite landings. We wanted to take data from about ~34,000 meteorite
      landings from 2013 to all the way back to 860, and see if we could find any interesting insights. This project was created to visually
      show what insights we could gather from this dataset."),
    
    #data source
    br(), br(), br(),
    "Our team originally found this meteorite data from the following link:", 
    a("https://www.kaggle.com/nasa/meteorite-landings"),
    br(),
    "However, the original source of the data is from NASA:", 
    a("https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh"),
    
    #background info
    br(), br(),
    p("While most of the data we work with in this app is easy to interpret, one part of the dataset is very specific to meteorites.
      The meteorite class requires more intimate knowledge of meteorites. Here is a some reading about meteorite classes: "),
    a("https://en.wikipedia.org/wiki/Meteorite_classification"),
    
    #link to github
    br(), br(),
    "Source code:",
    a("https://github.com/WillRod42/meteor")
>>>>>>> fb6592e1e0ebb7fd82ef1478584218af9ca0d006
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
  
  tabPanel("Meteor Frequency",
           plotlyOutput("freq.map"),
           #note
           em("*note: Antarctic data has been omitted because of the large difference in number of landings between it and the rest of the world")
  ),
  
  # Creates a tab containing a bar graph.
  tabPanel("Analytics",
    
    # Sidebar that contains a selectable dropdown list to change the type of data viewed
    sidebarLayout(
      sidebarPanel(
        selectInput("select.column",
                    h4("Select Data Type"),
                    choices = list(Observed = "fall", Condition = "nametype",
                                   Class = "Class"),
                    selected = "fall"),
        
        #Creates slider bar for year graph (visually simpler than input)
        sliderInput("yearSlider", label = h3("Year Range"), min = 860, 
                    max = 2013, value = c(860, 2013)),
        
        #Creates slider bar for year graph (visually simpler than input)
        sliderInput("yearSliderMass", label = h3("Year Range for Mass"), min = 860, 
                    max = 2013, value = c(860, 2013))
      ),
      
      # Show the selected data as a bar chart
      mainPanel(
        plotOutput("bar.chart"),
        plotOutput("year.graph"),
        plotOutput("mass.subgroups"),
        plotOutput("mass.year")
      )
    )
  )
  

        
      )
    )
