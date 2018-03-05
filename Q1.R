# dplyr manipulation for Question 1: Number of Oil Spills by Company
library(dplyr)

data <- as.data.frame(read.csv("data/database.csv", stringsAsFactors = FALSE))

total.by.company <- data %>% group_by(Operator.Name) %>% 
  summarize(n = n(), net.loss = sum(Net.Loss..Barrels.)) %>% 
  arrange(desc(net.loss))

colnames(total.by.company) <- c("Operator Name", "Number of Oil Spills", 
                                "Net Loss of Oil in Barrels")


