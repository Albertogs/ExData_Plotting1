#---------------------------------------
#            PLOT 3
#---------------------------------------
#Reading and selecting data.
vnames <-c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
           "Sub_metering_1","Sub_metering_2","Sub_metering_3")
data_table <- read.table(file="./household_power_consumption.txt", sep=";", skip=1) 
names(data_table) <- vnames
data_table$Date <- as.Date(data_table$Date, format <- "%d/%m/%Y") # transformation to date
idata <- data_table[(data_table$Date=="2007-02-01" | data_table$Date =="2007-02-02"),] # selecting data
rm("data_table")

#Selecting and converting data
idata$Time <- format(strptime(as.character(idata$Time), format<-"%H:%M:%S"), format<-"%H:%M:%S") # transformation
idata$Global_active_power <- as.numeric(as.character(idata$Global_active_power))
Sys.setlocale("LC_TIME", "C")
idata$Time <-strptime(paste(as.character(idata$Date), idata$Time, sep=" "),format="%Y-%m-%d %H:%M:%S")
idata$Sub_metering_1 <- as.numeric(as.character(idata$Sub_metering_1))
idata$Sub_metering_2 <- as.numeric(as.character(idata$Sub_metering_2))
idata$Sub_metering_3 <- as.numeric(as.character(idata$Sub_metering_3))

#Making the plot
plot(idata$Time,idata$Sub_metering_1, type="l",ylab="Global Active Power (kilowatts)",xlab="")
points(idata$Time, idata$Sub_metering_2, type="l", col="red")
points(idata$Time, idata$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=1, legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),text.font=1)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()