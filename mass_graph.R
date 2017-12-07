# Sub group data by classification
meteorite_with_subgroups <- CleanMeteorData(meteorite.data)

# Mass charted against year
MassAgainstYear <- function(dataset, min_year, max_year) {
  dataset <- dataset %>% filter(year >= min_year & year <= max_year)
  return(ggplot(dataset, aes(year, fill = mass, colour = Class)) + 
  geom_density(alpha = 0.25) + 
    ylab("Mass(g)") + 
    xlab("Year") +
    ggtitle("Timeline of Meteorite Masses Split by Class"))
}
# Can use if want, but probably not needed
masses_subgroup_scatter <- ggplot(meteorite_with_subgroups) + 
  geom_point(mapping = aes(x = year, y = mass, size=mass), colour="Deep Pink", 
             fill="Pink",pch=21, size=5, alpha=I(0.7)) + 
  scale_size_continuous(range = c(0, 60000000))

# Took off class labels on x-axis to limit redundancy. Classes are already expressed with different color 
masses_against_subgroups <- ggplot(meteorite_with_subgroups, 
                                   aes(Class, fill = mass, colour = Class)) + 
                                   geom_density(alpha = 0.25) + 
                                   ylab("Mass(g)") + 
                                   ggtitle("Mass Distribution of Different Classes") +
                                   theme(axis.text.x = element_blank()
                              )
