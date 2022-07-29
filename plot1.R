library(tidyverse)
db <- read.table("./household_power_consumption.txt", 
                        stringsAsFactors = FALSE, header = TRUE, sep =";"  ) %>% 
  mutate(Date=dmy(Date),
         Time=hms(Time),
         across(starts_with("Global"), as.numeric),
         across(starts_with("Sub"), as.numeric),
         Voltage=as.numeric(Voltage)) %>% 
  filter(Date>="2007-02-01", Date<="2007-02-02")
  
  png("plot1.png", width=480, height=480)
  hist(db$Global_active_power, col="red", border="black", main ="Global Active Power", 
       xlab="Global Active Power (kilowatts)", 
       ylab="Frequency")
  dev.off()
