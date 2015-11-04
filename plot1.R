#############################################################
# Obtain raw data from the URL specific to Course Project 1 #
#############################################################

# Local filename of dataset
rawFilename <- "exdata-data-household_power_consumption.zip"

# Download only if not already done
if (!file.exists(rawFilename)) {
    # URL provided for the Course Project
    rawUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    # Other methods may be applied...
    download.file(rawUrl, destfile=rawFilename, method="wget")
}

########################################
# Unzip, read, convert and filter data #
########################################

# Unzip and read
x <- read.table(unz("exdata-data-household_power_consumption.zip",
                    "household_power_consumption.txt"),
                header = TRUE, sep=";", na.strings = "?")
# Convert Time and Date variables
x$Time <- strptime(paste(x$Date,x$Time), "%d/%m/%Y %H:%M:%S")
x$Date <- as.Date(x$Date, "%d/%m/%Y")
# Filter to extract days of interest
startDate <- as.Date("1/2/2007","%d/%m/%Y")
endDate <- as.Date("2/2/2007","%d/%m/%Y")
x <- subset(x, Date %in% c(startDate, endDate))

##################
# Produce Plot 1 #
##################

# Open png device with default dimensions (480 x 480 pixels)
png(filename = "plot1.png")
# Plot
hist(x$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
# Close device
dev.off()