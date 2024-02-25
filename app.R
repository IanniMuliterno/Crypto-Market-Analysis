library(shiny)
library(plotly)
library(readr)

source("modules/mod_date_input.r")
source("modules/mod_input.r")
source("modules/mod_data.R")
source("modules/mod_priceplot.R")

coin_dt <- read_csv("data/coin_dt.csv")

ui <- fluidPage(
  theme = bslib::bs_theme(preset = "darkly"),
  titlePanel("Cryptocurrency Portfolio Optimization", windowTitle = "Crypto Dashboard"),
  sidebarLayout(
    sidebarPanel(
      ui_input(id = "cryptoSymbol",title= "Choose a Cryptocurrency:"),
      ui_date(id = "date_main",title = "Select Date Range:"),
      numericInput("riskPreference", 
                   label = "Risk Preference (0 to 1)",
                   value = 0.5),
      actionButton("optimizeBtn", "Optimize Portfolio (in progress)")
      
    ),
    mainPanel(
      bslib::card(ui_priceplot("price_plot"))
    )
  )
)


server <- function(input, output) {
  
  
  symbol_input <- server_input("cryptoSymbol",coin_dt)
  
  filtered_data <- server_data("filter_data",coin_dt,symbol_input)
  
  date_out <- server_date("date_main",filtered_data)
  
  server_priceplot("price_plot",filtered_data, date_out)
}

shinyApp(ui = ui, server = server)
