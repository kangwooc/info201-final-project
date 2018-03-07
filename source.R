library(dplyr)

oil.data <- read.csv('data/database.csv', stringsAsFactors = FALSE)

# Q1
total.by.company <- oil.data %>% group_by(Operator.Name) %>% 
  summarize(n = n(), net.loss = sum(Net.Loss..Barrels.)) %>% 
  arrange(desc(net.loss))

colnames(total.by.company) <- c("Operator Name", "Number of Oil Spills", 
                                "Net Loss of Oil in Barrels")

# Q2
oil.data$hover <- with(oil.data, paste(state.name[match(Accident.State, state.abb)], '<br>', "County: ", Accident.County, 
                                       '<br>', "City: ", Accident.City,
                                       '<br>', "Monetary impacts: ", All.Costs, 
                                       '<br>', "Report Number:", Report.Number))
oil.map <- select(oil.data, Accident.Year, Operator.Name, Liquid.Type, 
                  Accident.State, Accident.City, Accident.Latitude, 
                  Accident.Longitude, All.Costs)

# Q3
operator.total <- oil.data %>% group_by(Operator.Name) %>% tally()

specific.oil <- oil.data %>% group_by(Liquid.Type) %>% tally()

specific.oil.shortened <- data_frame(LiquidTypes = c("BIOFUEL", "CO2",
                                                     "Crude Oil", "HVL",
                                                     "Non-HVL"), n = specific.oil$n)
companies.total <- NROW(total.by.company$`Operator Name`)

# Q4

incorrect.operation <- oil.data %>% filter(Cause.Category == "INCORRECT OPERATION") %>% nrow()
corrsion <- oil.data %>% filter(Cause.Category == "CORROSION") %>% nrow()
natural.force.damage <- oil.data %>% filter(Cause.Category == "NATURAL FORCE DAMAGE") %>% nrow()
material.failures <- oil.data %>% filter(Cause.Category == "MATERIAL/WELD/EQUIP FAILURE") %>% nrow()
excavation.damage <- oil.data %>% filter(Cause.Category == "EXCAVATION DAMAGE") %>% nrow()
other.damage <- oil.data %>% filter(Cause.Category == "ALL OTHER CAUSES") %>% nrow()

# Q5
listOfStates <- unique(oil.data$Accident.State)
listOfStates <- state.name[match(listOfStates, state.abb)]
table.data <- oil.data %>% select(Report.Number, Accident.Year,
                                  Accident.City, Accident.County, 
                                  Accident.State, Operator.Name, Liquid.Type)

# Q6
stack.data <- group_by(oil.data, Accident.Year) %>% 
  summarise(Property.Damage.Costs = sum(Property.Damage.Costs, na.rm = TRUE),
            Lost.Commodity.Costs = sum(Lost.Commodity.Costs, na.rm = TRUE),
            Public.Private.Property.Damage.Costs = sum(Public.Private.Property.Damage.Costs, na.rm = TRUE), 
            Emergency.Response.Costs = sum(Emergency.Response.Costs, na.rm = TRUE), 
            Environmental.Remediation.Costs = sum(Environmental.Remediation.Costs, na.rm = TRUE), 
            Other.Costs = sum(Other.Costs, na.rm = TRUE))