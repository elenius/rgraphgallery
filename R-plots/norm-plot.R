date = "2015-09-06 16:00"
caption_header = "Norm plot hexbin"
caption = ""

# packages: load and if needed install
pkg <- c("hexbin", "ggplot2", "gridExtra", "dplyr", "tidyr")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

norm_plot <- function(x) {

  n <- length(x)
  i <- seq(1, n, by=1)
  prob.seq <- (i-0.5)/n
  inv.cdf <- qnorm(prob.seq, 0, 1)
  x.normalize <- (x - mean(x))/sd(x)
  df <- data_frame(empirical=sort(x),
                   empirical.normalized=sort(x.normalize),
                   normal=inv.cdf)

  dfl <-
    df %>% dplyr::select(-empirical) %>%
    gather(., cdf, value) %>%
    tbl_df

  a <- ggplot(df) + aes(x=normal, y=empirical.normalized) + stat_binhex() +
    geom_smooth(method="lm") + theme_minimal() +
    ggtitle("QQ-Plot")

  b <- ggplot(dfl) + aes(x=value, colour=cdf, fill=cdf) + stat_ecdf() +
    theme_minimal() + theme(legend.title=element_blank(), legend.position="top") +
    ggtitle("ECDF")

  c <- ggplot(dfl) + aes(x=value, colour=cdf, fill=cdf) + geom_density(alpha=0.3) +
    theme_minimal() + theme(legend.title=element_blank(), legend.position="top") +
    ggtitle("PDF")

  grid.arrange(a, b, c, ncol=2)

  # format(object.size(a), units="Mb")
  # format(object.size(b), units="Mb")
  # format(object.size(c), units="Mb")
}

# Example
set.seed(123)
x <- runif(10000,0,100) # sample data

norm_plot(x)
