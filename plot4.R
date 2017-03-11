# read the data and subset to the two subject days
hpc.dta <- read.table("household_power_consumption.txt",
                      sep = ";", header = TRUE, na.strings = "?",
                      stringsAsFactors = FALSE)

dates <- as.Date(hpc.dta$Date, format = "%d/%m/%Y")
# subset to only two days: 2007-02-01 and 2007-02-02
hpc.dta <-
  rbind(hpc.dta[dates == as.Date("2007-02-01", format = "%Y-%m-%d"), ],
        hpc.dta[dates == as.Date("2007-02-02", format = "%Y-%m-%d"), ])
dates.times <- 
  strptime(paste(hpc.dta$Date, hpc.dta$Time),
           format = "%d/%m/%Y %H:%M:%S")

####

png(file = "plot4.png", width = 480, height = 480)

par(mfcol = c(2, 2))

plot(dates.times, hpc.dta$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

plot(dates.times, hpc.dta$Sub_metering_1,
     type = "n",
     xlab = "", ylab = "Energy sub metering")
points(dates.times, hpc.dta$Sub_metering_1,
       type = "l",
       col = "black")
points(dates.times, hpc.dta$Sub_metering_2,
       type = "l",
       col = "red")
points(dates.times, hpc.dta$Sub_metering_3,
       type = "l",
       col = "blue")
legend("topright",
       lty = "solid",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dates.times, hpc.dta$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(dates.times, hpc.dta$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()
