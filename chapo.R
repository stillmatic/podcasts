# libraries
library(jsonlite)
library(dplyr)
library(magrittr)
library(tidyr)
library(ggplot2)

# import data, process
chapo <- jsonlite::read_json("chapo.json")
chapo <- 
    chapo %>% dplyr::bind_rows() %>% t() %>% data.frame() %>%
    tibble::rownames_to_column() %>% 
    rename(date = rowname, patrons = X1, earnings = X2)

chapo_tidy <- chapo %>% tidyr::gather(-date, key = "metric", value = "value")

chapo_tidy %<>% 
    mutate(date = as.POSIXct(as.numeric(date)/1000, origin = "1970-01-01"))

chapo_tidy$value <- chapo_tidy$value %>% unlist

# plotting
chapo_tidy %>%
    ggplot(aes(x = date, y = value, color = metric)) + geom_line() + 
    ggtitle("Chapo Trap House", "Earnings and Patrons")

chapo_tidy %>%
    spread(metric, value) %>% 
    group_by(date) %>%
    summarize(epp = earnings/patrons) %>%
    ggplot(aes(x = date, y = epp)) + geom_line() + 
    ggtitle("Chapo Trap House", "Earnings Per Patron")
