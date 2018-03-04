# server part
library(shiny)
data <- as.data.frame(read.csv("data/database.csv"), ) 
server <- function(input, output, session) {
  
}

shinyServer(server)