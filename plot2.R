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
  
png("plot2.png", width=480, height=480)
with(db, plot(date_time, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()
