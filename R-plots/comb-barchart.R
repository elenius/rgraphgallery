date = "2015-09-03 12:00"
caption_header = "Disjunct combination barchart"
caption = ""


# packages: load and if needed install
pkg <- c("dplyr", "tidyr","ggplot2")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

set.seed(123)
size <- 100000
d1 <- data_frame(A = rbinom(size, 1, 0.9),
                 B = rbinom(size, 1, 0.7),
                 C = rbinom(size, 1, 0.5),
                 D = rbinom(size, 1, 0.1)
)



# disjunct combinations of groups
d1[] <- lapply(seq_along(d1), function(x) {
  ifelse(d1[,x] == 1, names(d1)[x], "")
})

d1 <-
  d1 %>%
  unite_("d_group", names(d1), sep="+") %>%
  mutate(
    d_group = gsub("\\+{1,}", "\\+", d_group),
    d_group = gsub("^\\+|\\+$", "", d_group)
  ) %>%
  group_by(d_group) %>%
  summarise(n=n()) %>%
  ungroup %>%
  mutate(p = 100 * n/sum(n)) %>%
  arrange(desc(n)) %>%
  mutate(d_group = factor(d_group, levels=d_group))

p <-
  ggplot(d1) + aes(x = d_group, y = p,
                   label=paste0(prettyNum(as.character(n), big.mark=" "),
                                " (", round(p, 1), "%)")) +
  # geom_point(size=3, aes(colour=pension)) +
  geom_bar(stat="identity", aes(colour=d_group, fill=d_group), width=0.2) +
  scale_y_continuous(lim=c(0, 35)) +
  geom_text(hjust=-0.1, size=3) + coord_flip() + ylab("") + xlab("") +
  theme_minimal() +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank(),
        legend.position = "none",
        axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = -0.05, vjust=1)
  ) + ggtitle(paste("Totalt ", prettyNum(as.integer(size), big.mark=" ")))

plot(p)
