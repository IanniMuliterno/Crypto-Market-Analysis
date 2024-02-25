library(shiny)



ui_input <- function(id,title) {

    ns <- NS(id)
    selectizeInput(ns("s_input"),
    label = title,
    choices = NULL,
    multiple = TRUE)
}


server_input <- function(id, df) {

    moduleServer(
        id = id,
        module = function(input,output,session) {
          
          observe({
            
            updateSelectizeInput(session,
                                 "s_input",
                                 choices = unique(df$symbol),
                                 server = TRUE)
            
            
          })
            
            
            selected_value <- reactive( {
                 
                 input$s_input
                 
                  })

            return(selected_value)      

        }
    )
}