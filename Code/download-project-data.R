
### Download Project Data
### Blaine Jenkins
### 11/27/2023

## Load Libraries
library(tidycensus)
library(tidyverse)
library(sf)
library(tigris)


## Get Census API key
census_api_key("1e97254fb99e83423df8bba73aa5998cb193c006")

## Download 2013 Data on median household income, median total house value,
## total pop, and total housing units
acs21 <- get_acs(geography= "tract",
                 variables = c("B25099_001","B25097_001"),
                 state = "MA",
                 county = "Suffolk County",
                 year = 2021,
                 output = "wide",
                 geometry = TRUE)


## Save Data in Raw_Data folder
write_sf(acs21, "../Raw_Data/acs21.gpkg")


## Download National Risk Index Data
download.file("https://hazards.fema.gov/nri/Content/StaticDocuments/DataDownload//NRI_Table_CensusTracts/NRI_Table_CensusTracts_Massachusetts.zip",
              destfile = "../Raw_Data/NRI_Table_CensusTracts_Massachusetts.zip")

# Unzip file
unzip("../Raw_Data/NRI_Table_CensusTracts_Massachusetts.zip",
      exdir = "../Raw_Data/")
