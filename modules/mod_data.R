server_data <- function(id,symbol,df) {
  moduleServer(
    id,
    function(session, input, output) {
      
      filtered_data <- reactive( {
        
        df |> 
          filter(symbol == symbol())
        
      })
      
      return(filtered_data)
      
    }
  )
}