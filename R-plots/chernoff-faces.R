date = "2015-10-12 11:00"
caption_header = "Chernoff Faces"
caption = "Display multidimensional data"

# packages: load and if needed install
pkg <- c("aplpack", "datasets")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

faces(mtcars)

# See more information
# http://www.r-bloggers.com/facing-your-data/
