## PLOT 3: ENERGY SUB METERING

library(data.table)

# GET THE DATA SET FROM THE URL

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- tempfile()

if (file.exists(fileURL) == FALSE) {
  download.file(fileURL, destfile, mode="wb")
}

# GET THE FILES FROM THE ZIP
unzip(destfile)

# DELETE THE ZIP FILE
unlink(destfile)

# STORE DATA IN A DATA.FRAME
power.consumption.data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# CREATE A NEW VARIABLE IN DATA.FRAME TO STORE DATE AND TIME IN DATE FORMAT
power.consumption.data$DateTime1 <- strptime(paste(power.consumption.data$Date, power.consumption.data$Time) , format = "%d/%m/%Y %H:%M:%S")

# OBTAIN DATA ONLY FOR 2007-02-01 AND 2007-02-02
power.consumption.data.analysis <- subset(power.consumption.data, as.Date(DateTime1) %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

# CREATE THE PNG FILE
png("plot3.png", width=480, height=480)

with(power.consumption.data.analysis, plot(DateTime1, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering"))

with(power.consumption.data.analysis, lines(DateTime1, Sub_metering_2, col="red"))
with(power.consumption.data.analysis, lines(DateTime1, Sub_metering_3, col="blue"))

legend("topright", col=c("black","red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1)

dev.off()

