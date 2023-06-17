data <- read.csv("charts.csv")
filteredData = data[data$rank <= 50, ]
top200Data = filteredData[filteredData$chart == "top200", ]
viral50Data = filteredData[filteredData$chart == "viral50", ]
unique(data$date)
top200USA = top200Data[top200Data$region == "United States", ]
viral50USA = viral50Data[viral50Data$region == "United States", ]
unique(top200USA$date)
top200_2020 = top200Data[substr(top200Data$date, 1, 4) == "2020", ]
viral50_2020 = viral50Data[substr(viral50Data$date, 1, 4) == "2020", ]
comparedf(top200_2020, viral50_2020)

top200_2020_USA = top200USA[substr(top200USA$date, 1, 4) == "2020", ]
viral50_2020_USA = viral50USA[substr(viral50USA$date, 1, 4) == "2020", ]
setdiff(viral50_2020_USA$title, top200_2020_USA$title)
unique(viral50_2020_USA$title)

top200R = top200Data[top200Data$region == "Romania" & substr(top200Data$date, 1, 4) == "2020", ]
viral50R = viral50Data[viral50Data$region == "Romania" & substr(top200Data$date, 1, 4) == "2020", ]
length(setdiff(viral50R$title, top200R$title))
length(unique(viral50R$title))

unique(data$region)
data_2020 = data[substr(data$date, 1, 4) == "2020", ]
data_2020$proportion <- NA

#by region averaging 2020
x = c(unique(data$region))
for(i in 1:70){
  top200RB = top200Data[top200Data$region == x[i] & substr(top200Data$date, 1, 4) == "2020", ]
  viral50RB = viral50Data[viral50Data$region == x[i] & substr(top200Data$date, 1, 4) == "2020", ]
  pd = length(setdiff(viral50RB$title, top200RB$title))/length(unique(viral50RB$title))
  data_2020$proportion[data_2020$region == x[i]] <- pd
}

#by region and by day
length(unique(data_2020$date))
x = c(unique(data$region))
y = c(unique(data_2020$date))
for(h in 1:366){
  for(i in 1:70){
    top200RB = top200Data[top200Data$region == x[i] & top200Data$date == y[h], ]
    viral50RB = viral50Data[viral50Data$region == x[i] & top200Data$date == y[h], ]
    pd = length(setdiff(viral50RB$title, top200RB$title))/length(unique(viral50RB$title))
    data_2020$proportion[data_2020$region == x[i] & data_2020$date == y[h]] <- pd
  }
}

unique(data_2020$proportion)
unique(data_2020$region)
df<-data.frame(unique(data_2020$region),unique(data_2020$proportion))

