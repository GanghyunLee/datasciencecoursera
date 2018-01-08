library(reshape2) # to use melt() function

# Download dataset
if(!file.exists("./dataset.zip"))
{
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./dataset.zip", method="curl")
}

# Load data - labels
activityLabels <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt", sep=" ", stringsAsFactors=FALSE)
featureLabel <- read.table("./dataset/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

#======================================================================================================
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#======================================================================================================
dataFilter <- grep(".*mean\\(.*|.*std\\(.*", featureLabel$V2)

# Load data - Test sets
xTest <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt")[,dataFilter]
yTest <- read.table("./dataset/UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt")

# Load data - Train sets
xTrain <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")[,dataFilter]
yTrain <- read.table("./dataset/UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")

# merge Subject column
xTest <- cbind(testSubject, yTest, xTest)
xTrain <- cbind(trainSubject, yTrain, xTrain)

#======================================================================================================
# 1. Merges the training and the test sets to create one data set.
#======================================================================================================
data <- rbind(xTest, xTrain)

rm("xTest", "yTest", "xTrain", "yTrain")

#======================================================================================================
# 4. Appropriately labels the data set with descriptive variable names.
#======================================================================================================
featureLabel$V2 <- gsub("mean", "Mean", featureLabel$V2)
featureLabel$V2 <- gsub("std", "Std", featureLabel$V2)
featureLabel$V2 <- gsub("[()-]", "", featureLabel$V2)
colnames(data) <- c("subject", "activity", featureLabel$V2[dataFilter])

#======================================================================================================
# 3. Uses descriptive activity names to name the activities in the data set
#======================================================================================================
data$activity <- factor(data$activity, levels=activityLabels$V1, labels=activityLabels$V2)
data$subject <- as.factor(data$subject)

#======================================================================================================
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
#======================================================================================================
data <- melt(data, id=c("subject", "activity"))
data <- dcast(data, subject + activity ~ variable, mean)
write.table(data, file="./tidy.txt", row.names=FALSE)