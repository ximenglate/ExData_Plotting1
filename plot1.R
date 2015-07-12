##Exploratory Data Analysis: Peer Assessment 1
setwd("C:/Users/User/Desktop/Exploratory data analysis/Peer Assessment 1/")

#Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/exdata-data-household_power_consumption.zip")
dateDownload <- date() #Download date
unzip("./data/exdata-data-household_power_consumption.zip") #Unzip file
memorySize1 <- memory.size() #Check working memory size

#Read data into Rstudio: Leave only data from 2007-02-01 to 2007-02-02
dest <- file("./household_power_consumption.txt", "r")
consumption <- read.table(text=grep("^[1|2]/2/2007", readLines(dest), value=TRUE),
                          sep=";", skip=0, na.strings="?", stringsAsFactors=FALSE)
names(consumption) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                        "Sub_metering_3")
memorySize2 <- memory.size() #Check working memory usage
objectSize <- object.size(consumption) #Check object size

#Convert the Date and Time variables to Date/Time classes
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time),
                                 format="%d/%m/%Y %H:%M:%S")

#Plot 1
par(mfrow=c(1,1))
histgram <- hist(consumption$Global_active_power, main="Global Active Power",
                 xlab="Global Active Power (kilowatts)", ylab="Frequency",
                 col="red", freq=TRUE)
histgram

#Construct the plot and save it to PNG file with 480*480 pixels
#Name PNG file as plotn.png
dev.copy(device=png, file="./plot1.png", width=480, height=480)
dev.off()
