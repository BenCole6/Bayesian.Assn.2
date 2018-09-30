# Example for Jags-Ymet-XmetMulti-Mrobust.R 
#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.

myData <- read.csv("Assignment2PropertyPrices.csv")
yName <- "SalePrice"
xName <- c("Area",	"Bedrooms",	"Bathrooms", 	"CarParks",  	"PropertyType")
fileNameRoot <- "Assn2"
numSavedSteps <- 10000;
thinSteps <- 3

graphFileType = "eps" 
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Jags-Ymet-XmetMulti-Mrobust-Assn2.R")
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
Pred1 <- c(600,2,2,1,1)
Pred2 <- c(800,3,1,2,0)
Pred3 <- c(1500,2,1,1,0)
Pred4 <- c(2500,5,4,4,0)
Pred5 <- c(250,3,2,1,1)

mcmcCoda = genMCMC( data=myData , xName=xName , yName=yName, 
                    numSavedSteps = numSavedSteps , thinSteps=thinSteps ,
                    saveName=fileNameRoot,
                    Pred1=Pred1, Pred2=Pred2, Pred3=Pred3, Pred4=Pred4, Pred5=Pred5)


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
          pairsPlot=TRUE , showCurve=TRUE ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 

beep(8)