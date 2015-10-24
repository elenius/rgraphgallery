date = "2015-09-11 16:00"
caption_header = "Weigthed regression"
caption = ""

# packages: load and if needed install
pkg <- c("dplyr", "tidyr")
for(i in seq_along(pkg)) {
  if(!require(pkg[i], character.only = TRUE)) {
    install.packages(pkg[i])
    library(pkg[i], character.only = TRUE)
  }
}

# example to visualise weighted regression
set.seed(123)
d1 <- data_frame(x= rnorm(100, 100, 5),
                 y = 3 + 2*x + rnorm(100, 0, 10))

# adding weights on deviating observations
d1 <-
  d1 %>%
  mutate(weights = ifelse((x < 100 & y> 200) | (x>100 & y < 200), 25, 1),
         max_weight = max(weights)
  )

reg.mod <- lm(y~x, data=d1, weights=weights) # not needed for plotting

p <-
  ggplot(d1) + aes(x=x, y=y) +
  scale_size_area() +
  geom_point(aes(size=sqrt(weights))) + # , alpha=sqrt(weights)/sqrt(max_weight))) +
  theme_minimal() +
  theme(legend.position="none") +
  geom_smooth(method="lm",  aes(weight=weights), colour="darkgreen") +
  geom_smooth(method="lm")

plot(p)
