date = "2015-09-05 08:00"
caption_header = "Boxplot with jitter"
caption = ""

# packages: load and if needed install
pkg <- c("dplyr", "tidyr", "ggplot2")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

# example boxplot with jitter

n <- 1000
set.seed(123)
d1 <-
  data_frame(A = rnorm(n, -1, 2), B = rnorm(n, 5, 1), C = rexp(n, 1)) %>%
  gather(group, value)

p <-
  ggplot(d1) + aes(x=group, y=value, fill=group) +
  geom_jitter(position = position_jitter(width = .2), alpha=0.2, size=0.8) +
  geom_boxplot(outlier.size=0, alpha=0.1) +
  theme_minimal()

plot(p)
