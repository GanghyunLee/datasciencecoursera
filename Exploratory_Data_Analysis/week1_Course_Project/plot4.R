#if data is empty, load the data

if(!"data" %in% ls()) {
        data <- read.table("./household_power_consumption.txt", 
                           header=TRUE, sep = ";", stringsAsFactors = FALSE,
                           na.strings = "?",
                           colClasses = c("character", "character", "double", "double", "double",
                                          "double", "double", "double", "double"))
        
        data$Date <- as.Date(data$Date, "%d/%m/%Y")
        data$Time <- strptime(paste(data$Date, data$Time, sep = " "), "%Y-%m-%d %H:%M:%S")
        data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
}

png("./plot4.png")
Sys.setlocale(category = "LC_ALL", locale = "english")
par(mfrow = c(2,2))
#1
plot(data$Time, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

#2
plot(data$Time, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#3
plot(data$Time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
points(data$Time, data$Sub_metering_2, type = "l", col = "red")
points(data$Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

#4
plot(data$Time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", col = "black")
dev.off()