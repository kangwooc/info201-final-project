# server part
library(shiny)

source("Q1.R")

server <- function(input, output, session) {
  output$table <- renderTable({
    num.companies <- input$numin
    return(total.by.company[1:num.companies,])
  })
   
}

shinyServer(server)