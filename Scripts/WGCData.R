CompleteData <- data.frame(rndNum = numeric(0),courseNum = numeric(0),rndPos = character(0),rndScr = numeric(0),relParScr= character(0),cumParScr = character(0),playerName = numeric(0),year = numeric(0), name = character(0))
years <- 2001:2001
j = 1

for(j in 1:length(years))
{
  
  JSONLink <- paste("http://www.pgatour.com/data/R/473/",years[j],"/tournsum.json", sep = "")
  temp <- data.frame(rndNum = numeric(0),courseNum = numeric(0),rndPos = character(0),rndScr = numeric(0),relParScr= character(0),cumParScr = character(0),playerName = numeric(0),year = numeric(0), name = character(0))
  JSONData <- fromJSON(txt=JSONLink, flatten= FALSE)
  plrNums <- JSONData$years$tours[[1]]$trns[[1]]$plrs[[1]]$plrNum
  plrScores <- JSONData$years$tours[[1]]$trns[[1]]$plrs[[1]]$rnds
  
  
  print(paste(as.numeric(JSONData$years$year), years[j]))
  
  i = 1
  for(i in 1:length(plrScores))
  {
    if(length(plrScores[[i]]$rndNum) > 0)
    {
      plrScores[[i]]$playerName <- rep(plrNums[i], times = length(plrScores[[i]]$rndNum))
      plrScores[[i]]$year <- rep(as.numeric(JSONData$years$year), times = length(plrScores[[i]]$rndNum))
      plrScores[[i]]$name <- paste(JSONData$years$tours[[1]]$trns[[1]]$plrs[[1]]$alphaKeyFirst[i], JSONData$years$tours[[1]]$trns[[1]]$plrs[[1]]$alphaKeyLast[i])
    }
  }  
  
  
  i = 1
  for(i in 1:length(plrScores))
  {
    temp <- rbind(temp, plrScores[[i]])
  }
  
  CompleteData <- rbind(CompleteData, temp)
  temp <- NULL
}

write.csv(CompleteData, file = "WGCData.csv")

