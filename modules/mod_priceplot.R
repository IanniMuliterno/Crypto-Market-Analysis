library(dplyr)
library(plotly)

ui_priceplot <- function(id) {
  ns <- NS(id)
  plotlyOutput(ns("pricePlot"))

}

server_priceplot <- function(id,df,date_output) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$pricePlot <- renderPlotly({
        
        symbol_input <- df() |> 
          select(symbol) |> 
          slice(1) |> 
          pull()
        
        print(date_output())
        
        df() |> 
          filter(between(timestamp,date_output()[1], date_output()[2])) |>  
          plot_ly(x = ~timestamp, type="candlestick",
                              open = ~open, close = ~close,
                              high = ~high, low = ~low) |> 
          layout(title = paste(symbol_input,"Price Movements"),
                 xaxis = list(title = "Date"),
                 yaxis = list(title = "Price (USD)")) |> 
          layout(plot_bgcolor='black') |>  
          layout(paper_bgcolor='black')
        
      })
      
    }
  )
}