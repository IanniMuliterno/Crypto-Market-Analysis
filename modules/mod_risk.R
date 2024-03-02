ui_risk <- function(id) {
  ns <- NS(id)
  
  numericInput("riskPreference", 
               label = "Risk Preference (0 to 1)",
               value = 0.5,
              min = 0,
              max = 1,
              step = 0.01)

}

server_risk <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      result <- reactive({
        
        input$riskPreference
        
      })
      
      return(result)
       
    }
  )
}