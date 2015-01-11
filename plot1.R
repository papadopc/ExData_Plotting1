# read in all data, set stringsAsFactors=FALSE to deal with date and numerical conversions
alldf<-read.csv("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE)
#subset only the dates we're intersted in
#NOTE THE DATE CONVENTION, it day/month/year 
df<-alldf[alldf$Date=="1/2/2007"|alldf$Date=="2/2/2007",]
#Convert to POSIX date
df$Date<-strptime(df$Date,format="%d/%m/%Y")
#Conver from strings to numeric values
df$Global_active_power<-as.numeric(df$Global_active_power)
# open the png device for exporting
png("plot1.png")
#Make hist plot with the appropriate title, color and label
hist(df$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
#close the png device
dev.off()