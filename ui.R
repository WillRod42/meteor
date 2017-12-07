library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  #Application title
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
  
  tabPanel("Meteor Frequency",
           plotlyOutput("freq.map"),
           #note
           em("*note: Antarctic data has been omitted because of the large difference in number of landings between it and the rest of the world")
  ),
  
  # Creates a tab containing a bar graph.
  tabPanel("Simple Charts",
    #Page Title       
    "",
    
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
