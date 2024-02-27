server_data <- function(id,df,name) {
  moduleServer(
    id,
    function(input, output,session) {
      
      filtered_data <- reactive( {
        req(name())
        df |> 
          filter(name == name()) 
        
      })
      
      return(filtered_data)
      
    }
  )
}