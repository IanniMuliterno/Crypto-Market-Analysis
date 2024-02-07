library(shiny)
library(lubridate)


ui_date <- function(id,title,choice_list) {

    ns <- NS(id)
    dateRangeInput(ns("date_input"),
    title = title,
    start = today() - months(36), end = today(),
    separator = "-")
}


server_date <- function(id, df) {

    moduleServer(
        id = id,
        module = function(session,input,output) {
            
           NULL

        }
    )
}