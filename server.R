library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    #subset.by.year <- meteorite.data %>%
      #filter(year > as.numeric(input$year.range[[1]]) &
              #year < as.numeric(input$year.range[[2]]))
    #subset.by.year <- meteorite.data %>%
      #filter(year > as.numeric(input$dates[[1]]) &
              #year < as.numeric(input$dates[[2]]))
    
    
  })
  
})
