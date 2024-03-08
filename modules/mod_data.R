server_data <- function(id,df,name) {
  moduleServer(
    id,
    function(input, output,session) {
      
      filtered_data <- reactive( {
        
        validate(
          need(!is.null(name()), "Choose one or more crypto names to see opening/closing prices")
        )
        
        
        df |> 
          filter(name %in% name()) 
        
      })
      
      return(filtered_data)
      
    }
  )
}