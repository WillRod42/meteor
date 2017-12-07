# Function to create and return  a bar chart with the inputted data selected from
# the dropdown menu
MakeBarChart <- function(meteorite.type) {
  return(
    ggplot(meteorite.type, aes(x = Characteristic)) +
      geom_bar() +
      labs(x = "Characteristic", y = "Count") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    )
}