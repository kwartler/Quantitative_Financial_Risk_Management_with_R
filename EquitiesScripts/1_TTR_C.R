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
df          <- data.frame(CMG$CMG.Close,CMGma10)
df$tradeSig <- Lag(ifelse(df$CMG.Close > df$SMA  , 1, 0)) # not discussing short selling (-1)
?Lag


# Examine
df[9:12,] # row 10 is NA for Lag.1 due to Lag()
tail(df,25)

# Manually reviewing this section
#               CMG.Close SMA     Lag.1
# 2018-05-25    428.96    433.202     1
# 2018-05-29    433.01    433.997     0
#
# 2018-06-21    463.16    463.241     1
# 2018-06-22    469.94    464.897     0

# Now let's do it for a longer time frame
getSymbols("CMG")
CMG         <- CMG['2018-01-01/']
CMGma10     <-SMA(CMG$CMG.Close, 10)
tradeSignal <- Lag(ifelse(CMG$CMG.Close > CMGma10  , 1, 0))
ret         <- ROC(Cl(CMG))*tradeSignal #Rate of Change TTR::ROC()


# Review your return
charts.PerformanceSummary(ret)

# Now let's be knight cap and switch a sign!
tradeSignal <- Lag(ifelse(CMG$CMG.Close < CMGma10  , 1, 0))
ret         <- ROC(Cl(CMG))*tradeSignal #Rate of Change TTR::ROC()

# Review your return
charts.PerformanceSummary(ret)

# End
