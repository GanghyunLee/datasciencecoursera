if(!("NEI" %in% ls())) NEI <- readRDS("./data/summarySCC_PM25.rds")
if(!("SCC" %in% ls())) SCC <- readRDS("./data/Source_Classification_Code.rds")

# Problem3) Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

Problem2Data <- subset(NEI, fips == "24510")

Problem2Data$year <- as.factor(Problem2Data$year)

totalPM2.5byYears <- tapply(Problem2Data$Emissions, Problem2Data$year, sum)

png("./plot2.png")

plot(y = totalPM2.5byYears, x = names(totalPM2.5byYears), type = "l", xlab = "Years", ylab = "Emissions(ton)", main = "Total emissions from PM2.5(Baltimore City)")
points(y = totalPM2.5byYears, x = names(totalPM2.5byYears))
     
dev.off()