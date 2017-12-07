# Select coordinates from data
meteorite.landings <- meteorite.data %>% 
  select(reclat, reclong)

# Convert latitude and longitude coordinates to location by country
countries <- map.where("world", meteorite.landings$reclong, meteorite.landings$reclat)

# Count number of meteorites by country
countries.df <- data.frame(country = countries, stringsAsFactors = FALSE) %>% 
  group_by(country) %>% 
  filter(country != "NA") %>% 
  summarize(count = n())

# Filter out country subcategories because they are not necessary
# Filter out Antarctica data to properly color map for perspective
countries.df <- countries.df%>%
  filter(!grepl(":", country) & country != "Antarctica")


CreateColorMap <- function(dataset) {
  g <- list(
    showframe = FALSE,
    showcoastlines = TRUE,
    projection = list(type = 'Mercator')
  )
  
  freq.map <- plot_geo(dataset, locationmode = "country names") %>%
    add_trace(
      z = ~count, 
      color = ~count, 
      colors = 'Reds',
      text = ~country, locations = ~country, 
      marker = list(line = list(color = toRGB("black"), width = 0.5))
    ) %>%
    colorbar(title = 'Frequency') %>%
    layout(
      title = 'Meteorite Landing Frequency',
      geo = g
    )
  return(freq.map)
}
