date = "2015-08-31 16:00"
caption_header = "Densityplot with groups"
caption = ""

# packages: load and if needed install
pkg <- c("datasets", "ggplot2")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

# densityplot
data(iris)
p <-
  ggplot(iris) + aes(x=Sepal.Length, fill=cut_interval(Petal.Length, n = 5)) +
  geom_density(alpha=0.2) + theme_minimal()

plot(p)
