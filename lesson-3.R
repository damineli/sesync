## Libraries and data

library(dplyr)
library(ggplot2)

surveys <- read.csv("data/surveys.csv", na.strings = "") %>% 
  filter(!is.na(species_id), !is.na(sex), !is.na(weight)) #ALWAYS BY ROW

## Constructing layered graphics in ggplot

ggplot(data = surveys,
       aes(x = species_id, y = weight )) + 
  geom_point() +
  geom_boxplot()



ggplot(data = surveys,
       aes(x = species_id, y = weight )) +
  geom_boxplot() +
  geom_point(stat = "summary",
             fun.y = "mean",
             color = "red")

#qplot(x = species_id, y = weight, data = surveys, geom = "boxplot")
  
...

ggplot(data = surveys,
       aes(x = species_id, y = weight)) +
  ...
  geom_point(...,
             ...,
             ...)

## Exercise 1
  
  ggplot(data = surveys,
         aes(x = species_id, y = weight )) +
    geom_boxplot() +
    geom_point(stat = "summary",
               fun.y = "mean",
               color = "red")
  
  
dat <-  filter(surveys, 
         species_id == "DM") #%>% group_by(year)
  
ggplot(data = dat,
       aes(x = year, y = weight, color = sex)) +
  geom_point(stat = "summary",
             fun.y = "mean") + 
  geom_smooth(method = "lm")


## Adding and customizing scales

surveys_dm <- filter(surveys, species_id == "DM")

year_n_weight <- ggplot(data = surveys_dm,
       aes(x = year, y = weight, color = sex)) + 
  geom_point(aes(shape = sex),
             size = 3,
             stat = "summary",
             fun.y = "mean") +
  geom_smooth(aes(group = sex), method = "lm")



year_n_weight + scale_color_manual(values = c("tomato", "darkorchid"),
                                   labels = c("Female", "Male"))


# HOW NOT TO HAVE REDUNDANT LEGENDS?????



year_wgt <- ggplot(data = surveys_dm,
                   aes(...,
                       ...,
                       ...)) +
  geom_point(aes(shape = sex),
             size = 3,
             stat = "summary",
             fun.y = "mean") +
  geom_smooth(method = "lm")
year_wgt

year_wgt <- year_wgt +
  scale_color_manual(...,
                     ...) +
  ...(values = c(3, 2),
      labels = c("Female", "Male"))
year_wgt

## Exercise 2

base_h <- ggplot(data = surveys_dm, aes(fill = sex, x = weight)) +
  geom_histogram(binwidth = 1) #+ geom_density()
    

#### EXPRESSION DOES NOT EVALUATE
base_h <- base_h +
  labs( title = expression(paste(italic("Dipodomys merriami", "weight distribution"))), x = "xlab", y = "ylab") +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60)) +
  theme_bw() +
  theme(legend.position = c(0.2, 0.5),
        plot.title = element_text(face = "bold", vjust = 2),
        axis.title.y = element_text(size = 13, vjust = 1), 
        axis.title.x = element_text(size = 13, vjust = 0))
  
######
surveys_dm$month <- as.factor(surveys_dm$month)
l


## Axes, labels and themes

histo <- ggplot(data = surveys_dm,
                aes(x = weight, fill = sex)) +
  geom_...
histo

histo <- histo +
  ...(title = "Dipodomys merriami weight distribution",
       x = "Weight (g)",
       y = "Count") +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))
histo

histo <- histo +
  theme_bw() +
  theme(legend.position = c(0.2, 0.5),
        plot.title = ...,
        ... = element_text(...),
        ... = element_text(size = 13, vjust = 0))
histo

## Facets

surveys_dm$month <- as.factor(surveys_dm$month)
levels(surveys_dm$month) <- c("January", "February", "March", "April", "May", "June",
                              "July", "August", "September", "October", "November", "December")

ggplot(data = surveys_dm,
       aes(x = weight)) +
  geom_histogram(binwidth = 2) +
  facet_wrap( ~ month) +
  labs(title = "DM weight distribution by month",
       x = "Count",
       y = "Weight (g)")


ggplot(data = surveys_dm,
       aes(x = weight)) +
  geom_histogram()+
  facet_wrap( ~ month) +
  geom_histogram(data = select(surveys_dm, -month)) +
  labs(title = "DM weight distribution by month",
       x = "Count",
       y = "Weight (g)") +
  guides(fill = FALSE)

## Exercise 3

...

