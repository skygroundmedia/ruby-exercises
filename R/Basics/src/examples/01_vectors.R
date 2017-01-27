# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# A vector is a one-dimensional array that holds 
# numeric, character, or logical data. It’s the 
# most basic data structure and the one that is 
# most frequently used. 
#
# Note: Vectors in R start with 1 instead of 0


# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Combine Functions
# 
# The easiest way to create a vector is using the combine function

height <- c(58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72)

weight <- c(115, 117, 120, 123, 126, 129, 132, 135, 139, 142, 146, 150, 154, 159, 164)

print(mean(height))

print(sd(weight))

print(cor(weight, height))

plot(weight, height)


# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Sequence Functions
#
# The sequence function lets you specity the step increment of the sequence
# 
seq(0,100,by=10)



# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# List Functions
#
# Lists can store multiple types of data.
# 
chris <- list(name='Chris', age=30, musician=TRUE)


