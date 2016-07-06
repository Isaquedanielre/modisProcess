#source('http://r-gis.net/ModisDownload/ModisDownload.R')
source('ModisDownload.R')


MRT_DIR='C:/MODIS_MRT/'
MRT_bin_DIR <- paste(MRT_DIR,'bin/',sep='')

Sys.setenv(MRT_DATA_DIR  = paste(MRT_DIR,'data',sep = ''))


modisReprojectAll <- function(inoutDir, projType = "SIN", projDatum = 'NoDatum', projUTMtzone=NULL, projParam = 6371007.181, PIXEL_SIZE=NA){
  #1000m : 926.6254331
  #500m: 463.3127165
  #250: 231.65635825
  wd <- getwd()
  setwd(inoutDir)
  
  files <- dir( pattern = '*.hdf$')
  for (filename in files){
    reprojectHDF(filename, paste(inoutDir, filename,'.tif',sep=''), MRT_bin_DIR, proj_type=projType, datum=projDatum, utm_zone=NULL, proj_params= projParam, pixel_size=PIXEL_SIZE)
  }
  setwd(wd)
}


modisReprojectAllFolders <- function(PATH, projType = "SIN", projDatum = 'NoDatum', projUTMtzone=NULL, projParam = 6371007.181){
  folders <- dir(PATH)
  for (folder in folders){
    modisReprojectAll(inoutDir = folder)
  }
  
}


modisExtractTimeSeries <- function(folder, spatialCoord, bandName){
  ls <- dir(folder,pattern = '*.tif')
  images <- ls[grep(bandName, ls)]
  
  nt <- length(images)
  
  timeSeries <- matrix(NA, nrow = nt, ncol = dim(spatialCoord)[1])
  time <- matrix(NA, nrow = nt, ncol = 2)
  
  prog <- txtProgressBar(min = 0, max = nt, style = 3)
  
  for(i in 1:nt){
    x <- raster(paste( folder, images[i], sep = ''))
    time[i,] <- as.numeric(substring(strsplit(images[i],"\\.")[[1]][2],c(2,6),c(5,8)))
    timeSeries[i,] <- extract(x, spatialCoord)
    setTxtProgressBar(prog, i)    
  }
  list(time=time, timeSeries=timeSeries)
}
