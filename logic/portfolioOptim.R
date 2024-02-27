portOpt <- function(dt,risk){
  
  return_df <- dt |> 
    mutate(return = (close-open)/open) |> 
    select(date = timestamp,name,return) |> 
    tidyr::pivot_wider(names_from = name,values_from = return) |> 
    janitor::clean_names()
  
  
  return_df <- tbl2xts::tbl_xts(return_df)
  
  portfolio <- portfolio.spec(assets = colnames(dt))
  portfolio <- add.constraint(portfolio, type = "full_investment")
  portfolio <- add.constraint(portfolio, type = "long_only")
  portfolio <- add.objective(portfolio, type = "return", name = "mean")
  portfolio <- add.objective(portfolio, type = "risk", name = "StdDev", risk_aversion = risk)
  optimal_weights <- optimize.portfolio(dt, portfolio)
  
  df_result <- data.frame(weights = as.numeric(optimal_weights$weights),
             crypto = names(optimal_weights$portfolio$assets))
  
  return(df_result)
  
}

