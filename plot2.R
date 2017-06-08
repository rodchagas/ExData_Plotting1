if(!file.exists('data.zip')){
      url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
      
      download.file(url,destfile = "data.zip")
      unzip("data.zip") # This creates the file "household_power_consumption.txt"
}


power_consumption <-read.table("household_power_consumption.txt",header = TRUE, sep= ";",
                               na.strings = "?", 
                               colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

names(power_consumption)
lapply(power_consumption, class)

#Clear na
power_consumption <- power_consumption[complete.cases(power_consumption),]

# Convert Date field to Date class
power_consumption$Date2 <- as.Date(power_consumption$Date, format = "%d/%m/%Y")
#Filter 01/02/2007 to 02/02/2007
power_consumption <- subset(power_consumption,
                            Date2 >= as.Date("2007-2-1") & Date2 <= as.Date("2007-2-2"))
#Create a DateTime field
power_consumption$DateTime<-paste(power_consumption$Date, power_consumption$Time)
power_consumption$DateTime<-strptime(power_consumption$DateTime, "%d/%m/%Y %H:%M:%S")
power_consumption <- power_consumption[c(3:9,11)]

#PLOT 2
with(power_consumption, 
     plot(DateTime, Global_active_power , type="l", 
          ylab="Global Active Power (kilowatts)", xlab=""))
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()