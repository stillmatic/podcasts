# libraries
library(jsonlite)
library(dplyr)
library(magrittr)
library(tidyr)
library(ggplot2)

source("processing.R")

# import data, process
chapo_tidy <- scrape_to_df("chapotraphouse")

# plotting
plot_top_metrics(chapo_tidy, "Chapo Trap House")

plot_epp(chapo_tidy, "Chapo Trap House")

top_pods <- purrr::map_df(c("chapotraphouse", "dtns", "lastpodcastontheleft",
                               "aufeinbier", "thedickshow", "theliturgistspodcast",
                               "canadaland", "doughboys", "thebestshow",
                               "dearhankandjohn", "radiowarnerd", "hellointernet",
                               "myfavoritemurder"),
              scrape_to_df)
top_pods %>%
    ggplot(aes(x = date, y = value, color = podname)) + 
    geom_line() +
    facet_wrap(~metric, scales = "free")
