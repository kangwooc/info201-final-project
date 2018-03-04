# server part
library(shiny)

server <- function(input, output, session) {
  output$logoImage <- renderImage({
    list(src = "data/ad62.png",
         contentType = "image/png",
         width = 200,
         height = 200,
         alt = "logo",
         align = "center"
         )
  })  
}

shinyServer(server)