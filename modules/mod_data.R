server_data <- function(id,df,symbol) {
  moduleServer(
    id,
    function(input, output,session) {
      
      filtered_data <- reactive( {
        req(symbol())
        df |> 
          filter(symbol == symbol()) 
        
      })
      
      return(filtered_data)
      
    }
  )
}