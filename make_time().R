#example:
#time_series <- make_time(start_time="1900-01-01 00:00:00",end_time="1900-01-01 23:59",interval=60)

make_time <- function(start_time,end_time,interval) {
	start_time <- as.POSIXct(start_time)
	end_time <- as.POSIXct(end_time)
	time_series <- data.frame(time=start_time)
	keyvar <- interval
	while((start_time + keyvar) < end_time) {
		time_series <- rbind(data.frame(time=start_time + keyvar),time_series)
		keyvar <- keyvar + interval
	}
	time_series <- data.frame(time=time_series[order(time_series$time) , ]) #order by time
	time_series$time <- format(time_series$time, "%H:%M") #format as e.g. 23:59
	time_series
}