# Grammers of graphics
# Think "verb", "noun", "adjective" for graphics

#==============================================
# Basics : qplot()
#==============================================
library(ggplot2)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)

# Adding a geom
qplot(displ, hwy, data = mpg, geom = c("point", "smooth")) # point : basic point graph, smooth : can see data trend
# grey zone : 95% confidence

#==============================================
# Histogram
#==============================================
qplot(hwy, data = mpg, geom = c("density")) # Density function graph
qplot(hwy, data = mpg, fill = drv) # different color by "drv" variable

#==============================================================
# Facets : like panels in lattice, can create separate plots
#==============================================================
qplot(displ, hwy, data = mpg, facets = .~drv)           # facets = (row)~(col)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)
qplot(displ, hwy, data = mpg, facets = .~drv) + geom_smooth(method = "lm") # with linear regression line

qplot(displ, hwy, data = mpg, facets = .~drv) + facet_grid(. ~ drv) + geom_smooth(method = "lm") # with facet label grid
qplot(displ, hwy, data = mpg, facets = .~drv) + labs(title = "Title!") + labs(x = "xLabel", y = "yLabel") # Title / Label
qplot(displ, hwy, data = mpg, facets = .~drv) + theme_bw(base_family = "Times") # Change theme

#==============================================
# A Notes about Axis Limits
#==============================================
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## Outlier!
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()

g + geom_line() + ylim = c(-3, 3)                       # cut Outlier data
g + geom_line() + coord_cartesian(ylim = c(-3, 3))      # Outlier included