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
#open png device
png("plot2.png")
#Line plot with the appropriate title, labels (x label set to none, to agree with the requirements)
plot(df$datetime,df$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
#close the png device
dev.off()