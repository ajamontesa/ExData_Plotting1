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

## Plot 3
plot(hpcfeb$DT, hpcfeb$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(hpcfeb$DT, hpcfeb$Sub_metering_1)
lines(hpcfeb$DT, hpcfeb$Sub_metering_2, col = "red")
lines(hpcfeb$DT, hpcfeb$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()