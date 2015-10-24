date = "2015-09-09 16:00"
caption_header = "Scatterplot"
caption = "grouped with OLS lines"

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
  ggplot(iris) + aes(x=Sepal.Length, y=Petal.Length, fill=Species, colour=Species) +
  geom_point(alpha=0.9) + geom_smooth(method="lm") + theme_minimal()

plot(p)
