# Loading libraries
library(plyr)
library(dplyr)

# Initial file download and setup
if(!file.exists("./UCI HAR Dataset")) {
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip", mode = "wb")
unzip("dataset.zip")
}

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# 1. Merges the training and the test sets to create one data set.
dataset <- bind_rows(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement.
features <- read.table("./UCI HAR Dataset/features.txt")
filter <- grep("std|mean[^Freq]", features$V2)
meanStd <- select(dataset, filter)

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels$V2 <- tolower(activity_labels$V2)
activity_labels$V2 <- gsub("_", "", activity_labels$V2)
activity_labels$V2 <- gsub("gd", "gD", activity_labels$V2)
activity_labels$V2 <- gsub("gu", "gU", activity_labels$V2)

activities <- bind_rows(test_labels, train_labels) %>%
        join(activity_labels, by = "V1") %>%
        select(V2)
names(activities) = "activity"

# 4. Appropriately labels the data set with descriptive variable names.
labels <- grep("std|mean[^Freq]", features$V2, value = TRUE)
labels <- gsub("-", "", labels)
labels <- gsub("\\(\\)","",labels)
labels <- gsub("mean", "Mean", labels)
labels <- gsub("std", "Std", labels)

names(meanStd) <- labels

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
subjects <- bind_rows(subject_test, subject_train)
names(subjects) = "subject"

completeMeanStd <- bind_cols(subjects, activities, meanStd)

newMeanStd <- completeMeanStd %>%
        ddply(.(subject, activity), colwise(mean))

# Write to a .txt file
write.table(newMeanStd, file = "newMeanStd.txt", row.name = FALSE)
