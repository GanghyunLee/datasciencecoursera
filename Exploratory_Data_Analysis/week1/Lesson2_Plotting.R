########################################################
# Basic Plot - 2-dim plot
########################################################
# hist, plot, ...
library(datasets)
hist(airquality$Ozone)
with(airquality, plot(Wind, Ozone))
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

# Base Graphics Parameter
# pch : the plotting symbol(default is open circle)
# lty : the line type (default is solid line), can be dashed, dotted, etc
# lwd : the line width
# col : the plotting color, specified as a number, string, or hex code; 
#       the colors() function gives you a vector of colors by name
# xlab : character string for the x-axis label
# ylab : character string for the y-axis label

# par() function is used to specify global graphics parameter that affect all plots in an R session.
# las : the orientation of the axis labels on the plot
# bg : the background color
# mar : the margin size
# oma : the outer margin size (defaut is 0 for all sides)
# mfrow : number of plots per row, column(plots are filled row-wise)
# mfcol : number of plots per row, column(plots are filled column-wise)

# View default values for global graphics parameters
par("lty")      ## [1] "solid"
par("col")      ## [1] "black"
par("pch")      ## [1] 1
par("bg")       ## [1] "transparent"
par("mar")      ## [1] 5.1 4.1 4.1 2.1
par("mfrow")    ## [1] 1 1

# Base Plotting Functions
# plot : make a scatterplot, or other type of plot depending on the class of the object being plotted
# lines : add lines to a plot, given a vector x values and a corresponding vector of y values
# points : add points to a plot
# text : add text labels to a plot using specified x,y coordinates
# title : add annotations to x, y, axis labels, title, subtitle, outer margin
# mtext : add arbitrary text to the margins (inner or outer) of the plot
# axis : adding axis ticks/labels

# Base Plot with Annotation
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City") ## Add a title

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n")) # initialize the graphics device, not actually plot anything.
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Month"))

# Base Plot with Regression Line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality) # Linear model
abline(model, lwd=2)

# Multiple Base Plots
par(mfrow = c(1,2))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and Weather in New York City", outer = TRUE) # Add text to margin
})


########################################################
# Lattice Plot - Entire plot specified by one function; 
########################################################
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

###############################
# Default ggplot2 plot
###############################
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)


# Exercise
x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x, y)
par(mar=c(2,2,2,2))
plot(x,y)
par(mar=c(4,4,2,2))
plot(x,y)
plot(x, y, pch = 20)
plot(x, y, pch = 19)
plot(x, y, pch = 3)
plot(x, y, pch = 4)
examples(point)         # View Examples

x <- rnorm(100)
y <- rnorm(100)
plot(x, y, pch = 20)
title("Scatterplot")
text(-2, -2, "Label")
legend("topleft", legend = c("Data"), pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "blue")

plot(x, y, xlab = "Weight", ylab = "Height", main = "Scatterplot", pch = 20)
legend("topright", legend = c("Data"), pch = 20)
abline(fit, lwd = 3, col = "red")

z <- rpois(100, 2)
par(mfrow = c(2,1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)
par("mar")

par(mfrow = c(1,2))
par(mar = c(2,2,1,1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)

par(mar = c(4,4,2,2))
plot(x, y, pch = 20)
plot(x, z, pch = 19)

par(mfrow = c(1,1))
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50, labels = c("Male", "Female"))
str(g)
plot(x, y)
plot(x, y, type = "n") # plot nothing
# Add points sequentially by groups
points(x[g == "Male"], y[g == "Male"], col = "green")
points(x[g == "Female"], y[g == "Female"], col = "blue", pch = 19)