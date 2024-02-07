#setup to run every month

#last historical data is at least a month ago
last_histd <- lubridate::today() - months(1)

#end date is today, start date 3 years ago
end_ <- gsub(pattern = "-",replacement = "",x = lubridate::today())
start_ <- gsub(pattern = "-",replacement = "",x = (lubridate::today() - months(36)))


coin_list_new <- crypto2::crypto_list(only_active=TRUE) %>%
  dplyr::filter(last_historical_data>=last_histd)

coins_ <- crypto2::crypto_history(coin_list = coin_list_new,
                                  start_date = start_, end_date=end_, interval="30d")

readr::write_csv(coins_,"data/coin_dt.csv")
