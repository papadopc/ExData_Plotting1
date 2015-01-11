# read in all data, set stringsAsFactors=FALSE to deal with date and numerical conversions
alldf<-read.csv("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE)
#subset only the dates we're intersted in
#NOTE THE DATE CONVENTION, it day/month/year 
df<-alldf[alldf$Date=="1/2/2007"|alldf$Date=="2/2/2007",]
#Convert to POSIX date
df$Date<-strptime(df$Date,format="%d/%m/%Y")
#Convert strings to numeric
df$Global_active_power<-as.numeric(df$Global_active_power)
#Create new column, that has the full date and time 
df$datetime<-paste(df$Date,df$Time)
#Convert datetime to POSIX
df$datetime<-strptime(df$datetime,format="%Y-%m-%d %H:%M:%S")
#Convert strings to numeric. Could also do it with a range, but this is explicit
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)
#open the png device to export file
#This method seems to work better than the dev.copy() one, it doesn't chopp off bits
png("plot4.png")
#set up the 4 windows
par(mfrow=c(2,2)) 

#plot for active power, for some reason the units are missing from the required output
#it's the same as plot2
plot(df$datetime,df$Global_active_power,type="l",ylab="Global Active Power",xlab="")
#plot for Voltage
#first convert to numeric
df$Voltage<-as.numeric(df$Voltage)
#then plot
plot(df$datetime,df$Voltage,type="l",ylab="Voltage",xlab="datetime")
#plot is same as plot3
#the call to plot() has type "n" to avoid printing anything
#plot() is called with df$datetime and df$Sub_metering_1 as a way to set the scales right
plot(df$datetime,df$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(df$datetime,df$Sub_metering_1,col="black",type="l")
lines(df$datetime,df$Sub_metering_2,col="red",type="l")
lines(df$datetime,df$Sub_metering_3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty="n")
#new plot for plot4
#first convert df$Global_reactive_power to numeric
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
#now make plot
plot(df$datetime,df$Global_reactive_power,type="l",ylab="Global_active_power",xlab="datetime")
#close the png device
dev.off()
