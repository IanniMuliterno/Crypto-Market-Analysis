library(shiny)
library(plotly)
library(readr)

source("modules/mod_date_input.r")
source("modules/mod_input.r")
source("modules/mod_data.R")
source("modules/mod_priceplot.R")
source("modules/mod_risk.R")
source("modules/mod_wgt.R")

coin_dt <- read_csv("data/coin_dt.csv")

ui <- fluidPage(
  theme = bslib::bs_theme(preset = "darkly"),
  titlePanel("Cryptocurrency Portfolio Optimization", windowTitle = "Crypto Dashboard"),
  sidebarLayout(
    sidebarPanel(
      ui_input(id = "cryptoSymbol",title= "Choose a Cryptocurrency:"),
      ui_date(id = "date_main",title = "Select Date Range:"),
      ui_risk("risk_preferene"),
      actionButton("optimizeBtn", "Optimize Portfolio"),
      bslib::card("Welcome, this app applies the buy and hold strategy, let's you choose a level of risk, and suggest how you should distribute your investment capital to optimize return.")
      
    ),
    mainPanel(
      bslib::card(ui_priceplot("price_plot")),
      bslib::card(ui_weight("wgt_plot"))
    )
  )
)


server <- function(input, output) {
  
  
  symbol_input <- server_input("cryptoSymbol",coin_dt)
  
  filtered_data <- server_data("filter_data",coin_dt,symbol_input)
  
  date_out <- server_date("date_main",filtered_data)
  
  risk <- server_risk("risk_preferene")
  
  server_priceplot("price_plot",filtered_data, date_out)
  
  act_btn <- reactive({ input$optimizeBtn })
  
  server_weight("wgt_plot", filtered_data, risk, act_btn)
}

shinyApp(ui = ui, server = server)
