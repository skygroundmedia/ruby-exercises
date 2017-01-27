# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# A matrix is a two-dimensional array. 
# They can only hold elements of the same data type
#

m <- matrix(1:20, nrow=5, ncol=4, byrow=TRUE)

dimnames(m) <- list(c('a','b','c','d','e'), c('p','q','r','s'))

print(m)

# Provide an index: matrix[index]
print(m[10])

# Provide a row and column: matrix[row, column]
print(m[3, 4])

# Provide a matrix: matrix[from_row:to_row, from_column:to_column]
print(m[3:5,2:3])