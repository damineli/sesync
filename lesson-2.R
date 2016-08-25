## Tidy data concept

counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20, 25, 30),
  fox = c(4, 4, 4)
)

## Reshaping multiple columns in category/value pairs

library(tidyr)
counts_gather <- gather(counts_df, 
                        key = "species", 
                        value = "count", 
                        wolf:fox)

counts_spread <- spread(counts_gather[-6, ], 
                        key = species, 
                        value = count,
                        fill = 0)

## Exercise 1

...

## Read comma-separated-value (CSV) files
surveys <- read.csv("data/surveys.csv", na.strings = "")
#str(surveys)
## Subsetting and sorting

library(dplyr)
surveys_1990_winter <- filter(surveys, 
                              year == 1990,
                              month %in% 1:3) # select rows

surveys_1990_winter <- select(surveys_1990_winter, -year) # selects columns

sorted <- arrange(surveys_1990_winter, desc(species_id), weight)

## Exercise 2

surveys_ex2 <- filter(surveys, 
                              species_id == "RO") # select rows

surveys_ex2 <- select(surveys_ex2, record_id, sex, weight) # selects columns


surveys_ex2_b <- select(filter(surveys, species_id == "RO"), record_id, sex, weight)

## Grouping and aggregation

surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id)

counts_1990_winter <- summarize(surveys_1990_winter_gb, count = n())
#head(counts_1990_winter)
## Exercise 3

surveys_ex3 <- filter(surveys, 
                      species_id == "DM") # select rows

surveys_summ <- summarize(group_by(surveys_ex3 , month), average_weight = mean(weight,na.rm=T), average_foot = mean(hindfoot_length,na.rm=T))

#surveys_ex3 <- select(surveys_ex3, hindfoot_length, weight, month) # selects columns

#summary.dat <- summarize(group_by(surveys_ex3, month), average = mean(weight,na.rm=T))


## Transformation of variables

prop_1990_winter <- mutate(counts_1990_winter, prop = count / sum(count))

## Exercise 4


step_A <- filter(group_by(surveys_1990_winter, species_id), weight == min(weight, na.rm = TRUE)) 
#OR
min.weight <- summarize(group_by(surveys_1990_winter, species_id), min_weight = min(weight,na.rm = TRUE))

#######
#row_number gives you the RANK

hindfoot_rank <- mutate(group_by(surveys_1990_winter, species_id), rank = row_number(hindfoot_length))

## Chainning with pipes

prop_1990_winter_piped <- surveys %>%
  filter(year == 1990, month %in% 1:3) %>%
  select(-year) %>% # select all columns but year
  group_by(species_id) %>%# group by species_id
  summarize(count = n()) %>% # summarize with counts
  mutate(prop = count/sum(count)) # mutate into proportions
