
### Exam #2 Extra Credit
### Blaine Jenkins

# Load libraries
library(tidyverse)
library(tmap)
library(sf)
library(tigris)

#########################
### Download Data

# Dowload NC CAFO data from the web
nc_cafo_sp <- read_sf("https://services2.arcgis.com/kCu40SDxsCGcuUWO/arcgis/rest/services/Animal_Feed_Operation_Permits_(View)/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson")

# Download NC Zip Code Tabulation Areas
nc_zcta <- zctas(state = "NC", year = 2010)


#########################
### Wrangle Data

# Reproject cafo data for a crs specific to NC
nc_cafo_sp <- nc_cafo_sp |>
  st_transform("EPSG:2264")

# Reproject zcta data to match the cafo crs
nc_zcta <- nc_zcta |>
  st_transform("EPSG:2264")

# Spatial join cafo data to the zctas
nc_cafo_zcta <- st_join(nc_zcta, nc_cafo_sp)

# Subset to the zcta and total live weight of cafos
nc_cafo_zcta <- nc_cafo_zcta |>
  select(ALAND10, TOTAL_LIVE_WEIGHT)

# Aggregate and summarise data
nc_cafo_zcta <- nc_cafo_zcta |>
  group_by(ALAND10) |>
  summarise(TOTAL_WEIGHT = sum(TOTAL_LIVE_WEIGHT, na.rm = TRUE))


#########################
### Make the Map

tm_shape(nc_cafo_zcta) +
  tm_polygons("TOTAL_WEIGHT",
              border.alpha = 0.2,
              style = "jenks",
              palette = "Greens",
              title = "Weight of CAFOs in NC")
