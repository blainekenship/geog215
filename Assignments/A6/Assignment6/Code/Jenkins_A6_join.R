####
#### R script to perform a table join and create a map
#### for GEOG 215, Assignment #6
####


## Load required libraries
library(tidyverse)
library(sf)
library(tmap)

#### Read geojson data directly as sf object
#### Big-ish file... might take a minute to retrieve
nc_bg_polys <- read_sf("https://opendata.arcgis.com/datasets/7d3c48062ffc4cf781835bfa530497e4_8.geojson")

# Remove block groups with 0 population
nc_bg_polys <- nc_bg_polys |>
  filter(total_pop > 0)

#### Read Stay at Home data for 4/16
nc_SAT <- read_csv("../Data/Safegraph_StayAtHome_2021-04-16.csv")

#### Calculate Stay at Home percent
nc_SAT <- nc_SAT |>
  mutate(COMPHOME_PCT = 100 * COMPHOME / DEV)


####
#### Join attributes of nc_SAT to nc_bg_polys
####
#### Use   left_join()
####

# Convert GEOID to characters
nc_SAT <- nc_SAT |>
  mutate('GEOID2' = as.character(GEOID))

# Left join
nc_bg_polys <- left_join(nc_bg_polys, nc_SAT,
                         by = c("geoid10" = "GEOID2"))


####
#### Create a choropleth map of the percent of all
#### people staying home, using the COMPHOME_PCT column
#### using tmap
####
####  Because block groups are very small, we will not display
####  the lines of their boundaries
####     In    tm_polygons() 
####     Use   lwd = 0               (set polygon border width to 0)
####     Use   border.alpha = 0      (set polygon border to fully transparent)
####

tm_shape(nc_bg_polys) + 
  tm_polygons("COMPHOME_PCT", 
              style = "jenks", 
              palette = "YlOrRd",
              border.alpha = 0,
              lwd = 0)

####
#### Export (save) your map
#### See https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html#exporting-maps
####
#### Save file as Lastname_A6_join_map.png  (using your last name)
####

tm_shape(nc_bg_polys) + 
  tm_polygons("COMPHOME_PCT", 
              style = "jenks", 
              palette = "YlOrRd",
              border.alpha = 0,
              lwd = 0) +
  tmap_save(filename = "Jenkins_A6_join_map.png",
            height = 2,
            width = 5)
