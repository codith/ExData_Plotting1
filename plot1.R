library(data.table)

# Read in all data
setwd("~/coursera/ExData_Plotting1/")
power_data <- fread("../data/household_power_consumption.txt", 
                    header = TRUE, sep = ";")

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


# Make plot 1.
par("mar" = c(4,4,2,2), "mgp" = c(2,1,0))

png(filename = "plot1.png", width = 480, height = 480, bg = NA)
hist(power_data_subset$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     cex.lab = 1, cex.axis = 1, cex.main = 1.2, col = "red")
dev.off()