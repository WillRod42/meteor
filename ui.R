library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Meteorite Landings"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("year.range",
                  "Time Span (years)",
                  min = 860,
                  max = 2016,
                  value = c(860, 2016)),
      dateRangeInput("years", label = h3("Time Span in Years (860-2016)"),
                     start = "0860-01-01", end = "2016-01-01", format = "yyyy",
                     startview = "year")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
