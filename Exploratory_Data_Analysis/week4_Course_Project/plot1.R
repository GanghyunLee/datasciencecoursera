if(!("NEI" %in% ls())) NEI <- readRDS("./data/summarySCC_PM25.rds")
if(!("SCC" %in% ls())) SCC <- readRDS("./data/Source_Classification_Code.rds")

# Problem1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.
Problem1Data <- NEI

Problem1Data$year <- as.factor(Problem1Data$year)

totalPM2.5byYears <- tapply(Problem1Data$Emissions, Problem1Data$year, sum)

png("./plot1.png")

plot(y = totalPM2.5byYears, x = names(totalPM2.5byYears), type = "l", xlab = "Years", ylab = "Emissions(ton)", main = "Total emissions from PM2.5")
points(y = totalPM2.5byYears, x = names(totalPM2.5byYears))

dev.off()