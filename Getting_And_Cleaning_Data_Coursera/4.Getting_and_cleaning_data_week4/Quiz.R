########################################################################
### Problem 1
########################################################################
print(">> Problem 1")
if(!file.exists("Problem1.csv"))
{
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "Problem1.csv")  
}
readData <- read.csv("Problem1.csv")
print(strsplit(names(readData), "wgtp")[[123]])

########################################################################
### Problem 2
########################################################################
print(">> Problem 2")
if(!file.exists("Problem2.csv"))
{
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "Problem2.csv")
        
}
readData <- read.csv("Problem2.csv", skip=4, nrows=190)
readData$X.4 <- gsub(",", "", readData$X.4)
readData$X.4 <- as.numeric(readData$X.4)
print(mean(readData$X.4))

########################################################################
### Problem 3
########################################################################
print(">> Problem 3")
print(length(grep("^United", readData$X.3)))

rm("readData")

########################################################################
### Problem 4
########################################################################
print(">> Problem 4")

if(!file.exists("Problem4_GDP.csv"))
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "Problem4_GDP.csv")
if(!file.exists("Problem4_EDU.csv"))
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "Problem4_EDU.csv")

readDataGDP <- read.csv("Problem4_GDP.csv", skip=4, nrows=190)
readDataEDU <- read.csv("Problem4_EDU.csv")

readDataGDP <- readDataGDP[,colSums(!is.na(readDataGDP)) > 0]           # Remove all NA col
colnames(readDataGDP) <- c("CountryCode", "Rank", "Country", "GDP")     # Change colnames

mergedData <- merge(readDataGDP, readDataEDU)
rm("readDataGDP")
rm("readDataEDU")

print(length(grep("[Ff]iscal year end: [Jj]une", mergedData$Special.Notes)))

########################################################################
### Problem 5 - # it doesn't work
########################################################################
library(quantmod)
amzn = getSymbols("AMZN", src = "google")
sampleTimes = index(amzn)