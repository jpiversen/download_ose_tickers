
library(tidyverse)
library(rvest)
library(polite)
library(lubridate)
library(portfolioBacktest)


# Get and clean companies -------------------------------------------------

# Get url to wikipedia page "List of companies listed on the Oslo Stock Exchange"
url <- bow("https://en.wikipedia.org/wiki/List_of_companies_listed_on_the_Oslo_Stock_Exchange")

# Get XPath to table
xpath <- "/html/body/div[3]/div[3]/div[4]/div/table[2]"

# Download table
ose_companies_raw <- url %>% 
  scrape(accept = "html") %>% 
  html_node(xpath = xpath) %>% 
  html_table() %>% 
  as_tibble()

# Clean table
ose_companies <- ose_companies_raw %>% 
  # Clean names
  janitor::clean_names(case = "sentence", sep_out = "_") %>% 
  # Rename industry
  rename(
    Industry = "Gics_industry_5"
  ) %>% 
  # Clean Ticker and Company values
  mutate(
    Ticker = str_replace(string = Ticker, pattern = "^OSE: ", ""),
    Ticker = paste0(Ticker, ".OL"),
    Company = str_replace(string = Company, pattern = "\\*$", replacement = "")
  ) %>% 
  # Fix known errors
  mutate(
    Ticker = case_when(
      Ticker == "EVRY.OL" ~ "TIETOO.OL",
      TRUE ~ Ticker
    )
  )

# Define character vector of Tickers
ose_symbols <- ose_companies$Ticker


# Download stock data -----------------------------------------------------

# This is only included as an example

# Define date of yesterday (yyyy-mm-dd). Will be used as "to date"
yesterday <- today() %m-% days(1)

# Download stock data from the last 3 years
ose_stocks <- stockDataDownload(stock_symbols = ose_symbols,
                                from = yesterday %m-% years(3), 
                                to  =   yesterday, 
                                local_file_path = NULL)


