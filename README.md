# Download tickers / stock data for the Oslo Stock Exchange
This project includes an R-script for downloading the tickers of all stocks at the Oslo Stock Exchange from [this Wikipedia-page](https://en.wikipedia.org/wiki/List_of_companies_listed_on_the_Oslo_Stock_Exchange). 

These tickers can then be used to download the stock prices with R-packages such as `quantmod`, `tidyquant`, or `portfolioBacktest`. 



## Renv for package management



This project uses `renv` for package mangement. New users should consider using 



```R
if (!require(renv)) install.packages("renv")

renv::restore()
```



See the [renv documentation](https://rstudio.github.io/renv/articles/renv.html) for more infomation about `renv`. 