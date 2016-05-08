plot4 <- function() {
     
## load dependent libraries
     library(dplyr)
     library(lubridate)

## download the relevant data set if it doesn't exist already
     if( !file.exists("power_consumption.zip")) {
          fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          download.file( fileUrl, destfile = "power_consumption.zip")
          dateDownloaded <- date()
     }
## extract activity files from archive and subset, create new datetime column
     powerC <- read.table(unz("power_consumption.zip","household_power_consumption.txt" ), sep=";", header = TRUE, na.strings = "?")
     powerC$Date <- dmy(powerC$Date)
     powerC <- filter(powerC, Date >= ymd("2007-02-01"), Date <= ymd("2007-02-02"))
     powerC <- mutate(powerC, datetime = ymd_hms(paste(powerC$Date," ",powerC$Time)))
     
## Set panel, create plot
     png(filename = "plot4.png",width = 480, height = 480, units = "px")
     par(mfcol=c(2,2))
     # top left plot
     plot(powerC$datetime, powerC$Global_active_power, type="l", xlab = "", ylab="Global Active Power")
     # bottom left plot
     plot(powerC$datetime, powerC$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
     lines(powerC$datetime, powerC$Sub_metering_2, col="red")
     lines(powerC$datetime, powerC$Sub_metering_3, col="blue")
     legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"), lwd=1)
     # top right plot
     with(powerC, plot(datetime, Voltage, type="l" ))
     # bottom right plot
     with(powerC, plot(datetime, Global_reactive_power, type="l" ))
     dev.off()
}