####
#### Assignment #4, GEOG215
#### Introduction to Spatial Data Science
####
#### R code for data preparation
####   Imports, fixes, cleans raw data
####
#### Blaine Jenkins
#### October 22, 2023
####

#############################                      
####  Load libraries  

library(sf)
library(tidyverse)
library(rmapshaper)
library(readxl)

#############################


#############################      
####  Read in data  

# Read in North Carolina Zip Code spatial data layer
nc_zip <- read_sf("../Data/sp/NC_ZIP_2020.shp")

# Read in North Carolina population data
nc_zip_pop <- read_excel("../Data/tabular/Population data.xlsx")

# Read in North Carolina COVID data
nc_zip_cvd <- read_csv("../Data/tabular/NC_COVID_2020-09-23_ZIP.csv")

#############################   


#############################
####  Process data  

# Simplify geometry of Zip Code spatial data layer
# for mapping purposes
nc_zip <- nc_zip |>
  as("Spatial") |>
  ms_simplify() |>
  st_as_sf()

# Make spatial data layer valid (just a good habit using sf objects
# that were downloaded from the internet)
nc_zip <- nc_zip |>
  st_make_valid()

# Keep only zip code and pop name columns to isolate for analysis
nc_zip <- nc_zip |>
  select(ZIP_CODE, PO_NAME)

# Write out spatial data layer
write_sf(nc_zip, 
         "../Output/NC_ZIP_2020_mapping.gpkg")

# Make the column names more readable for presentation
nc_zip_pop <- nc_zip_pop |>
  rename(ZIPCODE = `Zip Code`,
         POP = `Zip Code Population Estimate 2020`)

# Keep only relevant columns (object Id and name are unhelpful)
nc_zip_cvd <- nc_zip_cvd |>
  select(`ZIP CODE`, `COVID-19 CASES`, `COVID-19 DEATHS`)

# Rename to match naming conventions of nc_zip_pop for joining
nc_zip_cvd <- nc_zip_cvd |>
  rename(ZIPCODE = `ZIP CODE`,
         CASES = `COVID-19 CASES`,
         DEATHS = `COVID-19 DEATHS`)

# Join nc_zip_cvd to nc_zip_pop by the zipcode field to easily write it out
nc_zip_cvd_pop <- left_join(nc_zip_pop,
                            nc_zip_cvd,
                            by = "ZIPCODE")

############################# 


############################# 
####  Write out results  ----

# Write out tabular data
write_csv(nc_zip_cvd_pop, 
          "../Output/NC_ZIP_COVID_POP_2020-09-23.csv")
#############################
