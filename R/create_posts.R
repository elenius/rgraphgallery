create_posts <- function(
  project.path = getwd(),
  code.path="https://github.com/elenius/rgraphgallery/tree/gh-pages/R-plots"
) {

  # list R-code, thumbs and large
  lf <- list.files(file.path(project.path, "R-plots"))
  lt <- list.files(file.path(project.path, "img", "thumb")) # thumbs
  ll <- list.files(file.path(project.path, "img", "large")) # large


  # check if thumb or large png-files don't exist
  # then the R-code should be run
  d1 <- data.frame(name = gsub("\\.R", "", lf), lf=1)
  if(length(lt) > 0) {
    d2 <- data.frame(name = gsub("\\.png", "", lt), lt=1)
    } else d2 <- data.frame(name="", lt=NA)
  if(length(ll) > 0) {
    d3 <- data.frame(name = gsub("\\.png", "", ll), ll=1)
} else d3 <- data.frame(name="", ll=NA)

  df <- merge(merge(d1, d2, by="name", all.x = TRUE), d3, by="name", all.x = TRUE)
  df <-
    within(df,{
      OK = ifelse((!is.na(lt)) & (!is.na(ll)), 1, 0)
    })

  for(i in grep(0, df$OK)) {

    fileName_png <- gsub("\\.R$", "\\.png",  lf[i])

    # large image
    png(file.path("img", "large", fileName_png), width=600, height=500)
    source(file.path("R-plots", lf[i]))
    graphics.off()

    # thumbnail
    make_thumb(project.path, fileName_png)

    # create markdown posts
    fileName_md <- gsub("\\.R", "",  lf[i])
    fileName_md <- paste0(substr(date, 1, 10), "-", fileName_md, ".md")

    line1 <- "---"
    line2 <- "layout: default"
    line3 <- paste0("date: ", date)
    line4 <- paste("photo: ", fileName_png)
    line5 <- paste0('caption_header: <a href="' , code.path, '/', lf[i],'" target="_blank"','>',
                    caption_header, '</a>')
    line6 <- paste0("caption: ", caption)
    line7 <- line1

    sink(file.path("_posts", fileName_md))
    cat(paste(line1, line2, line3, line4, line5, line6, line7, sep="\n"))
    sink()

  }

}
