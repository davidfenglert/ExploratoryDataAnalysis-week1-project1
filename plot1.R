
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

png(file = "plot1.png", width = 480, height = 480)
hist(hpc.dta$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red")
dev.off()
