date = "2015-09-01 10:00"
caption_header = "Percentage plot"
caption = "Plot från Almedalen 2014"

# packages: load and if needed install
pkg <- c("dplyr", "data.table", "ggplot2", "reshape2")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

dat <-
  structure(list(
    group =
      structure(c(1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 3L, 4L, 4L, 4L),
                .Label = c("Lön (heltid)", "Taxerad förvärvsinkomst",
                           "Pension", "Allmän pension"),
                class = "factor"),
    variable =
      structure(c(1L, 2L, 3L, 1L, 2L, 3L, 1L, 2L, 3L, 1L, 2L, 3L),
                class = "factor",
                .Label = c("Kvinnor",
                           "Män", "Medel")),
    value = c(26800L, 31200L, 29000L, 14886L, 20027L, 17444L, 12612L, 17722L,
              14874L, 8603L, 11642L, 9948L)
  ),
  .Names = c("Group",
             "variable", "value"),
  row.names = c(NA, -12L),
  class = "data.frame")

# comment: very ugly code for this plot
mean.group.plot <- function(dat,
                            box.color=c(rgb(227/255,73/255,18/255),
                                        rgb(239/255,130/255,0/255)),
                            text.size=0.8,
                            text.adjust=700) {
  dat <- data.table(dat)
  colors()[grep("grey", colors())]
  dat.1 <- dat[variable=="Medel", ]
  dat.2 <- dat[variable!="Medel", ]
  dat.2 <- droplevels(dat.2)
  dat.g <- group_by(dat, Group)
  dat.g <-  summarise(dat.g,
                      Män =
                        round(100*(value[variable=="Män"] /
                                     value[variable=="Medel"] - 1), 1),
                      Kvinnor = round(100*(value[variable=="Kvinnor"] /
                                             value[variable=="Medel"] - 1), 1)
  )
  dat.g <- melt(as.data.frame(dat.g), id.vars=c("Group"))
  dat.g <- data.table(dat.g)
  outer.group <- levels(dat.2$Group)
  length.outer.group <- length(outer.group)
  y.lim <- c(min(dat$value)-text.adjust, max(dat$value)*1.05)
  # start chunk ####
  par(las=1, mar=c(0, 5, 0, 0) + 0.1) # , bg=rgb(239/255,130/255,0/255, 0.2))
  plot(c(0, length.outer.group+1), y.lim, type="n", xlab="",
       ylab="medelinkomst per månad (kr)",
       axes=FALSE)
  mtext(prettyNum(dat.1$value, big.mark= " "), side=2, at=dat.1$value,
        cex=text.size)
  for(i1 in seq_along(outer.group)){
    inner.group <- levels(dat.2$variable)
    inner.length <- length(inner.group)
    y.group.max <- max(dat.2[Group==outer.group[i1], value])
    text(i1+0.6, y.group.max+text.adjust, outer.group[i1], cex=text.size,
         srt=0, pos=2)
    for(i2 in seq_along(inner.group)){
      ytop <- dat.2[Group==outer.group[i1] & variable==inner.group[i2], value]
      ybottom <- dat.1[Group==levels(dat.2$Group)[i1], value]
      rect(i1-0.5 + (i2-1)/inner.length, ybottom, i1-0.5 + i2/inner.length,
           ytop, col=box.color[i2], border=NA)
      y.perc.number <- min(c(ytop, ybottom))
      x.perc.number <- mean(c(i1-0.5 + i2/inner.length,
                              i1-0.5 + (i2-1)/inner.length))
      perc.number <- dat.g[Group==outer.group[i1] & variable==inner.group[i2],
                           value]
      perc.number <- ifelse(perc.number>0, paste("+", perc.number, sep=""),
                            perc.number)
      text(x.perc.number, y.perc.number, paste(perc.number, "%", sep=""), pos=1,
           cex=text.size)
    }

  }
  legend(length.outer.group, max(dat$value), col=box.color, fill=box.color,
         legend=inner.group, border=NA, cex=text.size, bty="n")

}

mean.group.plot(dat)
