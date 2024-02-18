####
#### Assignment #4, GEOG215
#### Introduction to Spatial Data Science
####
#### R code for data analysis and processing
####   Reads in data, makes some calculations,
####   and writes out data for presentation
####
#### Blaine Jenkins
#### October 22, 2023
####

#############################                      
####  Load libraries  ----

library(tidyverse)

#############################


#############################      
####  Read in data  ----

# Read in covid and population data created in prior script
nc_cvd_pop <- read_csv("../Output/NC_ZIP_COVID_POP_2020-09-23.csv")

# Read in reported Zip Code to Spatial Data Zip Code 
#  crosswalk table
nc_xwalk <- read_csv("../Data/tabular/ZIP_reportdata_map_crosswalk.csv")

#############################   


#############################
####  Process data  ----

# Join the covid/pop data with crosswalk table
nc_cvd_pop <- full_join(nc_cvd_pop, 
                        nc_xwalk, 
                        by = "ZIPCODE")

# Find the sum of the deaths, cases, and population for each zipcode
nc_cvd_pop_m <- nc_cvd_pop |>
  select(-ZIPCODE) |>
  group_by(ZIPCODEmap) |>
  summarize_all(sum, na.rm = TRUE)

# Calculate Cases and Deaths per 1000 people
nc_cvd_pop_m <- nc_cvd_pop_m |>
  mutate(CASERATE = 1000 * CASES / POP,
         DEATHRATE = 1000 * DEATHS / POP)

# Calculate the total sum of deaths, cases, and population to compare
nc_cvd_pop_state <- nc_cvd_pop |>
  select(-ZIPCODE, -ZIPCODEmap) |>
  summarize_all(sum, na.rm = TRUE)

# Calculate Cases and Deaths per 1000 people
nc_cvd_pop_state <- nc_cvd_pop_state |>
  mutate(CASERATE = 1000 * CASES / POP,
         DEATHRATE = 1000 * DEATHS / POP)

############################# 


############################# 
####  Write out results  

# Write out Zip Code table
write_csv(nc_cvd_pop_m, 
          "../Output/NC_ZIPmapping_COVID_POP_2020-09-23.csv")

# Write out State table
write_csv(nc_cvd_pop_state, 
          "../Output/NC_State_COVID_POP_2020-09-23.csv")

############################# 