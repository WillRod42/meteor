# Load required packages
library(shiny)
library(plotly)

# Define UI for our meteorite shiny application
shinyUI(navbarPage(
  
  # Application title
  "Meteorite Landings",
  
  tabPanel("Home",
    titlePanel("Project Overview"),
    
    # Purpose
    p("The purpose of this project is to explore a dataset about meteorite landings.
      We wanted to take data from about ~34,000 meteorite landings from 2013 to all
      the way back to 860, and see if we could find any interesting insights. This 
      project was created to visually show what insights we could gather from this dataset."),
    
    # Source of dataset
    br(), br(),
    "Our team originally found this meteorite data from the following link:", 
    a("https://www.kaggle.com/nasa/meteorite-landings"),
    br(),
    "However, the original source of the data is from NASA:", 
    a("https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh"),
    
    # Background Information
    br(), br(), br(),
    p("While most of the data we work with in this app is easy to interpret, one
      part of the dataset is very specific to meteorites. The meteorite class requires
      more intimate knowledge of meteorites. Here is a some reading about meteorite classes: "),
    a("https://en.wikipedia.org/wiki/Meteorite_classification"),
    
    # Github Link
    br(), br(), br(),
    "Source code:",
    a("https://github.com/WillRod42/meteor")
    
  ),
  
  # Tab for containing the dynamic map plot
  tabPanel("Map",
    # Page title
    titlePanel("World Map of Meteorite Landings"),
    
    sidebarLayout(
      
      # Sidebar panel that contains a two number inputs for adjusting the minimum and 
      # maximum year used in the map
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
  
  tabPanel("Frequency",
           plotlyOutput("freq.map"),
           # Note
           em("*note: Antarctic data has been omitted because of the large difference
              in number of landings (20161) between it and the rest of the world")
  ),
  
  # Tab for containing the dynamic bar graph on meteorite characteristics
  tabPanel("Types",
           
    # Page Title 
    titlePanel("Different Characteristics of Meteorites"),
    
    sidebarLayout(
      
      # Sidebar panel that contains a selectable dropdown list to change the type of 
      # data viewed
      sidebarPanel(
        selectInput("select.column",
                    h4("Select Data Type"),
                    choices = list(Observed = "fall", Condition = "nametype",
                                   Class = "Class"),
                    selected = "fall")
      ),
      
      # Show the selected data as a bar chart
      mainPanel(
        plotOutput("bar.chart"),
        
        # Additional information
        br(),
        p("In order to better understand the different characteristics of meteorites, here
          are some descriptions of each data type: "),
        p("The obervervation of meteorites are whether the meteorite was seen falling, or
          was discovered after its impact. Fell: the meteorite's fall was observed. Found:
          the meteorite's fall was not observed."),
        p("The condition of meteorites are either valid: a typical meteorite, or relict: a
          meteorite that has been highly degraded by weather on Earth."),
        p("The classes of meteorites are based on one of a large number of sub-classes
          based on physical, chemical, and various other characteristics.")
      )
      
    )
  ),
  
  # Tab containing the dynamic point to point line graph
  tabPanel("# of Meteorites",
           
    # Page title
    titlePanel("Number of Meteorites Observed in a Time Span"),
    
    sidebarLayout(
      
      # Sidebar panel that contains a double ended slider to select a year range to 
      # be displayed
      sidebarPanel(
        sliderInput("yearSlider", label = h4("Year Range"), min = 860,
                    max = 2013, value = c(860, 2013))
      ),
             
      # Show the point to point line graph
      mainPanel(
        plotOutput("year.graph")
      )
    )  
  ),
  
  tabPanel("Mass Analytics",
           
    # Page title
    titlePanel("An Analysis on the Mass of Meteorites"),
           
      sidebarLayout(
             
        # Sidebar panel that contains a double ended slider to select a year range to 
        # be displayed
        sidebarPanel(
          sliderInput("yearSliderMass", label = h4("Year Range for Mass"), min = 860, 
                      max = 2013, value = c(860, 2013))
        ),
             
        # Display the charts analyzing mass data
        mainPanel(
          plotOutput("mass.year"),
          plotOutput("mass.subgroups")
        )
      )  
    )
))