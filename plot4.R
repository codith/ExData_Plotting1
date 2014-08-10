library(data.table)

# Read in all data.
setwd("~/coursera/ExData_Plotting1/")
suppressWarnings(power_data <- fread("../data/household_power_consumption.txt", 
                    header = TRUE, sep = ";"))

# Create Datetime column from Date and Time columns
Datetime <- data.frame(Datetime = strptime(paste(power_data$Date,
                                                 power_data$Time), 
                                format = "%d/%m/%Y %T", tz = "UTC"))
power_data <- cbind(Datetime, power_data)

# Convert characters to numeric. (Fix for bug in fread treatment of na.)
for (i in names(power_data)[4:10]) power_data[[i]] <- as.numeric(power_data[[i]]) 

# Subset data for dates 2007-02-01 and 2007-02-02
power_data_subset <- power_data[as.Date(power_data$Datetime) 
                                %in% as.Date(c("2007-02-01", "2007-02-02")),]


# Set up environment for plot 4.
png("plot4.png", height = 480, width = 480, bg = NA)
par(mfrow = c(2,2))

# Add first plot.
with(power_data_subset, plot(Datetime, Global_active_power, type = "l", 
                             xlab = "", ylab = "Global Active Power"))

# Add second plot.
with(power_data_subset, plot(Datetime, Voltage, type = "l", xlab = "datetime"))

# Add third plot.
with(power_data_subset, plot(Datetime, Sub_metering_1, type = "l", 
                             xlab = "", ylab = "Energy sub metering"))
with(power_data_subset, lines(Datetime, Sub_metering_2, col = "red"))
with(power_data_subset, lines(Datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",  
                              "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n")

# Add fourth plot.
with(power_data_subset, plot(Datetime, Global_reactive_power, type = "l"))

dev.off()