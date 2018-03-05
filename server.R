# server part
library(maps)
library(maptools)
library(shiny)
library(plotly)
library(dplyr)
oil.data <- read.csv('data/database.csv', stringsAsFactors = FALSE)

# Q1
total.by.company <- oil.data %>% group_by(Operator.Name) %>% 
  summarize(n = n(), net.loss = sum(Net.Loss..Barrels.)) %>% 
  arrange(desc(net.loss))

colnames(total.by.company) <- c("Operator Name", "Number of Oil Spills", 
                                "Net Loss of Oil in Barrels")
# Q2
# oil.data$hover <- with(oil.data, paste())

# Q3

operator.total <- oil.data %>% group_by(Operator.Name) %>% tally()

specific.oil <- oil.data %>% group_by(Liquid.Type) %>% tally()

specific.oil.shortened <- data_frame(LiquidTypes = c("BIOFUEL", "CO2",
                                                     "Crude Oil", "HVL",
                                                     "Non-HVL"), n = specific.oil$n)

server <- function(input, output, session) {

  # Question 1 Table output
  output$table <- renderTable({
    num.companies <- input$numin
    return(total.by.company[1:num.companies,])
  })
  # Q2 
  #output$map <- renderPlotly({
  #    
  #})
  
  # renderPlotly() also understands ggplot2 objects! code for question 3
  output$barchart <- renderPlotly({
    plot_ly(specific.oil.shortened, x = ~LiquidTypes, y = ~n, type = 'bar',
            marker = list(color = c('rgb(63, 191, 63)', 'rgba(222,45,38,0)',
                                    'rgb(127, 63, 191)', 'rgb(246, 165, 84)',
                                    'rgb(84, 246, 246)'))) %>%
      layout(title = "Total Number of Liquid Types",
             xaxis = list(title = "Liquid Types"),
             yaxis = list(title = "Total Incidents for each Liquid Type"))
  })
  
  # Q4
  
  # Q5
}

shinyServer(server)
