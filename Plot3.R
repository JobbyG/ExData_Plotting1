## Set the working Directory. The directory where the data is saved

    setwd("C:/Users/jobby/Documents/Personal/Data Science/Exploratory Data Analysis")
    
## Read the downloaded data from the directory

    powerData<- read.csv("household_power_consumption.txt", header=T, sep=";", na.strings = "?")

## Format the Date data

    powerData$Date<- as.Date(powerData$Date, format = "%d/%m/%Y")

## Subset the data to select information for the needed dates only
    
    newDat<- subset(powerData, subset = (Date == "2007-02-01" | Date == "2007-02-02"))
 
## Combine the Date and Time fields
    
    DateTime<- paste(as.Date(newDat$Date), newDat$Time)
    newDat$DateTime <- as.POSIXct(DateTime)
    
## Create plot

    with (newDat, {
      plot(Sub_metering_1~DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
      lines(Sub_metering_2~DateTime, col = "Red")
      lines(Sub_metering_3~DateTime, col = "Blue")
    })
    
    legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
## Create copy of the plot in a png file

    dev.copy(png, file = "plot3.png", height = 480, width = 480)

    dev.off()