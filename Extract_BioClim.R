########################
#for more info, check the "dismo" package tutorial
#Adapted from Caroline Curtis
#12-Sep-2016
#Use this code to make 19 bioclim variables from PRISM's monthly climate data
#######################


####################################
#load required libraries
library(dismo)
library(rgdal)
library(sp)


#set the working directory. Change this according to where your file location
setwd("~/Dropbox/Insight/Data/Clim")
#####################################

####################################

#for each of the 3 climate variables, load all 12 months and turn them into a raster stack
#this creates a single RasterStack from the 12 files

# The filenames include a zero digit at the beginning, so make a string for that
monthzerodig <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
# These stacks are just for the year 2000
# Will have to re-run separately for all other years
tmin<-stack(paste(getwd(),"/TempMin/PRISM_tmin_stable_4kmM2_2000", monthzerodig, "_bil", ".bil", sep=""))
tmax<-stack(paste(getwd(),"/TempMax/PRISM_tmax_stable_4kmM2_2000", monthzerodig, "_bil", ".bil", sep=""))
ppt<-stack(paste(getwd(),"/Precip/PRISM_ppt_stable_4kmM3_2000", monthzerodig, "_bil", ".bil", sep=""))




#name the new 19 layer Rasterbrick (x) and use the function "biovars" to combine the 3 sets of climate data
#this will take a while.  longer for larger areas.
x<-biovars(prec=ppt,tmin=tmin,tmax=tmax)
# Took about 4 minutes to run

#check that your new layer (x) contains all 19 layers, has the correct dimensions, etc.
names(x)
plot(x)
plot(x$bio1) #use this view each layer individually

#save the bioclim rasterbrick
DaymetBioclim <- writeRaster(x, "bioclm_daymet.tif", format='GTiff')
plot(DaymetBioclim$bio1)
