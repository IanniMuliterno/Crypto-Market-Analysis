library(shiny)
library(plotly)

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
      selectInput("cryptoSymbol", "Choose a Cryptocurrency:",
                  choices = c("BTC", "ETH", "LTC", "XRP")), # Add more as needed
      dateRangeInput("dateRange", "Select Date Range:",
                     start = Sys.Date() - 30, end = Sys.Date())
    ),
    mainPanel(
      plotlyOutput("pricePlot")
    )
  )
)


server <- function(input, output) {
  output$pricePlot <- renderPlotly({

    
    plot_ly(data = ,x = ~dates, y = ~prices, 
    type = 'scatter', mode = 'lines+markers',
            marker = list(size = 10),
            line = list(color = 'blue')) %>%
      layout(title = paste("Price Trend for", input$cryptoSymbol),
             xaxis = list(title = "Date"),
             yaxis = list(title = "Price (USD)"))
  })
}

shinyApp(ui = ui, server = server)
