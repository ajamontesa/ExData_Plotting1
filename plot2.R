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

## Plot 2
plot(hpcfeb$DT, hpcfeb$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power kilowatts")
lines(hpcfeb$DT, hpcfeb$Global_active_power)
dev.copy(png, file = "plot2.png")
dev.off()