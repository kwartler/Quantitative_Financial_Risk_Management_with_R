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
getSymbols("CMG")
CMG <- CMG['2018-03-01/2018-06-22']

# Calculate the moving Avgs
CMGma10 <- SMA(CMG$CMG.Close, 10)

# Construct a trading rule
df <-data.frame(CMG$CMG.Close,CMGma10)
df$tradeSig <- Lag(ifelse(df$CMG.Close > df$SMA  , 1, 0)) # not discussing short (-1)
?Lag


# Examine
tail(df,25)

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
CMGma10 <-SMA(CMG$CMG.Close, 10)
tradeSignal <- Lag(ifelse(CMG$CMG.Close > CMGma10  , 1, 0))
ret <- ROC(Cl(CMG))*tradeSignal #Rate of Change TTR::ROC()


# Review your return
charts.PerformanceSummary(ret)

# Now let's be knight cap and switch a sign!
tradeSignal <- Lag(ifelse(CMG$CMG.Close < CMGma10  , 1, 0))
ret <- ROC(Cl(CMG))*tradeSignal #Rate of Change TTR::ROC()


# Review your return
charts.PerformanceSummary(ret)

# End
