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
## plot
png('plot1.png', 480, 480)
hist(filtered_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()
