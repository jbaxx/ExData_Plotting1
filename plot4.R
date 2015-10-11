setwd("./Documents/ExpData Class/Project 1/ExData_Plotting1")
if(!file.exists("./household_power_consumption.txt")){
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="pdata2.zip",method="curl")
unzip("pdata2.zip")
}
gdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
gdata$Global_active_power<-as.numeric(levels(gdata$Global_active_power)[gdata$Global_active_power])
gdata$Global_reactive_power<-as.numeric(levels(gdata$Global_reactive_power)[gdata$Global_reactive_power])
gdata$Voltage<-as.numeric(levels(gdata$Voltage)[gdata$Voltage])
gdata$Global_intensity<-as.numeric(levels(gdata$Global_intensity)[gdata$Global_intensity])
gdata$Sub_metering_1<-as.numeric(levels(gdata$Sub_metering_1)[gdata$Sub_metering_1])
gdata$Sub_metering_2<-as.numeric(levels(gdata$Sub_metering_2)[gdata$Sub_metering_2])
gdata$Date<-as.character(gdata$Date, stringsAsFactors=FALSE)
gdata$Time<-as.character(gdata$Time, stringsAsFactors=FALSE)
gdatas<-gdata[grepl(paste(c("^1/2/2007$","^2/2/2007$"),collapse="|"),gdata$Date),] #Real exact match
rm(gdata)
gdatas$Date<-as.Date(gdatas$Date,"%d/%m/%Y")
gdatas$DateTimex<-paste(gdatas$Date,gdatas$Time)
gdatas$DateTime<-strptime(gdatas$DateTimex,"%Y-%m-%d %H:%M:%S")
gdatat<-gdatas[,c(11,3:9)]
rm(gdatas)
png(file="plot4.png")
par(mfrow=c(2,2))
plot(gdatat$DateTime,gdatat$Global_active_power,type="n",ylab="Global Active Power",xlab="")
lines(gdatat$DateTime,gdatat$Global_active_power)

plot(gdatat$DateTime,gdatat$Voltage,type="n",ylab="Voltage",xlab="Datetime")
lines(gdatat$DateTime,gdatat$Voltage)

plot(gdatat$DateTime,gdatat$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(gdatat$DateTime,gdatat$Sub_metering_1)
lines(gdatat$DateTime,gdatat$Sub_metering_2,col="red")
lines(gdatat$DateTime,gdatat$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch="-",col=c("black","red","blue"))

plot(gdatat$DateTime,gdatat$Global_reactive_power,type="n",ylab="Global Reactive Power",xlab="Datetime")
lines(gdatat$DateTime,gdatat$Global_reactive_power)
dev.off()