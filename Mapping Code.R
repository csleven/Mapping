##Using the Mapping Tutorial by Kimberly Gilbert

## Set Working Directory
setwd("~/Desktop/Work with Amy/Mapping")

##Open Libraries
library(maps)
library(mapdata)
library(maptools)
install.packages("maptools")

##Make a Simple Map
canada.cities 
map(database="world", region = "Canada", xlim=c(-141,-53), 
    ylim=c(40,85), fill = TRUE, col="gray90")
##Note: xlim = latitude, ylim = longitude

##Plotting Points on Map
#Open file with lat long data xs
species <-read.csv("Cornus canadensis.csv", stringsAsFactors = FALSE, strip.white = TRUE, 
                   na.strings = c("NA",""),h = T, as.is = T)
##This gives the worldwide distribution of Cornus canadensis!
##I feel like I probably need to run a loop for them all so I don't have to do them manually... 
##And probably start putting things into the DropBox as well
