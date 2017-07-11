plot_top_metrics <- function(x, pod = NULL) {
    if(!is.null(pod)) {
        podname <- pod
    } else {
        podname <- x$podname
    }
    x %>% ggplot(aes(x = date, y = value, color = metric)) + geom_line() + 
        ggtitle(podname, "Earnings and Patrons")
}

plot_epp <- function(x, pod = NULL) {
    if(!is.null(pod)) {
        podname <- pod
    } else {
        podname <- x$podname
    }
    x %>%
        spread(metric, value) %>% 
        group_by(date) %>%
        summarize(epp = earnings/patrons) %>%
        ggplot(aes(x = date, y = epp)) + geom_line() + 
        ggtitle(podname, "Earnings Per Patron")
    
}
