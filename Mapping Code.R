##Using the Mapping Tutorial by Kimberly Gilbert

## Set Working Directory
setwd("~/Desktop/Work with Amy/Mapping")

##Open Libraries
library(maps)
# maps v3.1: updated 'world': all lakes moved to separate new #
# 'lakes' database. Type '?world' or 'news(package="maps")'.  #
library(mapdata)
library(maptools)
library(ggplot2)
library(ggmap) 
##Please cite ggmap if you use it: see citation('ggmap') for details.


install.packages("maptools")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("r.markdown")

##Make a Simple Map
canada.cities 
map(database="world", region = "Canada", xlim=c(-141,-53), 
    ylim=c(40,85), fill = TRUE, col="gray90")
##Note: xlim = latitude, ylim = longitude

##Plotting Points on Map
#Open file with lat long data xs
Ccan <-read.csv("Cornus canadensis.csv", stringsAsFactors = FALSE, strip.white = TRUE, 
                   na.strings = c("NA",""),h = T, as.is = T)

map(database="world", ylim=c(24, 85), xlim=c(-180, -50), fill= TRUE, 
    col="gray90")
points(Ccan$decimalLongitude, Ccan$decimalLatitude, pch=19,
       col="red", cex=0.3)

##Convert .txt files to .csv
setwd("~/Desktop/Work with Amy/Mapping/Distributions")
FILES <- list.files( pattern = ".txt")

for (i in 1:length(FILES)) {
  FILE=read.table(file=FILES[i],header=TRUE, fill = TRUE)
  write.csv(FILE,file=paste0("~/Desktop/Work with Amy/Mapping/Distributions",sub(".txt","",FILES[i]),".csv"))
}

##Bring All Distribution Files Into R
setwd("~/Desktop/Work with Amy/Mapping/Distributions")
Abies.amabilis <- read.table("Abies.amabilis.txt",
                 header = TRUE , fill = TRUE)


##Turn year into numeric factor
Abies.amabilis$year 

### Histograms of Distributions
ggplot(data=Abies.amabilis, aes(xAbies.amabilis$year) + geom_histogram)

qplot(Abies.amabilis$year, geom="histogram")

ggplot(data = Abies.amabilis,aes(x=year))+
  geom_histogram()

ggplot(Abies.amabilis, aes(x=year, fill = decimalLatitude)) +
  geom_histogram(binwidth = 0.5) +
  xlab("Year") +
  ylab("Total count") +
  labs(fill = "Coordinates")
