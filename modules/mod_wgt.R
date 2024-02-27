library(echarts4r)
library(PortfolioAnalytics)

source('logic/portfolioOptim.R')

UI_weight <- function(id) {
  ns <- NS(id)
  echarts4rOutput(ns("wgt_plot"))

}

server_weight <- function(id,dt,risk) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$wgt_plot <- renderEcharts4r({
        
        req(dt())
        
        portOpt(dt(),risk) |> 
          e_charts(crypto) |> 
          e_bar(weights, barWidth = '50%') |>
          e_title("Portfolio Weights") |>
          e_x_axis(name = "Assets") |>
          e_y_axis(name = "Weights", axisLabel = list(formatter = "{value} %")) |>
          e_tooltip(trigger = "axis", axisPointer = list(type = "shadow")) 

        
      })
      
    }
  )
}