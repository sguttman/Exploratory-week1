plot1 <- function() {
     
## load dependent libraries
     library(dplyr)
     library(lubridate)
     library(tidyr)
     
## download the relevant data set if it doesn't exist already
     if( !file.exists("power_consumption.zip")) {
          fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          download.file( fileUrl, destfile = "power_consumption.zip")
          dateDownloaded <- date()
     }
## extract activity files from archive and subset
     powerC <- read.table(unz("power_consumption.zip","household_power_consumption.txt" ), sep=";", header = TRUE, na.strings = "?")
     powerC$Date <- dmy(powerC$Date)
     powerC <- filter(powerC, Date >= ymd("2007-02-01"), Date <= ymd("2007-02-02"))
     
## Create plot
     png(filename = "plot1.png",width = 480, height = 480, units = "px")
     hist( powerC$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency")
     dev.off()
}