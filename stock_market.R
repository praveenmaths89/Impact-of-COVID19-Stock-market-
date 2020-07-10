if (!require(BatchGetSymbols)) install.packages('BatchGetSymbols')
## Loading required package: BatchGetSymbols
## Loading required package: rvest
## Loading required package: xml2
## Loading required package: dplyr
## 
## Attaching package: 'dplyr'
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
## 
library(BatchGetSymbols)

# set dates
first.date <- Sys.Date()-120
last.date <- Sys.Date()
freq.data <- 'daily'
# set tickers
tickers <- c('FB','MMM','PETR4.SA','abcdef')

l.out <- BatchGetSymbols(tickers = tickers, 
                         first.date = first.date,
                         last.date = last.date, 
                         freq.data = freq.data,
                         cache.folder = file.path(tempdir(), 
                                                  'BGS_Cache') ) # cache in tempdir()
## 
print(l.out$df.control)


library(ggplot2)

p <- ggplot(l.out$df.tickers, aes(x = ref.date, y = price.close))
p <- p + geom_line()
p <- p + facet_wrap(~ticker, scales = 'free_y') 
print(p)



library(BatchGetSymbols)

first.date <- Sys.Date()-365
last.date <- Sys.Date()

df.SP500 <- GetSP500Stocks()
tickers <- df.SP500$Tickers
length(tickers)
l.out <- BatchGetSymbols(tickers = tickers,
                         first.date = first.date,
                         last.date = last.date)

print(l.out$df.control)
print(l.out$df.tickers)

stock_Data=data.frame(l.out$df.tickers)
stock_Data$ticker

#library(magicfor)               # load library
#magic_for(print, silent = TRUE) # call magic_for()

result1={}


for(i in unique(stock_Data$ticker))
  
{

stock_Data_subset1=subset(stock_Data,ticker==i)
stk_p=stock_Data_subset1


pbr_mm <- subset(stk_p, stk_p$ref.date > "2020-03-03")


pbr_ret <- diff(log(pbr_mm[,4]))
stock_avg=mean(pbr_ret)

Stock_tick=unique(pbr_mm$ticker)
result <- data.frame(cbind(Stock_tick,stock_avg))
result1=rbind(result1,result)

print(i)
print(mean(pbr_ret))
print(length(pbr_mm$price.close))


}

library(tidyverse)

my_data <- as_tibble(result1)
my_data

#Before_covid=my_data %>% arrange(stock_avg)
After_covid=my_data %>% arrange(stock_avg)

#After_covid=After_Covid19[order(-After_Covid19$`mean(pbr_ret)`),]
