problem <- 4

if(problem == 1) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "Prob1.csv")
        data <- read.csv("Prob1.csv")
        data <- data$VAL[complete.cases(data$VAL)]
        print(length(which(data == 24)))
} else if(problem == 2) {
        library(xlsx)
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "Prob2.xlsx", method="curl")
        
        rowIndex <- 18:23
        colIndex <- 7:15
        dat <- read.xlsx("Prob2.xlsx", sheetIndex=1, rowIndex=rowIndex, colIndex=colIndex)
        print(sum(dat$Zip*dat$Ext,na.rm=T))
} else if(problem == 3)
{
        library(XML)
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "Prob3.xml", method="curl")
        
        data <- xmlTreeParse("Prob3.xml", useInternal=TRUE)
        rootNode <- xmlRoot(data)
 
        data <- xpathSApply(rootNode, "//zipcode", xmlValue)
        print(length(which(data == "21231")))
} else if(problem == 4)
{
        library(data.table)
        
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "Prob4.csv")
        DT <- fread("Prob4.csv")
        
        n <- 1000
        print(system.time(replicate(n, mean(DT[DT$SEX==1,]$pwgtp15))))
        print(system.time(replicate(n, mean(DT[DT$SEX==2,]$pwgtp15))))
        print(system.time(replicate(n, DT[,mean(pwgtp15),by=SEX])))
        print(system.time(replicate(n, sapply(split(DT$pwgtp15,DT$SEX),mean))))
        print(system.time(replicate(n, mean(DT$pwgtp15,by=DT$SEX))))
}