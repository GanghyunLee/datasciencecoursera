pollutantmean <- function(directory, pollutant, id = 1:332)
{
        mainData <- c()
        fileList <- list.files(paste("./", directory, sep=""))

        for (i in id)
        {
                targetFile <- paste("./", directory, "/", fileList[i], sep="")
                data <- read.csv(targetFile)
                notNA <- !is.na(data[[pollutant]])
                mainData <- c(mainData,data[[pollutant]][notNA])
        }
        mean(mainData)
}

##################################################################################################
complete <- function(directory, id=1:332)
{
        fileList <- list.files(paste("./", directory, sep=""))
        cnt <- 0
        mainData <- data.frame(id=integer(), nobs=integer())
        
        for (i in id)
        {
                targetFile <- paste("./", directory, "/", fileList[i], sep="")
                data <- read.csv(targetFile)
                data <- data[complete.cases(data), ]
                
                cnt <- cnt + 1
                mainData[cnt,] <- list(i, dim(data)[1]) #add data
        }
        
        mainData
}

##################################################################################################

corr <- function(directory, threshold = 0)
{
        resultData <- c()
        
        availableData <- complete(directory)
        availableIdx <- availableData[["nobs"]] >= threshold
        
        fileList <- list.files(directory)
        fileList <- fileList[availableIdx]
        
        for (i in 1:length(fileList))
        {
                tempData <- read.csv(paste(directory, "/", fileList[i], sep=""))
                tempData <- tempData[complete.cases(tempData), ]
                
                resultData <- c(resultData, cor(tempData$sulfate, tempData$nitrate))
        }
        
        resultData
}