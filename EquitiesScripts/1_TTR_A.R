#' Author: Ted Kwartler
#' Date: 6-22-2018
#' Purpose: Algo Trading Example
#' 

# Opts
options(scipen=999)

# Libs
library(TTR)
library(quantmod)
library(dygraphs)
library(htmltools)

## Get historical stock pricing
getSymbols("AAPL", src = "yahoo")

# Get list of all stocks available
#allTickers <- stockSymbols("NYSE") #AMEX, NASDAQ

# Review
head(AAPL)

# Quick Viz
barChart(AAPL) 

## Subsetting XTS
# Get a complete yr
oneYr <- AAPL["2017"] 
head(oneYr)
tail(oneYr)

#Extract data from Jan 17 to May 2018 
yrToMonth <- AAPL["2017/2018-05"]
head(yrToMonth)
tail(yrToMonth)

#Get Jan3 to June 21 2018
dateToDate <- AAPL["2018-01-03/2018-06-21"] 
head(dateToDate)
tail(dateToDate)

#Get all data until Dec 2016 
upUntil <- AAPL["/2016-12"] 
head(upUntil)
tail(upUntil)

# D3 Viz
dygraph(AAPL$AAPL.Close)  %>% dyRangeSelector()

candleAAPL <- AAPL[,1:4]
dygraph(candleAAPL) %>%
  dyCandlestick() %>% dyRangeSelector()

