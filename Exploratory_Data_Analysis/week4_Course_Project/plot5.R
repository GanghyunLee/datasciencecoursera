if(!("NEI" %in% ls())) NEI <- readRDS("./data/summarySCC_PM25.rds")
if(!("SCC" %in% ls())) SCC <- readRDS("./data/Source_Classification_Code.rds")

# Problem 5) How have emissions from motor vehicle sources changed from 1999~2008 in Baltimore City?

library(ggplot2)

Problem5Data <- subset(NEI, fips == "24510")            # in Baltimore City
MotorVehicleData <- SCC[grepl("vehicles", SCC$EI.Sector, ignore.case=TRUE),]
Problem5Data <- subset(Problem5Data, Problem5Data$SCC %in% MotorVehicleData$SCC)
Problem5Data <- aggregate(Emissions ~ year, Problem5Data, FUN = sum)

png("./plot5.png")
g <- ggplot(Problem5Data, aes(x = year, y = Emissions))
g <- g + geom_line() + geom_point()
g <- g + labs(x = "Years", y = "Emissions(ton)")
g <- g + labs(title = "PM2.5 Emissions from motor vehicle sources(1999-2008)")

print(g)
dev.off()

