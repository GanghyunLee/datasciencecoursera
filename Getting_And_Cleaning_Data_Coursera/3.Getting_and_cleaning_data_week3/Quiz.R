library(dplyr)

#############################################################
## Problem 1
#############################################################
print(" >> Problem1")
if(!file.exists("Problem1.csv")) download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "Problem1.csv")
data <- read.csv("Problem1.csv", stringsAsFactors = FALSE)
dataTbl <- tbl_df(data)
dataTbl <- mutate(dataTbl, agricultureLogical = (ACR == 3 & AGS == 6))

print(which(dataTbl$agricultureLogical)[1:3])

#############################################################
## Problem 2
#############################################################
print(" >> Problem2")
if(!file.exists("Problem2.jpg")) download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "Problem2.jpg", mode = "wb")
data <- jpeg::readJPEG(source = "Problem2.jpg", native = TRUE)

print(quantile(data, probs = c(0.3, 0.8)))

#############################################################
## Problem 3
#############################################################
print(" >> Problem3")
if(!file.exists("Problem3_GDP.csv")) download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "Problem3_GDP.csv")
if(!file.exists("Problem3_COUNTRY.csv")) download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "Problem3_COUNTRY.csv")

dataGDP <- read.csv("Problem3_GDP.csv", stringsAsFactors = FALSE, skip=4, nrows = 190)
dataGDP <- dataGDP[dataGDP$X != "",]
dataCOUNTRY <- read.csv("Problem3_COUNTRY.csv", stringsAsFactors = FALSE)
data <- merge(dataGDP, dataCOUNTRY, by.x = "X", by.y = "CountryCode")
print(dim(data)[1])

data <- tbl_df(data)
data <- arrange(data, desc(X.1))
print(data[13,]$X.3)

#############################################################
## Problem 4
#############################################################
print(" >> Problem4")
data_incomeGrouped <- group_by(data, Income.Group)
print(dplyr::summarize(data_incomeGrouped, avgGDP_Rank = mean(X.1)))

#############################################################
## Problem 5
#############################################################
print(" >> Problem5")
library(Hmisc)
data$RankGroup <- cut2(data$X.1, g = 5)
print(table(data$Income.Group, data$RankGroup))