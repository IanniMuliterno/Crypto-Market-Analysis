library(echarts4r)
library(PortfolioAnalytics)

source('logic/portfolioOptim.R')

ui_weight <- function(id) {
  ns <- NS(id)
  echarts4rOutput(ns("wgt_plot"))

}

server_weight <- function(id,dt,risk,btn) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$wgt_plot <- renderEcharts4r({
        
        req(dt())
        req(btn())
        
        portOpt(dt(),risk()) |> 
          e_charts(crypto) |> 
          e_bar(weights, barWidth = '50%') |>
          e_title("Portfolio Weights",textStyle = list(color = "white")) |>
          e_x_axis(name = "Assets") |>
          e_y_axis(name = "Weights", axisLabel = list(formatter = "{value} %")) |>
          e_tooltip(trigger = "axis", axisPointer = list(type = "shadow")) |> 
          e_text_style(color = "white") |>
          e_legend(show = FALSE)

        
      })
      
    }
  )
}