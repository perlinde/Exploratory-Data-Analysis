library(lubridate)
library(tidyverse)

#Assumes your data file is in your working directory.
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?"))

#Generate time variables
df$Date <- dmy(df$Date)
df$dateTime <- ymd_hms(paste(df$Date, df$Time))

#Numeric variables were imported as factors. Convert to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)


df <- filter(df, Date=="2007-02-01" | Date =="2007-02-02")

with(df, plot(dateTime, Sub_metering_1, type="n", ylab = "Energy sub metering", xlab=""))
with(df, lines(dateTime, Sub_metering_1, col="black"))
with(df, lines(dateTime, Sub_metering_2, col="red"))
with(df, lines(dateTime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1))
dev.copy(device = png, filename = 'plot3.png', width = 480, height = 480) 
dev.off()