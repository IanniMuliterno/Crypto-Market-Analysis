library(shiny)
library(lubridate)


ui_date <- function(id,title) {

    ns <- NS(id)
    dateRangeInput(ns("date_input"),
    label = title,
    start = today() - months(30), end = today(),
    separator = "-")
}


server_date <- function(id, df) {

    moduleServer(
        id = id,
        module = function(input,output,session) {
            
         reactive( {
            req(df())
           
            start_input <- max(df()$timestamp) - months(1)
            end_input <- max(df()$timestamp)
            min_input <- min(df()$timestamp)
            
            updateDateRangeInput(session = session, "date_input",
                                 start = start_input,
                                 end = end_input,
                                 min = min_input,
                                 max = end_input)
            
          })
          
          selected_date <- reactive({input$date_input})
          return(selected_date)
          
        }
    )
}