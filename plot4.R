if(!file.exists("./data")){
  dir.create("./data")
}
# the data for the project:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

library(tidyverse)
library(lubridate)
data <- read.table('data/household_power_consumption.txt', header=TRUE, sep=";", na.strings = "?")
str(data)
head(data)

data <- data %>% mutate(
  date_time = dmy_hms(paste(Date, Time)),
  Date = dmy(Date),
  Time = hms(Time))
str(data) # We did it

# Now we filter
filtered_data <- data %>%
  filter(between(Date, ymd('2007-02-01'), ymd('2007-02-02')))

map_df(filtered_data, ~sum(is.na(.)))## no NA founds
png('plot4.png', 480, 480)
par(mfrow = c(2, 2))
# First plot
plot(filtered_data$date_time, filtered_data$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# Second plot
plot(filtered_data$date_time, filtered_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Third plot
plot(filtered_data$date_time, filtered_data$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(filtered_data$date_time, filtered_data$Sub_metering_2, type="l", col="red")
lines(filtered_data$date_time, filtered_data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# Fourth plot
plot(filtered_data$date_time, filtered_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)
dev.off()


