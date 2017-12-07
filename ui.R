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
                    selected = "fall")
      ),
      
      mainPanel(
        plotOutput("bar.chart")
      )
    )
  ),
  
  # Creates a tab containing a line graph.
  tabPanel("Frequency",
           #Page Title       
           "Frequency of Meteor Landings",
           
           sidebarLayout(
             sidebarPanel(
               selectInput("first_class",
                           h3("Select First Meteor Class"),
                           choices = list("Overview","Ordinary Chondrite", "Carbonaceous Chondrite", "Enstatite Chondrite",
                                          "Other Minor Condrites", "Achondrites", "Stony Iron", "Iron", "Stone Uncl",
                                          "Unknown")
                           ),
               
               # Hide the second slider unless the first meteor class is not overview.
               conditionalPanel(
                 condition = 'input.first_class != "Overview"',
                 selectInput("second_class",
                           h3("Select Second Meteor Class"),
                           choices = list("Ordinary Chondrite", "Carbonaceous Chondrite", "Enstatite Chondrite",
                                          "Other Minor Condrites", "Achondrites", "Stony Iron", "Iron", "Stone Uncl",
                                          "Unknown"))
                 )
               ),
             mainPanel(
               plotOutput("line.chart")
             )
           )
  )
))
