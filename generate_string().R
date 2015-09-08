library(data.table)

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




