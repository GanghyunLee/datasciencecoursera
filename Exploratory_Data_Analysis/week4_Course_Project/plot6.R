if(!("NEI" %in% ls())) NEI <- readRDS("./data/summarySCC_PM25.rds")
if(!("SCC" %in% ls())) SCC <- readRDS("./data/Source_Classification_Code.rds")

# Problem 6) Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County(fips == "24510"), 
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

Problem6Data <- subset(NEI, fips == "24510" | fips == "06037")            # in Baltimore City, Los Angeles
MotorVehicleData <- SCC[grepl("vehicles", SCC$EI.Sector, ignore.case=TRUE),]
Problem6Data <- subset(Problem6Data, Problem6Data$SCC %in% MotorVehicleData$SCC)

Problem6Data <- aggregate(Emissions ~ year + fips, Problem6Data, FUN = sum)
Problem6Data$fips <- factor(Problem6Data$fips, labels=c("Los.Angeles", "Baltimore"))

# calc changes over time in motor vehicle emissions
calcDiff <- tapply(Problem6Data$Emissions, Problem6Data$fips, diff)
Problem6Data$ChangeOfEmissions <- c(0, calcDiff$Los.Angeles, 0, calcDiff$Baltimore)   
library(ggplot2)

png("./plot6.png")
g <- ggplot(Problem6Data, aes(x = year, y = ChangeOfEmissions, group = fips, color = fips))
g <- g + geom_line() + geom_point()
g <- g + labs(x = "Years", y = "Change of Emissions(ton)")
g <- g + labs(title = "Motor vehicle PM2.5 Emissions Changes(1999-2008), LA vs Baltimore")
print(g)

dev.off()
