# server part
library(shiny)
library(plotly)
library(dplyr)
# 
oil.data <- read.csv('data/database.csv', stringsAsFactors = FALSE)

# Q3


operator.total <- oil.data %>% group_by(Operator.Name) %>% tally()

specific.oil <- oil.data %>% group_by(Liquid.Type) %>% tally()

specific.oil.shortened <- data_frame(LiquidTypes = c("BIOFUEL", "CO2", 
                                                     "Crude Oil", "HVL", 
                                                     "Non-HVL"), n = specific.oil$n)


server <- function(input, output, session) {
  
  
  
  # renderPlotly() also understands ggplot2 objects! code for question 3
  output$plot <- renderPlotly({
    plot_ly(specific.oil.shortened, x = ~LiquidTypes, y = ~n, type = 'bar', 
            marker = list(color = c('rgb(63, 191, 63)', 'rgba(222,45,38,0)',
                                    'rgb(127, 63, 191)', 'rgb(246, 165, 84)',
                                    'rgb(84, 246, 246)'))) %>%
      layout(title = "Total Number of Liquid Types",
             xaxis = list(title = "Liquid Types"),
             yaxis = list(title = "Total Incidents for each Liquid Type"))
  })
}

shinyServer(server)