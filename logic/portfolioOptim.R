library(dplyr)
library(PortfolioAnalytics)
library(tbl2xts)

portOpt <- function(dt, risk) {
  
  # Calculate returns and pivot data
  return_df <- dt |>
    mutate(return = (close - open) / open) |>
    select(date = timestamp, name, return) |>
    tidyr::pivot_wider(names_from = name, values_from = return) |>
    janitor::clean_names()
  
  print(head(return_df)) # Print the head to check the structure
  
  # Convert to xts for portfolio optimization
  return_xts <- tbl2xts::tbl_xts(return_df)
  
  # Initialize portfolio with assets from the xts object
  portfolio <- portfolio.spec(assets = colnames(return_xts))
  portfolio <- add.constraint(portfolio, type = "full_investment")
  portfolio <- add.constraint(portfolio, type = "long_only")
  portfolio <- add.objective(portfolio, type = "return", name = "mean")
  portfolio <- add.objective(portfolio, type = "risk", name = "StdDev", risk_aversion = risk)
  
  # Optimization should be done on the returns, not the original data
  optimal_weights <- optimize.portfolio(return_xts, portfolio)
  # Create a dataframe of results
  df_result <- data.frame(weights = as.numeric(optimal_weights$weights)*100,
                          crypto = names(optimal_weights$portfolio$assets))
  
  return(df_result)
}
