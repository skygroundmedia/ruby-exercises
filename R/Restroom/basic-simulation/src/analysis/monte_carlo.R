# ## ## ## ## ## ## ## ## ## ## ##
# Median, mean, and Max Queue sizes
#  vs. population
#

args <- (commandArgs(trailingOnly=TRUE))

if(length(args) == 0){
  print("No arguments supplied.")
  path = file.path("bin", "simulation.csv")
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
library(scales)

 ggplot(data = df) + scale_shape_manual(name="Type", value=c(2,3,4)) +
   geom_smooth(aes(x = population, y = mean)) +
   geom_point(aes(x  = population, y = mean, shape = "mean")) +
   geom_smooth(aes(x = population, y = median)) +
   geom_point(aes(x  = population, y = median, shape = "median")) +
   geom_smooth(aes(x = population, y = max)) +
   geom_point(aes(x  = population, y = max, shape = "max")) +
   scale_y_continuous(breaks=0:35, labels="queue size") +
   scale_x_continuous(breaks=seq(from=10,to=600,by=30), labels="population")



# ThiS Works
#   
# data <- read.table(path, header=TRUE, sep=",")
# df <- data.frame(table(data$X70))
# colnames(df) <- c("queue_size", "frequency")
# percent_labels <- paste(df$frequency, '(', round(df$frequency*100/540, 2), '%)')
# ggplot(data=df) + theme(legend.position = "none") +
#   scale_fill_grey(start = 0.6, end = 0.8) +
#   geom_bar(stat="identity", aes(x = queue_size, y = frequency, fill = factor(queue_size))) +
#   geom_text(aes(x = queue_size, y = frequency, label = percent_labels, size=1)) +
#   scale_y_continuous("frequency") +
#   scale_x_discrete("queue size")

