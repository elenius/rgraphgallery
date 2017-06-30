date = "2017-06-30 10:00"
caption_header = "Large data scatterplot"
caption = "Trying to find a hidden pattern in large data"


# packages: load and if needed install
pkg <- c("dplyr", "tidyr", "ggplot2", "gridExtra")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}



# example to visualise large data
set.seed(123)
n.small <- 10000
d1 <- data_frame(x = rnorm(n.small, 100, 5), # runif(n.small, 80, 120),
                 y = 3 + x + sin(x)
                 )

n.large <- 200000
d2 <- data_frame(x = rnorm(n.large, 100, 5),  # runif(n.large, 80, 120),
                 y = 3 + x + rnorm(rnorm(n.large, 0, 10))
)

dat <- bind_rows(d1, d2)

grid.arrange(
  ggplot(dat) + aes(x = x, y = y) + geom_point(alpha = 0.005) + theme_bw(),
  ggplot(dat) + aes(x = x, y = y) + stat_bin_hex(bins = 300, alpha = 0.8) + theme_bw(),
  ncol = 2
)




