date = "2015-09-02 12:00"
caption_header = "Barchart"
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

# summarise individual group
d1 <-
  d1 %>%
  gather(group, n) %>%
  group_by(group) %>%
  summarise(n=sum(n)) %>%
  ungroup %>%
  mutate(p = 100 * n/size)

p <-
  ggplot(d1) + aes(x = group, y = p, label=paste0(round(p), "%")) +
  # geom_point(size=3, aes(colour=pension)) +
  geom_bar(stat="identity", aes(colour=group, fill=group), width=0.3) +
  scale_y_continuous(lim=c(0, 110)) +
  geom_text(hjust=-0.3) + coord_flip() + ylab("") + xlab("") + theme_minimal() +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank(),
        legend.position = "none",
        axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = -0.0, vjust=1),
        text = element_text(size=20)
  ) + ggtitle(paste("Totalt ", prettyNum(as.integer(size), big.mark=" ")))

plot(p)
