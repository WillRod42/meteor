# Load required packages
library(dplyr)
library(ggplot2)

# Function to create the point to point line graph using the inputted year range
make_year_Graph <- function(meteorite.data, min_year, max_year) {
  meteorite.year <- meteorite.data %>% 
    filter(year >= min_year & year <= max_year)
  meteorite.year <- meteorite.data %>% 
    group_by(year) %>% summarize(count = n())
  
  return (
    ggplot(meteorite.year, aes(x = year, y = count)) + 
    geom_line(color = "#660066") +
    geom_point(color = "#FF8000") +
    labs(x = "Year", y = "Count")
    )
}

