makeCacheMatrix <- function(matrix = matrix()) {  
  inverse_matrix <- NULL
  assignMatrix <- function(new_matrix) {
    matrix <<- new_matrix
    inverse_matrix <<- NULL
  }
  retrieveMatrix <- function() {
    matrix
  }
  storeInverse <- function(inverse) {
    inverse_matrix <<- inverse
  }
  fetchInverse <- function() {
    inverse_matrix
  }
  list(assignMatrix = assignMatrix, 
       retrieveMatrix = retrieveMatrix, 
       storeInverse = storeInverse, 
       fetchInverse = fetchInverse)
}
cacheSolve <- function(x, ...) {
  inverse_matrix <- x$fetchInverse()
  if (!is.null(inverse_matrix)) {
    message("Using cached inverse data")
    return(inverse_matrix)
  }
  original_matrix <- x$retrieveMatrix()
  inverse_matrix <- solve(original_matrix)
  x$storeInverse(inverse_matrix)
  inverse_matrix
}
