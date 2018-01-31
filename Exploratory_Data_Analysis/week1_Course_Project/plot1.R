#if data is empty, load the data

if(!"data" %in% ls()) {
        data <- read.table("./household_power_consumption.txt", 
                           header=TRUE, sep = ";", stringsAsFactors = FALSE,
                           na.strings = "?",
                           colClasses = c("character", "character", "double", "double", "double",
                                          "double", "double", "double", "double"))

        data$Date <- as.Date(data$Date, "%d/%m/%Y")
        data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
}
png("./plot1.png")
par(mfrow = c(1,1))
Sys.setlocale(category = "LC_ALL", locale = "english")
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()