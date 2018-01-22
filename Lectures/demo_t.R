library(dplyr)
x_dists <- data.frame(x=seq(-2.5, 2.5, 0.01)) %>%
  mutate(dn = dnorm(x),
         dt_1 = dt(x, 1),
         dt_2 = dt(x, 2),
         dt_3 = dt(x, 3)
  )

x_df <- data.frame(x=rnorm(100), x_unif=runif(100))


?density

a <- density(x[1:20])


ggplot() +
  geom_line(data=x_dists, mapping=aes(x=x, y=dn)) +
  geom_density(data=x_df[1:5,], mapping=aes(x=x), color="red") +
  theme_classic(base_size=14) +
  ylab("density")


ggplot() +
  geom_line(data=x_dists, mapping=aes(x=x, y=dn)) +
  geom_line(data=x_dists, mapping=aes(x=x, y=dt_1), color="red") +
  geom_line(data=x_dists, mapping=aes(x=x, y=dt_2), color="orange") +
  geom_line(data=x_dists, mapping=aes(x=x, y=dt_3), color="blue") +
  theme_classic(base_size=14) +
  ylab("density")



l <- runif(40)
a <- t.test(l)
residuals(a)


plot(density(l-mean(l)))

qqnorm(l-mean(l))
qqline(l-mean(l))


b <- t.test(rnorm(10), rnorm(10,3))
residuals(b)


#Blackbird example
library(tidyr)
blackbird <- read.csv("./t_test/12e2BlackbirdTestosterone.csv") %>%
  mutate(Bird = 1:nrow(blackbird))
b_tidy <- gather(blackbird, When, Antibody, -c(Bird)) %>%
  filter((When %in% c("Before", "After")))

ggplot(data=b_tidy, aes(x=When, y=Antibody, group=Bird)) +
  geom_point(color="red") +
  geom_line() +
  theme_bw(base_size=18)

t.test(blackbird$dif)

ggplot(data=blackbird, aes(x=dif.in.logs)) +
  geom_histogram(bins=7)+
  theme_classic(base_size=17) +
  xlab("Log Difference (After-Before)")

ggplot(data=blackbird, aes(x=dif.in.logs)) +
  geom_density()+
  theme_classic(base_size=17) +
  xlab("Log Difference: After - Before")

qqnorm(blackbird$dif.in.logs-mean(blackbird$dif.in.logs))
qqline(blackbird$dif.in.logs-mean(blackbird$dif.in.logs))

p <- seq(0.000001,.99999999999, .001)
q <- qnorm(p)
d <- dnorm(q)
x <- seq(-3,3, .00001)
plot(x, dnorm(x), type="l", xlab="X", ylab="Density", lwd=2)
plot(p, q, xlab="Cummulative Density", ylab="X",
     type="l", lwd=2)
plot(p, q, xlab="Cummulative Density", ylab="X",lwd=2)

#Shrike Example
lizard <- read.csv("./t_test/12e3HornedLizards.csv", na.strings=".")


ggplot(data=lizard, aes(x=factor(Survive), y=Squamosal.horn.length, group=Survive)) +
  geom_boxplot() +
  xlab("Survived") +
  theme_classic(base_size=17)
