library(dplyr)
library(ggplot2)

fingernail_avg <- data_frame(x=seq(0.2, 10.2, .01), ymin=0)
fingernail_avg <- mutate(fingernail_avg, y=dnorm(x, 5,2))

fd <- ggplot() +
  geom_line(data=fingernail_avg, mapping=aes(x=x, y=y), lwd=1.3) +
  xlab("\nFingernail Length") +
  ylab("Probability Density\n") +
  theme_bw(base_size=17) 
fd

fd2 <- fd + 
  geom_vline(xintercept=9.5, lwd=2, lty=2, color="red") +
  annotate(x=8, y=0.15, label="Mean Extreme =\n9.5", geom="text",
           size=4)
fd2

fd +
  geom_ribbon(data=fingernail_avg%>%filter(x>9.5), 
              mapping=aes(x=x, ymin=ymin, ymax=y),
              fill="red")

pnorm(9.5, 5,2, log=FALSE, lower.tail=FALSE)


### My measurements
set.seed(2002)
my_data <- rnorm(30, 9.5, 2)
hist(my_data, main = "Mean = 9.5",
     xlab="Fingernail Length (cm)", breaks=10)

pnorm(4.5, 0, 2, lower.tail=FALSE)

md_z <- mean(my_data)/(2*sqrt(length(my_data)))
pnorm(md_z, lower.tail=FALSE)
pnorm(md_z, lower.tail=FALSE)*2

md_t <- mean(my_data)/(sd(my_data)/sqrt(length(my_data)))


### Normal test

fd + 
  geom_density(data=data.frame(x=my_data), 
                 mapping=aes(x=my_data), 
               fill="red")

##test
dn <- data.frame(x=seq(-3,3,.01), ymin=0) %>%
  mutate(y=dnorm(x))

zplot <- ggplot() +
  geom_line(data=dn, mapping=aes(x=x, y=y), lwd=1.3) +
  xlab("\nZ") +
  ylab("Probability Density\n") +
  theme_bw(base_size=17) 

zplot +
  geom_ribbon(data=dn%>%filter(x>0.89), 
              mapping=aes(x=x, ymin=ymin, ymax=y),
              fill="red")

zplot +
  geom_ribbon(data=dn%>%filter(x>0.89), 
              mapping=aes(x=x, ymin=ymin, ymax=y),
              fill="red") +
  geom_ribbon(data=dn%>%filter(x>0.89), 
              mapping=aes(x=-1*x, ymin=ymin, ymax=y),
              fill="red")