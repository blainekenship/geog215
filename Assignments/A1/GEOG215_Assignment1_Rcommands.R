######################################################
### GEOG 215: Introduction to Spatial Data Science
### Paul L Delamater
### Assignment #1
######################################################

#' In an R script, lines that begin with the # character are not 
#' executed (they are called comments). Comments are one of the 
#' easiest ways for you to keep track of what your code does. 
#' Commenting your code is essential for effective use of R code. 
#' And, it is a required part of GEOG 215, because this will be 
#' one of the ways that you assist Dr. D in understanding your 
#' processing and analysis steps.

#' Remove any objects in the working environment that may be from 
#' other code. If you're working on multiple scripts in one RStudio 
#' session, you might want to do this at the beginning of your code.
rm(list = ls())

#' The above command can be emulated in RStudio by clicking the small 
#' "broom" button in the Environment window.


## Get the current working directory
getwd()

##
## Below, set the working directory to where 
## GEOG215-Assignment1_Rcommands.R is stored on your
## computer
##

#' Note: below is the working directory location on my computer. 
#' You MUST change this filepath to where the file is stored on 
#' your computer or the command will return an error!
setwd("C://Users/Blaine/Desktop/GEOG215/A1/")


## Read in a data table from a .csv file. This table contains the 
## number of marriages by NC county and by month in the year 2018. 
## Counties are the observation units.
nc_mar <- read.csv("nc_marriages_cnty_2018.csv")

#' Note that the file nc_marriages_cnty_2018.csv shouldvbe located 
#' in the present working directory. If a file is located outside 
#' your present working directory, you can point directly to it 
#' using its absolute filepath


## If the first column in nc.mar is named ï..COUNTY instead of COUNTY
## Uncomment and run this line of code!
## This was an issue on some Windows computers in the past
# nc.mar <- read.csv("nc_marriages_cnty_2018.csv", fileEncoding="UTF-8-BOM")


## Get information about nc_mar (note that you can use comments 
## at the end of a line of R code)
str(nc_mar)     # here's a comment!
dim(nc_mar)     # here is another
head(nc_mar)    # print first six rows
tail(nc_mar)    # print last six rows

## Some metadata about this file
##   Each row is a county in North Carolina
##   The entries are number of marriages by county of 
##     occurrence in 2018
##   TOTAL is for the entire year and the other 
##.    columns contain the number each month

##
## Below are some basic subsetting/indexing commands
## when working with data frames in R, Please take a
## moment to really "see" what is happening when you
## run the next few commands, as you WILL HAVE TO know
## how to access portions of your data to do well in
## this course.
##

# Print the first row to the console
nc_mar[1,]

# Print the first column to the console
nc_mar[,1]

# Print the first two rows to the console
nc_mar[1:2,]

# Print rows 12 and 46 to the console
nc_mar[c(12,46),]

# Print the first column, using the column name, to the console
nc_mar$COUNTY

# Print the first five rows and columns to the console
nc_mar[1:5, 1:5]


##
## Here are some basic summary and arithmetic functions
##

# Mean of one column in a dataframe (print to console)
mean(nc_mar$TOTAL)
mean(nc_mar[,2]) # Why the same as previous command?

# Mean of all columns (except "COUNTY"), print to console
colMeans(nc_mar[,-1])

# Sum of all columns (except "COUNTY"), print to console
colSums(nc_mar[,-1])

# For example, to get the Sum of all marriages in 2018
sum(nc_mar$TOTAL)

# Sum of the "monthly" columns only
monthly_sums <- colSums(nc_mar[,-c(1:2)])  

## Notice that the result wasn't printed in the console?
## Hmmmm... why do you think that is?

# Print the output of the previous command
monthly_sums #or
print(monthly_sums)

# Find the maximum value
max(monthly_sums)

# Basic arithmetic on one column
nc_mar$TOTAL / 12
# Will divide each value in the column by 12
# This is the average number of marriages per
# month for each county

# Calculate the monthly average and write it as
# a new column in the data frame
nc_mar$MONTH_AVE <- nc_mar$TOTAL / 12


##
## Here are some basic PLOT functions
##

# Basic histogram for October
hist(nc_mar$OCT)

# Scatterplot
plot(nc_mar$JAN, nc_mar$OCT)  # order is X axis, Y axis


###
### Question 4: Write a single command that provides the answer 
### to the following question
###
### How many marriages took place in North Carolina in July, 2018?
monthly_sums[7]
            


###
### Question 5: Provide the command to create a histogram of 
### the total number of marriages
###            
hist(nc_mar$TOTAL)

###
### Question 6: Write a single command that provides the answer 
### to the following question
###
### What was the maximum number of marriages in August, 2018?
### 
max(nc_mar$AUG)

###
### Question 7: Write a single command that adds a new column 
### named MARRIEDPOP to the nc_mar data frame with the calculated 
### number of people who were married in 2018 (assuming 2 people
### per marriage).
###

nc_mar$MARRIEDPOP <- nc_mar$TOTAL * 2

