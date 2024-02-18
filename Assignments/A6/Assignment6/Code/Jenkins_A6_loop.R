####
#### R script to implement loop
#### for GEOG 215, Assignment #6
####

#### The files contain the number of cellular devices 
#### detected and the number that stayed at home for the full
#### 24 hour period over a number of days in North Carolina
#### (by block group of residence)

## Load required libraries
library(tidyverse)

## Get a list of the files
## Note the contents and the filepath!
safegraph_files <- list.files("../Data",
                              full.names = TRUE)

## Create holder for data
data_holder <- tibble(DATE = rep(NA, length(safegraph_files)),
                      DEV = rep(NA, length(safegraph_files)),
                      COMPHOME = rep(NA, length(safegraph_files)))

## Start loop here
## Use i for the iterator!
## Iterate from 1 to the number of files in Data
##   see loop exercise

for (i in 1 : length(safegraph_files)) {
  ## Read file here using read_csv()
  dat <- read_csv(paste0(safegraph_files[i]),
                  show_col_types = FALSE)

  ## Get the date from the filename and put in holder
  data_holder$DATE[i] <- str_sub(safegraph_files[i], 30, 39)
  
  ## Get the sum of devices (DEV) and put in holder
  data_holder$DEV[i] <- sum(dat$DEV, na.rm = TRUE)
  
  ## Get the sum of devices that stayed completely home (COMPHOME)
  ## and put in holder
  data_holder$COMPHOME[i] <- sum(dat$COMPHOME, na.rm = TRUE)
}

## This is the end of the loop...
## Make sure to end the loop with a bracket!  


    
## Convert DATE column to date format
data_holder <- data_holder |>
    mutate(DATE = as.Date(DATE))

## For extra credit, use ggplot to create a line plot of the
## PERCENT OF DEVICES STAYING COMPLETELY HOME over the
## time series for North Carolina... and write out as a
## .png file using ggsave()

data_holder <- data_holder |>
  mutate(PER_DEV_COMPHOME = COMPHOME / DEV * 100)

data_holder |>
  ggplot(mapping = aes(x = DATE, 
                       y = PER_DEV_COMPHOME)) + 
  geom_line(color = 'dark green') + 
  labs(title = "Percent of Devices Staying Completely Home",
       subtitle = "North Carolina (block groups)",
       x = "Date",
       y = "Percent Devices") +
  ggsave("Jenkins_A6_EC.png",
         height = 5,
         width = 3,
         units = "in")
