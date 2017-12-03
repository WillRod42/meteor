#required libraries
library(dplyr)
library(ggplot2)

dataset <- read.csv("./data/meteorite-landings.csv")

meteor.data <- dataset %>%
  filter(year>=860 & year<=2016) %>% # filter out weird years
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0)) # filter out weird locations 

meteor.landings <- meteor.data %>%
                    select(year) %>% 
                    group_by(year) %>% 
                    summarize(count = n())
                
ggplot(meteor.landings, aes(x = meteor.landings[, "year"], y = meteor.landings[, "count"], color = I("blue"))) + 
  geom_point(shape=1) + 
  xlab("year") + 
  ylab("count")

#-----------------------------------------------#

found.or.fell <- meteor.data %>% 
                  select(fall) %>% 
                  group_by(fall) %>% 
                  summarize(count = n())

colnames(found.or.fell) <- c("type", "count")

found.or.fell$fraction <- found.or.fell$count / sum(found.or.fell$count)
found.or.fell <- found.or.fell[order(found.or.fell$fraction), ]
found.or.fell$ymax <- cumsum(found.or.fell$fraction)
found.or.fell$ymin <- c(0, head(found.or.fell$ymax, n=-1))

ring.chart <- ggplot(found.or.fell, aes(fill=type, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
     geom_rect() +
     coord_polar(theta="y") +
     xlim(c(0, 4)) +
     theme(panel.grid=element_blank()) +
     theme(axis.text=element_blank()) +
     theme(axis.ticks=element_blank()) +
     annotate("text", x = 0, y = 0, label = "Observed Falling \n vs \n Found After Impact") +
     labs(title="How Meteorites Were Discovered")

#-----------------------------------------------#

meteor.mass <- meteor.data %>% 
                select(mass, year) %>% 
                group_by(year) %>% 
                summarize(avg.mass = mean(mass)) %>% 
                filter(avg.mass <= 10000)

ggplot(meteor.mass, aes(x = meteor.mass[, "year"], y = meteor.mass[, "avg.mass"], color = I("blue"))) + 
  geom_point(shape=1) + 
  xlab("year") + 
  ylab("mass (g)")
