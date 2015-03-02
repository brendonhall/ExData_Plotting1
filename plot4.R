#Exploratory Data Analysis
#Project 1
#
#Brendon Hall


#This script loads household power consumption data from  UC Irvine Machine Learning Repository
# (http://archive.ics.uci.edu/ml/)
#In particular, we are going to use the individual household power consumption data
#This measures power consumption data for one household over 4 years, at a sample rate of one minute.
#
#There are 9 measurements taken, and they are:
#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#
#For this assignment, we are interested in data for 2 days, Feb 1 2007 and Feb 2 2007.  Examining the data shows that it is ordered
#by time, and data for this date range begins on row 66638 and ends on row 69517

#assume that the data is located in data/household_power_consumption.txt
fileName <- "data/household_power_consumption.txt"
colNames <- names(read.table(fileName,header=TRUE, sep=";", na.strings="?", nrows=1))

data <- read.table(fileName, header=FALSE, sep=";", na.strings="?", skip=66637, nrows=2879, col.names=colNames)

#convert the date column to the Date data type
data$Date <-as.Date(data$Date, "%d/%m/%Y")
#create a timestamp column that combines date and time
data$Timestamp <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")



png('plot4.png', width=480, height=480, units='px')
par(mfrow=c(2,2))
plot(data$Timestamp, data$Global_active_power,type="l", xlab=NA, ylab="Global Active Power")

plot(data$Timestamp, data$Voltage,type="l",  ylab="Voltage", xlab="datetime")

plot(data$Timestamp, data$Sub_metering_1,type="l", xlab=NA, ylab="Energy sub metering")
lines(data$Timestamp, data$Sub_metering_2,type="l", col='red')
lines(data$Timestamp, data$Sub_metering_3,type="l", col='blue')
legend("topright", c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty=1, bty="n")

plot(data$Timestamp, data$Global_reactive_power,type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()


