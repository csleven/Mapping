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
library(rmarkdown)
library(knitr)
library(reshape)


install.packages("maptools")
install.packages("ggplot2")
install.packages("ggmap")
devtools::install_github("rstudio/rmarkdown")
install.packages("knitr")
install.packages("reshape")

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
setwd("~/Desktop/Work with Amy/Mapping/Distributions/")
FILES <- list.files( pattern = ".txt")

for (i in 1:length(FILES)) {
  FILE=read.table(file=FILES[i],header=TRUE, fill = TRUE)
  write.csv(FILE,file=paste0("~/Desktop/Work with Amy/Mapping/",
                             sub(".txt","",FILES[i]),".csv"))
}

##Bring All Distribution Files Into R
path <- "~/Desktop/Work with Amy/Mapping/Distributions2/"
files <- list.files(path=path, pattern="*.csv")
for(file in files)
{
  perpos <- which(strsplit(file, "")[[1]]==".")
  assign(
    gsub(" ","",substr(file, 1, perpos-1)), 
    read.csv(paste(path,file,sep="")))
}

##Does this work with .txt files?
setwd("~/Desktop/Work with Amy/Mapping/Distributions/")
path <- "~/Desktop/Work with Amy/Mapping/Distributions/"
files <- list.files(path=path, pattern="*.txt")   
for(i in files) {
  x <- read.table(i, header = TRUE,   
                  sep = "\t", fill = TRUE, quote = "")
  assign(i,x)  
}


### Histograms of Distributions
qplot(Abies_amabilis$year, stat="count", geom="histogram")

ggplot(data=Abies_amabilis, aes(Abies_amabilis$year)) + geom_histogram()

##Try with just Abies_amabilis .txt files
setwd("~/Desktop/Work with Amy/Mapping/Distributions/")
Abies_amabilis <-read.table("Abies_amabilis.txt", header = TRUE,   
                             sep = "\t", fill = TRUE, quote = "")
## sep = "/t" and fill = TRUE seem to have gotten rid of my problem
## of more columns than column headers

is.numeric(Abies_amabilis$year)
##It is! 
qplot(Abies_amabilis.txt$year, geom="histogram", binwidth="10")
## This one plots and I can work out how to change bin width.
## Some of the years are definitely incorrect though...
ggplot(data=Abies_amabilis.txt, 
       aes(Abies_amabilis.txt$year)) + geom_histogram(binwidth = 10)
## This also works

##Try with Abies_lasiocarpa which is larger file
Abies_lasiocarpa <-read.table("Abies_lasiocarpa.txt", header = TRUE,   
                            sep = "\t", fill = TRUE, quote = "")
is.numeric(Abies_lasiocarpa$year)
ggplot(data=Abies_lasiocarpa, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)
##okay, this also allows me to differentiate between ones with/without
## coordinates. Though it does it based on what the latitude is, not
## just whether or not there is a latitude

##For Abies amabilis this looks like this:
ggplot(data=Abies_amabilis.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

##...this is going to take a while by hand....

##Abies amabilis map with distribution
abieamab <- readShapePoly("abieamab.shp") 
map(database="world", ylim=c(30, 60), xlim=c(-140, -100), fill= TRUE, 
    col="gray90")
plot(abieamab, add=TRUE, xlim=c(-140,-110),ylim=c(48,64), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Abies_amabilis.txt$decimalLongitude, Abies_amabilis.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)
##THIS WORKS! And I think probably has to be done by hand because distributions
## vary so much that to scale in right is hard

##Also this might only work for the trees

## Abies lasiocarpa
ggplot(data=Abies_lasiocarpa.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

abielasi <- readShapePoly("abielasi.shp") 
map(database="world", ylim=c(30, 70), xlim=c(-150, -100), fill= TRUE, 
    col="gray90")
plot(abielasi, add=TRUE, xlim=c(-140,-110),ylim=c(48,64), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Abies_lasiocarpa.txt$decimalLongitude, Abies_lasiocarpa.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)

## Abies procera
ggplot(data=Abies_procera.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

abieproc <- readShapePoly("abieproc.shp") 
map(database="world", ylim=c(30, 70), xlim=c(-140, -100), fill= TRUE, 
    col="gray90")
plot(abieproc, add=TRUE, xlim=c(-140,-110),ylim=c(-50,85), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Abies_lasiocarpa.txt$decimalLongitude, Abies_lasiocarpa.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)

## Acer circinatum
ggplot(data=Acer_circinatum.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

acercirc <- readShapePoly("acercirc.shp") 
map(database="world", ylim=c(38, 52), xlim=c(-130, -118), fill= TRUE, 
    col="gray90")
plot(acercirc, add=TRUE, xlim=c(-140,-110),ylim=c(-50,85), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Acer_circinatum.txt$decimalLongitude, Acer_circinatum.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)

## Alnus rubra
ggplot(data=Alnus_rubra.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

alnurubr <- readShapePoly("alnurubr.shp") 
map(database="world", ylim=c(20, 60), xlim=c(-140, -115), fill= TRUE, 
    col="gray90")
plot(alnurubr, add=TRUE, xlim=c(-140,-120),ylim=c(20,60), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Alnus_rubra.txt$decimalLongitude, Alnus_rubra.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)
 
## Amelanchier alnifolia
ggplot(data=Amelanchier_alnifolia.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

amelalni <- readShapePoly("amelalni.shp") 
map(database="world", ylim=c(33, 85), xlim=c(-160, -70), fill= TRUE, 
    col="gray90")
plot(amelalni, add=TRUE, xlim=c(-140,-120),ylim=c(20,60), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Amelanchier_alnifolia.txt$decimalLongitude, Amelanchier_alnifolia.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)

#### Chamaecyparis nootkatensis
ggplot(data=Chamaecyparis_nootkatensis.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

chamnoot <- readShapePoly("chamnoot.shp") 
map(database="world", ylim=c(38, 61), xlim=c(-150, -104), fill= TRUE, 
    col="gray90")
plot(chamnoot, add=TRUE, xlim=c(-140,-120),ylim=c(20,60), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Chamaecyparis_nootkatensis.txt$decimalLongitude, Chamaecyparis_nootkatensis.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)

## Cornus nuttallii
ggplot(data=Cornus_nuttallii.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

cornnutt <- readShapePoly("cornnutt.shp") 
map(database="world", ylim=c(33, 53), xlim=c(-130, -112), fill= TRUE, 
    col="gray90")
plot(cornnutt, add=TRUE, xlim=c(-140,-120),ylim=c(10,55), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Cornus_nuttallii.txt$decimalLongitude, Cornus_nuttallii.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)

## Cornus sericea
ggplot(data=Cornus_sericea.txt, 
       aes(x = year, group = decimalLatitude, 
           fill = decimalLatitude)) + geom_histogram(binwidth = 10)

cornstol <- readShapePoly("cornstol.shp") 
map(database="world", ylim=c(33, 70), xlim=c(-160, -50), fill= TRUE, 
    col="gray90")
plot(cornstol, add=TRUE, xlim=c(-140,-120),ylim=c(10,55), 
     col=alpha("darkgreen", 0.6), border=FALSE)
points(Cornus_sericea.txt$decimalLongitude, Cornus_sericea.txt$decimalLatitude, pch=19,
       col="red", cex=0.3)
