library(tidyverse)
db <- read.table("./household_power_consumption.txt", 
                        stringsAsFactors = FALSE, header = TRUE, sep =";" ) %>% 
  mutate(date_time = dmy_hms(paste0(Date," ",Time))) %>% 
  mutate(Date=dmy(Date),
         Time=hms(Time),
         across(starts_with("Global"), as.numeric),
         across(starts_with("Sub"), as.numeric),
         Voltage=as.numeric(Voltage)) %>% 
  filter(Date>="2007-02-01", Date<="2007-02-02")
  
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(db, plot(date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(db, plot(date_time, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(db, plot(date_time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(db$date_time, db$Sub_metering_2,type="l", col= "red")
lines(db$date_time, db$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(db, plot(date_time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()