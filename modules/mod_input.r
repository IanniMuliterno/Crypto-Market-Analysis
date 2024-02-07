library(shiny)



ui_input <- function(id,title) {

    ns <- NS(id)
    selectInput(ns("s_input"),
    label = title,
    choices = NULL)
}


server_input <- function(id, df) {

    moduleServer(
        id = id,
        module = function(input,output,session) {
            
            updateSelectizeInput(session, "s_input",
            choices = unique(df$symbol),
            server = TRUE)

            selected_value <- reactive( {
                 
                 input$s_input
                 
                  })

            return(selected_value)      

        }
    )
}