date = "2015-09-04 16:00"
caption_header = "Box-, violinplot with jitter"
caption = ""

# packages: load and if needed install
pkg <- c("dplyr", "tidyr", "ggplot2")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

# example boxplot with violin and jitter

n <- 1000
set.seed(123)
d1 <-
  data_frame(A = rnorm(n, -1, 2), B = rnorm(n, 5, 1), C = rexp(n, 1)) %>%
  gather(group, value)


# box- and violinplot with jitter
p <-
  ggplot(d1) +
  aes(x=group, y=value, fill=group) +
  geom_jitter(position = position_jitter(width = 0.05, height=0.01), alpha=0.1, size=1) +
  geom_violin(alpha=0.1) +
  geom_boxplot(outlier.size=0, alpha=0.1, width=0.2) +
  theme_minimal() + xlab("") +
  coord_flip() +
  theme(legend.position="none")

plot(p)
