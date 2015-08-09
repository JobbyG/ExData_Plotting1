## Set the working Directory. The directory where the data is saved

    setwd("C:/Users/jobby/Documents/Personal/Data Science/Exploratory Data Analysis")
    
## Read the downloaded data from the directory

    powerData<- read.csv("household_power_consumption.txt", header=T, sep=";", na.strings = "?")

## Format the Date data

    powerData$Date<- as.Date(powerData$Date, format = "%d/%m/%Y")

## Subset the data to select information for the needed dates only
    
    newDat<- subset(powerData, subset = (Date == "2007-02-01" | Date == "2007-02-02"))
    
    rm(powerData)
## Combine the Date and Time fields
    
    DateTime<- paste(as.Date(newDat$Date), newDat$Time)
    newDat$DateTime <- as.POSIXct(DateTime)
    
## Create plot
    par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
    with (newDat, {
      plot(Global_active_power~DateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
      
      plot(Voltage~DateTime, type="l", ylab = "Voltage (volt)", xlab = "DateTime")
      
      plot(Sub_metering_1~DateTime, type="l", ylab = "Energy sub metering", xlab = "")
      
      lines(Sub_metering_2~DateTime, col = "Red")
      
      lines(Sub_metering_3~DateTime, col = "Blue")
      
      legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
      plot(Global_reactive_power~DateTime, type = "l", ylab = "Global Reactive Power", xlab="")
    })
     
    
## Create copy of the plot in a png file

    dev.copy(png, file = "plot4.png", height = 480, width = 480)

    dev.off()