# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Factors
# Values can be: nominal, ordinal, or continuous. 
# • Nominal labels are labels that describe a category. There is no order to these values (Ex: "red", "yellow", "green")
# • Ordinal values are similar to Nominal values but they are ordered sequentially (Ex: "poor", "average", "good")
# • Continuous values are sequences of values that represent a quantity (Ex: 1,2,3).  



# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# By default, factor levels for character data are created in alphabetical order. 
# However, we can set the order of the levels when creating the factors: 
#
colors <- c('green', 'red', 'blue')
factor(colors)
 

results <- c('poor', 'average', 'good')
factor(results, order=TRUE, levels=results)
