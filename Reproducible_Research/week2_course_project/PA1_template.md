---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---


## Loading and preprocessing the data

```r
rawdata <- read.csv("./activity.csv", header = TRUE, colClasses = c("numeric", "character", "numeric"))
rawdata$date <- as.Date(rawdata$date, "%Y-%m-%d")
data <- rawdata[complete.cases(rawdata),]        # remove NA datax
```

## What is mean total number of steps taken per day?
1. Calculate the total number of steps taken per day  
2. If you do not understand the difference between a histogram and a barplot, research the difference between them. Make a histogram of the total number of steps taken each day
3. Calculate and report the mean and median of the total number of steps taken per day


```r
TotalStepsPerDay <- aggregate(steps ~ date, data = data, sum)
head(TotalStepsPerDay)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

```r
hist(TotalStepsPerDay$steps, main = "Total number of steps per day", xlab = "Total number of steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

* Total number of steps taken per day - mean

```r
mean(TotalStepsPerDay$steps)
```

```
## [1] 10766.19
```

* Total number of steps taken per day - median

```r
median(TotalStepsPerDay$steps)
```

```
## [1] 10765
```

## What is the average daily activity pattern?
1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
stepsby5minutesInverval <- aggregate(steps ~ interval, data = data, mean)
plot(y = stepsby5minutesInverval$steps, x = stepsby5minutesInverval$interval, type='l', main = "The average number of steps taken, averaged across all days", xlab = "Interval", ylab = "Steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

* Interval which contains the maximum number of steps

```r
stepsby5minutesInverval$interval[which.max(stepsby5minutesInverval$steps)]
```

```
## [1] 835
```

## Imputing missing values
1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?


* Total number of missing values in the dataset

```r
sum(!complete.cases(rawdata))
```

```
## [1] 2304
```

* Imputing NA values. (mean for 5-minutes interval)

```r
imputedData <- rawdata

for (i in (1:(dim(imputedData)[1]))) {
        if(is.na(imputedData[i, ]$steps)) {
                matchedDataIdx = which(stepsby5minutesInverval$interval == (imputedData[i, ]$interval))
                imputedData[i, ]$steps <- stepsby5minutesInverval$steps[matchedDataIdx]
        }
}

head(imputedData)
```

```
##       steps       date interval
## 1 1.7169811 2012-10-01        0
## 2 0.3396226 2012-10-01        5
## 3 0.1320755 2012-10-01       10
## 4 0.1509434 2012-10-01       15
## 5 0.0754717 2012-10-01       20
## 6 2.0943396 2012-10-01       25
```


```r
TotalStepsPerDayImputed <- aggregate(steps ~ date, data = imputedData, sum)
hist(TotalStepsPerDayImputed$steps, main = "Total number of steps per day", xlab = "Total number of steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


* Total number of steps taken per day - mean (for imputed data)

```r
mean(TotalStepsPerDayImputed$steps)
```

```
## [1] 10766.19
```

* Total number of steps taken per day - median (for imputed data)

```r
median(TotalStepsPerDayImputed$steps)
```

```
## [1] 10766.19
```

## Are there differences in activity patterns between weekdays and weekends?
1. Create a new factor variable in the dataset with two levels : ¡°weekday¡± and ¡°weekend¡± indicating whether a given date is a weekday or weekend day.
2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.


```r
Sys.setlocale(category = "LC_ALL", locale = "english")
```

```
## [1] "LC_COLLATE=English_United States.1252;LC_CTYPE=English_United States.1252;LC_MONETARY=English_United States.1252;LC_NUMERIC=C;LC_TIME=English_United States.1252"
```

```r
imputedData$dayType <- weekdays(imputedData$date)
imputedData$dayType[imputedData$dayType %in% c("Saturday", "Sunday")] <- "weekend"
imputedData$dayType[imputedData$dayType != "weekend"] <- "weekday"
imputedData$dayType <- as.factor(imputedData$dayType)

stepsby5minutesInvervalImputed <- aggregate(steps ~ interval + dayType, data = imputedData, mean)
```


```r
library(ggplot2)
g <- ggplot(data = stepsby5minutesInvervalImputed, mapping = aes(y = steps, x = interval))
g <- g + facet_grid(dayType ~ .)
g <- g + geom_line()
g <- g + labs(title = "Activity patterns between weekdays and weekends") + labs(x = "Interval", y = "Number of steps")

print(g)
```

![](PA1_template_files/figure-html/unnamed-chunk-12-1.png)<!-- -->
