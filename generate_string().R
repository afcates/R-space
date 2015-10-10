library(data.table)
library(stringdist)

letters <- data.frame("x"=c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"), stringsAsFactors=FALSE)

# Running replicate() with this function with n=1,000,000 times takes a bit
generate.pin <- function(x) {
  pin <- replicate(x, letters[sample(1:26,1),])
  pin <- paste(pin, collapse=" ")
  pin <- gsub(" ", "", pin)
  pin <- toupper(pin)
}

big <- data.table()
for(i in 1:10000) {
  small <- data.table(generate.pin(8))
  big <- rbind(big,small)
}



test <- generate.pin(8,1000)


#slow?
system.time(
test <- replicate(10000,generate.pin(8))
)


pin_table <- read.csv("C:/Users/anthony/Desktop/trash/mm_pins.csv", colClasses = "character", stringsAsFactors = FALSE)
pins <- data.table(pin_table,key="pin")

results_master <- data.table("pin"=as.character(),"result"=as.character())
#results_master <- data.table()
for(i in pins$pin) {
  if(length(results_master$pin) > 100) { break }
  theresult <- amatch(i,pins[pin!=i],method="hamming",maxDist=7) #agrep(i,pins[pin!=i],useBytes=FALSE)
  clean_result <- ifelse(length(theresult)==0,0,theresult)
  format_result <- data.table("pin"=i,"result"=clean_result)
  results_master <- rbind(results_master,format_result)
}

test <- amatch("NICARSRD",big$V1,method="hamming")
