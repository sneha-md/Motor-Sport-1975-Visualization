# Global ------------------------------------------------------------------

# Load packages
library(shiny)  # interactive app framework
library(shinydashboard)  # layout
library(DT)  # interactive table
library(dplyr)  # data manipulation
library(ICON)  # for icons
library(MPV)
library(plotly)
#library(semantic.dashboard)

# Read pre-prepared data
cardata <- table.b3

#Renaming the columns
names(cardata)[1] <- "mpg"
names(cardata)[2] <- "displacement"
names(cardata)[3] <- "horsepower"
names(cardata)[4] <- "torque"
names(cardata)[5] <- "compression ratio"
names(cardata)[6] <- "rear axle ratio"
names(cardata)[7] <- "carburetor"
names(cardata)[8] <- "transmission speeds"
names(cardata)[9] <- "overall length"
names(cardata)[10] <- "width"
names(cardata)[11] <- "weight"
names(cardata)[12] <- "transmission type"


# Classifying it into compact, midsize and full size cars
cardata$carvolume <- cardata$`overall length` * cardata$width


compact <- subset(cardata, cardata$carvolume <= 12780)
compact$cartype <- 'compact'

midsize <- subset(cardata, cardata$carvolume >= 12780 & cardata$carvolume <= 15595 )
midsize$cartype <- 'mid-size'

fullsize <- subset(cardata, cardata$carvolume >= 15596)
fullsize$cartype <- 'full-size'


sizedata <- rbind(compact,midsize,fullsize)
refer <- c(0,1)
values <- c('Manual','Automatic')
sizedata$transmissiontypetext <- values[match(sizedata$`transmission type`, refer)]  
sizedata


# Run ---------------------------------------------------------------------


shinyApp(ui,server)