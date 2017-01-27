# ## ## ## ## ## ## ## ## ## ## ##
# Median, mean, and Max Queue sizes
#  vs. population
#

args <- (commandArgs(trailingOnly=TRUE))

if(length(args) == 0){
  print("No arguments supplied.")
  path = file.path("bin", "restroom", "simulation.csv")
} else {
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
}


data   <- read.table(path, header=TRUE, sep=",")
# Add up all the queue sizes then divide by total time (540)
mean   <- apply(data,2,mean)
median <- apply(data,2,median)
max    <- apply(data,2,max)
df     <- data.frame(population=seq(from=10,to=600,by=10),mean=mean,median=median,max=max)


# ## ## ## ## ## ## ## ## ## ## ##
# Draw the chart
#
library(ggplot2)

ggplot(data = df) + scale_shape_manual(name="Type", value=c(2,3,4)) +
  geom_smooth(aes(x = population, y = mean)) +
  geom_point(aes(x  = population, y = mean, shape = "mean")) +
  geom_smooth(aes(x = population, y = median)) +
  geom_point(aes(x  = population, y = median, shape = "median")) +
  geom_smooth(aes(x = population, y = max)) +
  geom_point(aes(x  = population, y = max, shape = "max")) +
  scale_y_continuous("queue size", breaks=0:35) +
  scale_x_continuous("population", breaks=seq(from=10,to=600,by=30))
