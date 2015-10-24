if(!require("png")) install.packages("png"); library("png")

# http://stackoverflow.com/questions/5504057/how-to-create-thumbnails-in-r
make_thumb <- function(project.path, fileName_png) {
  file.in <- file.path(project.path, "img", "large", fileName_png)
  file.out <- file.path(project.path, "img", "thumb", fileName_png)
  img <- readPNG(file.in)

  png(file = file.out, height = 150, width = 150)
  par(mar=c(0,0,0,0), xaxs="i", yaxs="i", ann=FALSE)
  plot(1:2, type='n', xaxt = "n", yaxt = "n", xlab = "", ylab = "")
  lim <- par()
  rasterImage(img, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
  dev.off()
}
