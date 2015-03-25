library('jsonlite')
JSON_Schedule <- fromJSON(txt = "http://www.pgatour.com/data/R/schedule.json")
x <- JSON_Schedule$tours$trns
DF <- as.data.frame(x[[1]])
DF[16] <- DF[16]$trnName$official
DF[c(5,9, 16)]
