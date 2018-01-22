# lattice : xyplot, bwplot, levelplot function
# can make multidimensional plot(ex. Same kind of plot, but under many many conditions)
# All ploting / annotation is done at once

# xyplot : this is the main functino for creating scatterplots
# bwplot : box-and-whiskers plots ("boxplots")
# histogram
# stripplot : like a boxplot but with actual points
# dotplot : plot dots on "violin strings"
# splom : scatterplot matrix; like pairs in base plotting system
# levelplot, contourplot : for plotting "image" data

#========================================
# xyplot : xyplot(y ~ x | f * g, data)
#========================================
# f, g : conditioning variables(optional)
# * : an interaction between two variables

#========================================
# Simple Lattice Plot
#========================================
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1)) # more wind, less ozone!

# lattice graphics functions : return an object of class trellis
# One the command line, trellis objects are auto-printed so that it appears the function is plotting the data
# To plot trellis object, use print
p <- xyplot(Ozone ~ Wind, data = airquality) ## nothing happens!
print(p) # Plot appears

#========================================
# Latice Panel Function
#========================================
# panel function : which controls what happens inside each panel of the plot

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2,1)) # Plot with 2 panels

## Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...) # First call the default panel function for 'xyplot' (to make points appear)
        panel.abline(h = median(y), lty = 2)
})

## Lattice Panel Functions : Regression Line
xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...)
        panel.lmline(x, y, col = 2) ## Overlay a simple linear regression line
})

