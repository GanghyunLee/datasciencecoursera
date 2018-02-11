if(!("NEI" %in% ls())) NEI <- readRDS("./data/summarySCC_PM25.rds")
if(!("SCC" %in% ls())) SCC <- readRDS("./data/Source_Classification_Code.rds")

# Problem 3) Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999 - 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 - 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

Problem3Data <- subset(NEI, fips == "24510")
Problem3Data <- aggregate(Emissions ~ year + type, Problem3Data, FUN = sum)
Problem3Data$year <- as.factor(Problem3Data$year)
Problem3Data$type <- as.factor(Problem3Data$type)

png("./plot3.png")

g <- ggplot(Problem3Data, aes(x = year, y = Emissions, group = type, color = type))
g <- g + geom_line() + geom_point()
g <- g + labs(x = "Year", y = "Emissions(ton)")
g <- g + labs(title = "PM2.5 Emissions from 1999 - 2008(Baltimore City) by source type")
print(g)

dev.off()