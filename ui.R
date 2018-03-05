library(plotly)
library(shiny)
library(shinythemes)

ui <- fluidPage(
  includeCSS("www/css/style.css"),
  theme = shinytheme("yeti"),
  navbarPage(
    "Oil Spill Accident",
    tabPanel("OverView",
             img(id = "logo", src = "img/ad62.png", alt = "logo"),
             mainPanel(
                 h3("Overview of our report"),
                 p("For the final project, we are working with data of Oil Pipeline Accidents and/or spills in the United
                   States, from 2010 to present day. The data references the locations of the spills, the corporations
                   managing the pipelines, causes for the spills, the total costs resulting in these spills, among other
                   factors. The data used was collected and published by the", a(href = 'https://www.kaggle.com/usdot/pipeline-accidents', "US Department of Transportation", ".")),
                 p("The data is focused on past spills, the basic details about the spills, including location, date, time,
                   loss of oil and the impact (in terms of USD) of the oil spills. Looking through the data allows us
                   insights into patterns and trends of the oil spills and provide a monetary glimpse of their impact. In
                   learning these things, we will be able to provide to our clients, specific data about oil spills in general
                   as well as a in-depth report on any particular spill."),
                 h3("Questions"),
                 p(tags$ol(
                     tags$li("Which corporations are responsible for the oil spills?"),
                     tags$li("Where have these oil spills occurred and what kind of pipeline was it?"),
                     tags$li("Is there a specific kind/type of oil that has been involved in the oil spills?"),
                     tags$li("What are the causes of these oil spills?"),
                     tags$li("What was the monetary impact of the spill?")
                   )
                 )
                 )
               ),
    tabPanel("Q1", h3("Which corporations are responsible for the oil spills?")),
    tabPanel("Q2", 
             h3("Where have these oil spills occurred and what kind of pipeline was it?"),
             sidebarLayout(
               sidebarPanel(
                 
               ),
               mainPanel(
                 plotlyOutput("map")
                 )
               )
             ),
    tabPanel("Q3",
             h3("Is there a specific kind/type of oil that has been involved in the oil spills?"),
             mainPanel( 
                plotlyOutput("barchart"),
                br(),
                h3("Description of Liquid Types: "), 
                p("Biofuel: Alternative fuel(including ethanol blends)"),
                p("CO2: Carbon Dioxide"), 
                p("Crude Oil: Unrefined petroleum"),
                p("HVL: Highly Volatile Liquids"), 
                p("Non-HVL: Gasses"))
            ),
    tabPanel("Q4",
             h3("What are the causes of these oil spills?")
             
             
             
             ),
    tabPanel("Q5", h3("What was the monetary impact of the spill?"))
)
)
  

  
shinyUI(ui)