# Example for Jags-Ymet-XmetMulti-Mrobust.R 
#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.

myData <- read.csv("Assignment2PropertyPrices.csv")
yName <- "SalePrice"
xName <- c("Area",	"Bedrooms",	"Bathrooms", 	"CarParks",  	"PropertyType")
fileNameRoot <- "Assn2"
numSavedSteps <- 1000 ;
thinSteps <- 10

graphFileType = "eps" 
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Jags-Ymet-XmetMulti-Mrobust-Assn2.R")
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:

mcmcCoda = genMCMC( data=myData , xName=xName , yName=yName, 
                    numSavedSteps = numSavedSteps , thinSteps=thinSteps ,
                    saveName=fileNameRoot)


#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names
for ( parName in parameterNames ) {
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
            saveName=fileNameRoot , saveType=graphFileType )
}
graphics.off()
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:

summaryInfo = smryMCMC( mcmcCoda , 
                        saveName=fileNameRoot  )
show(summaryInfo)
# Display posterior information:
plotMCMC( mcmcCoda , data=myData , xName=xName , yName=yName , 
          pairsPlot=TRUE , showCurve=FALSE ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 

beep(2)