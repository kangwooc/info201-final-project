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
            marker = list(color = c('rgb(63, 191, 63)', 'rgb(222, 45, 38)',
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
  
  table.ndata <- reactive(table.data %>% 
                            filter(Accident.Year == input$selectYear) %>% 
                            filter(Accident.State == state.abb[match(input$selectState, state.name)]))
  
  
  output$money.donut <- renderPlotly({
    
    l <- list(
      font = list(
        family = "sans-serif",
        size = 10,
        color = "#000"),
      bgcolor = "#E2E2E2",
      bordercolor = "#FFFFFF",
      borderwidth = 2)
    
    plot_ly(report.long(), labels = ~Cost.Description, values = ~Cost) %>%
      add_pie(hole = 0.6) %>% 
      layout(title = 'Breakdown of Money Lost due to Oil Spill',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             margin = list(t=100), showlegend = TRUE, legend = l) %>%
      config(displayModeBar = F)
  })
  
  output$narrow.table <- renderTable(table.ndata(), striped = TRUE)
  # Q6
  output$stack <- renderPlotly({
    plot_ly(stack.data, x = ~Accident.Year, y = ~Environmental.Remediation.Costs, name = 'Environmental Remediation Costs', type = 'scatter', mode = 'none',
                fill = 'tozeroy', fillcolor = '#f2ed71') %>%
          add_trace(y = ~Property.Damage.Costs, name = 'Property Damage Costs', fillcolor = '#f4c56c') %>%
          add_trace(y = ~Other.Costs, name = 'Other Costs', fillcolor = '#e79366') %>%
          add_trace(y = ~Public.Private.Property.Damage.Costs, name = 'Public Private Property Damage Costs', fillcolor = '#e36f61') %>%
          add_trace(y = ~Lost.Commodity.Costs, name = 'Lost Commodity Costs', fillcolor = '#d04972') %>%
          layout(title = 'Breakdown of costs for the oil spill',
                 xaxis = list(title = "Year",
                              showgrid = FALSE),
                 yaxis = list(title = "Expenditures (in dollars)",
                              showgrid = FALSE), width = 800, height = 400) %>% config(displayModeBar = F)
  })
}

shinyServer(server)