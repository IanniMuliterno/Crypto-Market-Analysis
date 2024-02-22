library(shiny)
library(plotly)
library(readr)

source("modules/mod_date_input.r")
source("modules/mod_input.r")
source("modules/mod_data.R")

coin_dt <- read_csv("data/coin_dt.csv")

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body { 
        background-color: #121212; 
        color: #E0E0E0; 
      }
      .navbar, .sidebar { 
        background-color: #1E1E1E; 
      }
      .well { 
        background-color: #333333; 
        border-color: #333333; 
      }
      .shiny-input-container > label, .shiny-input-container > .selectize-control > .selectize-dropdown > .selectize-dropdown-content > .option {
        color: #E0E0E0; 
      }
      .shiny-plot-output {
        background-color: #121212; 
      }
    "))
  ),
  titlePanel("Cryptocurrency Market Analysis Dashboard", windowTitle = "Crypto Dashboard"),
  sidebarLayout(
    sidebarPanel(
      ui_input(id = "cryptoSymbol",title= "Choose a Cryptocurrency:"),
      ui_date(id = "date_main",title = "Select Date Range:")
      
    ),
    mainPanel(
      plotlyOutput("pricePlot")
    )
  )
)


server <- function(input, output) {
  
  
  symbol_input <- server_input("cryptoSymbol",coin_dt)
  
  filtered_data <- server_data("filter_data",symbol_input,coin_dt)
  
  server_date(id = "date_main",filtered_data)
  
  output$pricePlot <- renderPlotly({
    
    coin_plot <- coin_dt[coin_dt$symbol == symbol_input(), ]
    
    coin_plot |>  plot_ly(x = ~timestamp, type="candlestick",
                            open = ~open, close = ~close,
                            high = ~high, low = ~low) |> 
      layout(title = paste(symbol_input(),"Price Movements"),
             xaxis = list(title = "Date"),
             yaxis = list(title = "Price (USD)")) |> 
      layout(plot_bgcolor='black') |>  
      layout(paper_bgcolor='black')
    
  })
}

shinyApp(ui = ui, server = server)
