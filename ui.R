library(plotly)
library(shiny)
library(shinythemes)
source("source.R")

ui <- fluidPage(
  includeCSS("www/css/style.css"),
  theme = shinytheme("yeti"),
  navbarPage(
    "Oil Spill Accident",
    tabPanel("Overview",
             img(id = "logo", src = "img/ad62.png", alt = "logo"),
             mainPanel(
                 h3(class = "title", "Overview of our report"),
                 p("Our Group is working with data of Oil Pipeline Accidents and/or spills in the United
                   States, from 2010 to 2017. The data references the locations of the spills, the corporations
                   managing the pipelines, causes for the spills, the total costs resulting in these spills, among other
                   factors. The data used was collected and published by the", a(href = 'https://www.kaggle.com/usdot/pipeline-accidents', "US Department of Transportation", ".")),
                 p("The data is focused on past spills, the basic details about the spills, including location, date, time,
                   loss of oil and the impact (in terms of USD) of the oil spills. Looking through the data allows us
                   insights into patterns and trends of the oil spills and provide a monetary glimpse of their impact. In
                   learning these things, we will be able to provide to our clients, specific data about oil spills in general
                   as well as a in-depth report on any particular spill."),
                 h3(class = "title", "Questions"),
                 p(tags$ol(
                     tags$li("Which corporations are responsible for the oil spills?"),
                     tags$li("Where have these oil spills occurred and what kind of pipeline was it?"),
                     tags$li("Is there a specific kind/type of oil that has been involved in the oil spills?"),
                     tags$li("What are the causes of these oil spills?"),
                     tags$li("What was the monetary impact of the spill?"),
                     tags$li("What are the trends in the breakdown of the cost of oil spills?")
                   )
                 )
                 )
               ),

    tabPanel(
      "Q1",
      h3(class = "title", "Which corporations are responsible for the oil spills?"),
      sidebarLayout(
        sidebarPanel(
          numericInput("numin", paste0("Number of Companies [Max = ", companies.total,"]"), value = 10, min = 1, max = companies.total)
        ),
        mainPanel(
          tableOutput("table"),
          h4('Description'),
          p("We have provided a table that details the specific corporations that have been involved/responsible for these oil spills. Each corporation is accompanied with the specific number of oil spills that they have involved with, as well as the total net loss of oil in the barrels. The table is sorted based on the amount of net loss in oils per barrel and more companies can be viewed by increasing the number in the left panel.")
        )
      )
    ),
    tabPanel("Q2", 
             h3(class = "title", "Where have these oil spills occurred and what kind of pipeline was it?"),
             sidebarLayout(
               sidebarPanel(
                 sliderInput("yearSlider", label = "Years:", min = 2010, max=2017, value = 2010)
               ),
               mainPanel(
                 plotlyOutput("map"),
                 h4('Description'),
                 p("The map visualization provides locations of oil spills in the United States. It allows the user to gauge at patterns of how/where these oil spills occur.
                   Additionally, the year silder, (2010 ~ 2017), allows a way to contextualize the patterns and oil spills."),
                 p("This visualization shows that a large number of oil spills occur in the state of Texas, and helps us understand where we might want to focus on our efforts to prevent further oil spills.")
               )
            )
    ),
    tabPanel("Q3",
             h3(class = "title", "Is there a specific kind/type of oil that has been involved in the oil spills?"),
             sidebarLayout(
               sidebarPanel(
                 h5(strong("Description of Liquid Types: ")),
                 p(strong("Biofuel"), ": Alternative fuel (including ethanol blends)"),
                 p(strong("CO2"), ": Carbon Dioxide"),
                 p(strong("Crude Oil"), ": Unrefined petroleum"),
                 p(strong("HVL"), ": Highly Volatile Liquids"),
                 p(strong("Non-HVL"), ": Remaining Liquids/Gasses that are not highly-volitale")
               ),
               mainPanel(
                 plotlyOutput("barchart"),
                 h4("Description"),
                 p("The information displayed within the Bar Chart details 
                   the amount of each type of oil, described in the panel 
                   to the left, that have been involved in incidents regarding 
                   oil spills. Of the many incidents that have occurred throughout 
                   the years, one can see that the majority of oil spills revolve 
                   around 'Crude Oil'. This helps us understand that we need to focus on improving/upgrading our facilities that use crude oil")
               )
             )
    ),
    tabPanel("Q4",
             h3(class = "title", "What are the causes of these oil spills?"),
             tags$div(id = "counts",
             tags$div(
               class = "row section",
               tags$div(class = "col-sm-6",
                tags$div(class = "col-sm-3",
                  img(class = "q4", src = "img/id_not_verified.png")
                  ) 
                ,
                 tags$div(class = "col-sm-3",
                   h4("Incorrect Operation"),
                   p(class = "num", incorrect.operation)
                  )
               ),
               tags$div(class = "col-sm-6",
                 tags$div(class = "col-sm-3",
                   img(class = "q4", src = "img/settings3.png")
                   ),
                 tags$div(class = "col-sm-3",
                   h4("Equipment Failure"),
                   p(class = "num", material.failures)
                 )
               )
               ),
             tags$div(
               class = "row section",
               tags$div(class = "col-sm-6",
                 tags$div(class = "col-sm-3",
                         img(class = "q4", src = "img/spade.png")
                         ),
                 tags$div(class = "col-sm-3",
                   h4("Excavation Damage"),
                   p(class = "num", excavation.damage)
                 )
               ),
               tags$div(
                 class = "col-sm-6",
                 tags$div(class = "col-sm-3",
                          img(class = "q4", src = "img/test_tube.png")
                          ),
                 tags$div(class = "col-sm-3",
                             h4("Corrosion"),
                             p(class = "num", corrsion)
                           )
               )),
             tags$div(class = "col-sm-6",
                           tags$div(class = "col-sm-3",
                                    img(class = "q4", src = "img/tornado_filled.png"))
                           ,
                           tags$div(class = "col-sm-3",
                                    h4("Natural Disaster"),
                                    p(class = "num", natural.force.damage)
                           )
               ),
             tags$div(
               class = "row section",
               tags$div(class = "col-sm-6",
                        tags$div(class = "col-sm-3",
                                img(class = "q4", src = "img/other_causes.png")
                        ),
                        tags$div(class = "col-sm-3",
                                 h4("Other causes")
                                ,p(class = "num", other.damage)
                        )
                )
               )
             ),
             h4("Description"),
             p("This page displays the number of spills attributed to each one of these primary causes for oil spill accidents. 
                Knowing the most prevalent causes of mishap may help in identifying key problem areas in which the most improvement is needed. 
                We can clearly see that the most common cause for an oil spill is due to equipment failure, 
               this tells us that we need to be more vigilant in installing and mantaining equipment")
    ),
    tabPanel("Q5",
             h3(class = "title", "What was the monetary impact of the oil spill?"),
             sidebarLayout(
               sidebarPanel(
                 selectizeInput("Report.Number", label = "Report Number:",
                                choices = oil.data$Report.Number, 
                                multiple = FALSE),
                 p("This visualisation allows us to see a monetary breakdown of any particular oil spill,
                   it provides an insight into the effects of particular oil spills. We can clearly see that
                   the default oil spill (20100016), lost a lot of oil, but did not have large damage costs, or
                   environmental costs."),
                 p(class = "narrowdown", strong("-------------------------------Narrow Down------------------------------")),
                 selectizeInput("selectYear", label = "Accident Year:",
                                choices = c(2010:2017), 
                                multiple = FALSE),
                 
                 selectizeInput("selectState", label = "Accident State:",
                                choices = listOfStates, 
                                multiple = FALSE),
                 p("The table can be used to look up the specific case numbers by narrowing the search through selecting the year and state in which the spill took place. The donut chart then displays the breakdown for the specific oil spill.")
               ),
               mainPanel(
                 plotlyOutput('money.donut'),
                 br(), br(), br(), 
                 h4("Table to help you narrow down your search for particular oil spill"),
                 br(),
                 tableOutput('narrow.table')
               )
             )),
    tabPanel("Q6",
             h3(class = "title", "What are the trends in the breakdown of the cost of oil spills?"),
             mainPanel(
               plotlyOutput("stack"),
               h4("Description"),
               p("This area graph breaks down the cumulative cost of oil spills in each year into different categories, such as property damage costs and environmental reparation costs. Individual graphs of the costs can be displayed by clicking on the legend to remove and add area trendlines.
Over time we can see there seems to be a general decrease in the costs associated with oil spills, perhaps indicating a decrease in overall oil spills. Perhaps it is worth noting that the skew in the data or massive spike in environmental reparation costs in 2010 can likely be attributed to the Deepwater Horizon explosion, which resulted in the largest marine oil spill in history.")
               )
             )
    )
)

shinyUI(ui)
