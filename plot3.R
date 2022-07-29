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
  
png("plot3.png", width=480, height=480)
with(db, plot(date_time, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(db$date_time, db$Sub_metering_2,type="l", col= "red")
lines(db$date_time, db$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()
