library(shiny)



ui_input <- function(id,title,choice_list) {

    ns <- NS(id)
    selectInput(ns("s_input"),
    title = title,
    choices = choice_list)
}


server_input <- function(id, df) {

    moduleServer(
        id = id,
        module = function(session,input,output) {
            
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