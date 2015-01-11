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
png("plot3.png")
#Plots with labels, legends, etc
#the call to plot() has type "n" to avoid printing anything
#plot() is called with df$datetime and df$Sub_metering_1 as a way to set the scales right
plot(df$datetime,df$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(df$datetime,df$Sub_metering_1,col="black",type="l")
lines(df$datetime,df$Sub_metering_2,col="red",type="l")
lines(df$datetime,df$Sub_metering_3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
#close the png device
dev.off()
