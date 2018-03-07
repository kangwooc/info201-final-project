# server part
library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)
library(tidyr)
source("source.R")

server <- function(input, output, session) {
  # Question 1 Table output
  output$table <- renderTable({
    num.companies <- input$numin
    return(total.by.company[1:num.companies,])
  })
  # Question 2 
  map.data <- reactive(filter(oil.data, Accident.Year == input$yearSlider))
  
  output$map <- renderPlotly({
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showLand = TRUE
    )
    p <- plot_geo(map.data(), lat = ~Accident.Latitude, lon = ~Accident.Longitude) %>%
      add_markers(text = ~hover, color = I("red"), symbol=I("circle"), size=I(5)) %>%
      layout(
        geo = g
      ) %>% config(displayModeBar = F)
    return (p)
  })
  
  # renderPlotly() also understands ggplot2 objects! code for question 3
  output$barchart <- renderPlotly({
    plot_ly(specific.oil.shortened, x = ~LiquidTypes, y = ~n, type = 'bar', 
            text = specific.oil.shortened$n, textposition = 'auto',
            marker = list(color = c('rgb(63, 191, 63)', 'rgba(222,45,38,0)',
                                    'rgb(191, 63, 191)', 'rgb(246, 165, 84)',
                                    'rgb(84, 246, 246)'))) %>%
      layout(title = "Total Number of Liquid Types",
             xaxis = list(title = "Liquid Types"),
             yaxis = list(title = "Total Incidents for each Liquid Type")) %>%
      config(displayModeBar = F)
  })
  
  # Q4
  
  # Q5
  select.report <- reactive(filter(oil.data, Report.Number == input$Report.Number))
  
  report.long <- reactive(gather(select.report(), key = "Cost.Description", value = "Cost",Property.Damage.Costs,
                                 Lost.Commodity.Costs, Public.Private.Property.Damage.Costs, 
                                 Emergency.Response.Costs,Environmental.Remediation.Costs, Other.Costs) %>%
                            select(Cost.Description, Cost) %>% filter(Cost > 0))
  table.data <- oil.data %>% select(Report.Number, Accident.Year,
                                    Accident.City, Accident.County, 
                                    Accident.State, Operator.Name, Liquid.Type)
  
  table.ndata <- reactive(table.data %>% 
                            filter(Accident.Year == input$selectYear) %>% 
                            filter(Accident.State == state.abb[match(input$selectState, state.name)]))
  
  output$money.donut <- renderPlotly({
    plot_ly(report.long(), labels = ~Cost.Description, values = ~Cost) %>%
      add_pie(hole = 0.6) %>% 
      layout(title = 'Breakdown of Money Lost due to Oil Spill',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             margin = list(t=100)) %>%
      config(displayModeBar = F)
  })
  
  output$narrow.table <- renderTable(table.ndata(), striped = TRUE)
}

shinyServer(server)
