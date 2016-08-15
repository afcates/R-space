#example:
#time_series <- make_time(start_time="1900-01-01 00:00:00", end_time="1900-01-01 23:59", interval_seconds=60, output_format="%H:%M")

make_time <- function(start_time,end_time,interval_seconds,output_format) {
	start_time <- as.POSIXct(start_time)
	end_time <- as.POSIXct(end_time)
	time_series <- data.frame(time=start_time)
	keyvar <- interval_seconds
	while((start_time + keyvar) <= end_time) {
		time_series <- rbind(data.frame(time=start_time + keyvar),time_series)
		keyvar <- keyvar + interval_seconds
	}
	time_series <- data.frame(time=time_series[order(time_series$time) , ]) #order by time
	time_series$time <- format(time_series$time, output_format) #format as e.g. 23:59 = "%H:%M";
	time_series.vector <- as.vector(as.matrix(time_series))
	return(time_series.vector)
}
