#=======================================
# Load data
#=======================================
pollution <- read.csv("../data/avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)

#=================================================================
# Five Number Summary : Min., 1st Qu., Median, Mean, 3rd Qu., Max. 
# Actually : Six. (because it includes mean)
#=================================================================
summary(pollution$pm25)

#=================================================================
# Boxplot
#=================================================================
boxplot(pollution$pm25, col="blue") 

#=================================================================
# Histogram
#=================================================================
hist(pollution$pm25, col = "green") 
rug(pollution$pm25)                             # Add rug

hist(pollution$pm25, col = "green", breaks=100) # the number of bars : 100

#=================================================================
# Overlaying Features
#=================================================================
boxplot(pollution$pm25, col="blue") 
abline(h = 12)                          # Add horizontal straight lines to a plot(Overlaying)

hist(pollution$pm25, col = "green")
abline(v = median(pollution$pm25), col="magenta", lwd = 4)      # Add vertical straight line (lwd : line width)

#=================================================================
# Barplot(for categorical data)
#=================================================================
barplot(table(pollution$region), col = "wheat", main = "Number of Countries in Each Region")

#=================================================================
# Multiple Boxplot
#=================================================================
boxplot(pm25 ~ region, data = pollution, col = "red")

#=================================================================
# Multiple Histograms
#=================================================================
par(mfrow = c(2,1))                                             # Set subplot dimension
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

#=================================================================
# Scatterplot
#=================================================================
par(mfrow = c(1,1))  
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)        # lwd : line width, lty : line type

#=================================================================
# Scatterplot(using color)
#=================================================================
par(mfrow = c(1,1))  
with(pollution, plot(latitude, pm25, col=region))
abline(h = 12, lwd = 2, lty = 2)        # lwd : line width, lty : line type

#=================================================================
# Multiple Scatterplot
#=================================================================
par(mfrow = c(1, 2))
with(subset(pollution, region == "west"), plot(latitude, pm25, main="West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main="East"))