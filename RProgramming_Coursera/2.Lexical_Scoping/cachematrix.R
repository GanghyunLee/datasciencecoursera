makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        
        set <- function(y)
        {
                x <<- y
                inv <<- NULL
        }
        
        get <- function() x
        
        setInverse <- function(solve) inv <<- solve
        getInverse <- function() inv
        
        list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}

cacheSolve <- function(x, ...) {
        inv <- x$getInverse()
        
        if(!is.null(inv))
        {
                message("getting cached data")
                return(inv)
        }
        
        data <- x$get()
        inv <- solve(data)
        x$setInverse(inv)
        inv
}

# usage
# a <- matrix(1:4, 2, 2)
# z <- makeCacheMatrix(a)
# cacheSolve(z)