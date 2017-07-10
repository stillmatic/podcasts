json_to_df <- function(x) {
    x <- 
        x %>% dplyr::bind_rows() %>%
        mutate(date = names(x))
    x_tidy <- x %>% tidyr::gather(-date, key = "metric", value = "value")
    x_tidy %<>% 
        mutate(date = as.POSIXct(as.numeric(date)/1000, origin = "1970-01-01"))
    x_tidy$value <- x_tidy$value %>% unlist
    return(x_tidy)
}