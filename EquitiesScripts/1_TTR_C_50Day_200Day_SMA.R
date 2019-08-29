#' Author: Ted Kwartler
#' Date: 6-22-2018
#' Purpose: Simple Moving Avg Example As Indicator
#'

# Opts
options(scipen=999)

# Libs
library(TTR)
library(quantmod)
library(PerformanceAnalytics)

# Get Chipotle
getSymbols("CRM")
CMG <- CRM['2018-03-01/2019-06-22'] 

# Calculate moving averages
CMGma50  <- SMA(CMG$CRM.Close, 50)
CMGma200 <- SMA(CMG$CRM.Close, 200)

# Organize data
df        <- data.frame(CMG$CRM.Close, CMGma50, CMGma200)
names(df) <- c('CMGclose', 'sma50', 'sma200')

# Construct a trading rule; 1 = buy or stay in stock, 0 = sell
# Not discussing shorting a stock (-1)
df$tradeSig <- Lag(ifelse(df$sma50 > df$sma200, 1, 0)) 
?Lag

# Examine
df[199:205,]
tail(df,25)
summary(df$tradeSig)


# Manually reviewing this section
#                 CMG.Close SMA     Lag.1
# Buy :2018-05-31    430.18 433.553     1
# Sell:2018-06-01    438.62 433.557     0
#
# Buy :2018-06-04    443.83 434.745     1
# Sell:2018-06-22    469.94 464.897     0

# Now let's do it for a longer backtest
getSymbols("CMG")
CMG <- CMG['2018-01-01/']
CMGma50 <-SMA(CMG$CMG.Close, 50)
CMGma200 <-SMA(CMG$CMG.Close, 200)

tradeSignal <- Lag(ifelse(CMGma50 > CMGma200  , 1, 0))
ret <- ROC(Cl(CMG))*tradeSignal #Rate of Change TTR::ROC()


# Review your return
charts.PerformanceSummary(ret)

# Now let's be knight cap and switch a sign!
getSymbols("CMG")
CMGma50 <- SMA(CMG$CMG.Close, 50)
CMGma200 <- SMA(CMG$CMG.Close, 200)
tradeSignal <- Lag(ifelse(CMGma50 < CMGma200  , 1, 0))
ret <- ROC(Cl(CMG))*tradeSignal #Rate of Change TTR::ROC()


# Review your return
charts.PerformanceSummary(ret)

# End
