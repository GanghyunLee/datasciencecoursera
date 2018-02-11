if(!("NEI" %in% ls())) NEI <- readRDS("./data/summarySCC_PM25.rds")
if(!("SCC" %in% ls())) SCC <- readRDS("./data/Source_Classification_Code.rds")

# Problem 4) Across the United States, how have emissions
# from coal combustion-related sources changed from 1999~2008?

relatedSCC <- SCC[grep("coal", SCC$SCC.Level.Four, ignore.case = TRUE), ]
relatedSCC <- relatedSCC[grep("comb", relatedSCC$SCC.Level.One, ignore.case = TRUE), ]

Problem4Data <- subset(NEI, NEI$SCC %in% relatedSCC$SCC)
Problem4Data <- aggregate(Emissions ~ year, Problem4Data, FUN = sum)

library(ggplot2)
png("./plot4.png")

g <- ggplot(Problem4Data, aes(x = year, y = Emissions))
g <- g + geom_line() + geom_point()
g <- g + labs(x = "Years", y = "Emissions(ton)")
g <- g + labs(title = "PM2.5 Emissions from coal combustion-related sources(1999-2008)")

print(g)
dev.off()