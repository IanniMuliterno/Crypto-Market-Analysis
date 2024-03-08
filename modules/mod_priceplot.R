library(dplyr)
library(echarts4r)

ui_priceplot <- function(id) {
  ns <- NS(id)
  echarts4rOutput(ns("pricePlot"))
  
}

server_priceplot <- function(id,df,date_output) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$pricePlot <- renderEcharts4r({
        
        df() |> 
          filter(between(timestamp,date_output()[1], date_output()[2])) |>  
          mutate(timestamp = substr(timestamp,1,10)) |> 
          group_by(name) |> 
          arrange(timestamp) |> 
          e_charts(timestamp, timeline = TRUE) |> 
          e_candle(open, close, low, high, name = "crypto prices") |> 
          #e_datazoom(type = "slider",top = 0) |> 
          e_title(("Candlestick chart for opening and closing prices"),textStyle = list(color = "white")) |> 
          e_tooltip() |> 
          e_text_style(color = "white") |>
          e_legend(show = FALSE)
        
      })
      
    }
  )
}