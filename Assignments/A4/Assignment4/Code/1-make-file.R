####
#### Assignment #4, GEOG215
#### Introduction to Spatial Data Science
####
#### R code to automate the preparation,
####   analysis, and presentation
####
#### Blaine Jenkins
#### `r format(Sys.Date(), "%B %d, %Y")`
####

## First step
## Read and execute Data Prep Code, GEOG215-data-prep.R
source("GEOG215-data-prep.R")

## Second step
## Read and execute Data Analysis Code, GEOG215-data-analysis
source("GEOG215-data-analysis.R")

## Third step
## Knit your R Markdown file
rmarkdown::render("GEOG215-data-presentation.Rmd",
                  output_file = "GEOG215-data-presentation-auto-v2.html")

                  