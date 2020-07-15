url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url1, "data.zip")
unzip("data.zip")

library(tidyverse)
library(lubridate)

hpc <-
    read_delim(file = "household_power_consumption.txt", delim = ";",
               col_types = "ccnnnnnnn") %>%
    mutate(Date = parse_date(Date, format = "%d/%m/%Y"),
           DT = paste(Date, Time))

hpcfeb <- hpc %>%
    filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>%
    select(DT, everything()) %>%
    mutate(DT = as_datetime(DT))

## Plot 4
par(mfcol = c(2, 2))

plot(hpcfeb$DT, hpcfeb$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power")
lines(hpcfeb$DT, hpcfeb$Global_active_power)

plot(hpcfeb$DT, hpcfeb$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(hpcfeb$DT, hpcfeb$Sub_metering_1)
lines(hpcfeb$DT, hpcfeb$Sub_metering_2, col = "red")
lines(hpcfeb$DT, hpcfeb$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", y.intersp = 0.5)

plot(hpcfeb$DT, hpcfeb$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(hpcfeb$DT, hpcfeb$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png")
dev.off()
