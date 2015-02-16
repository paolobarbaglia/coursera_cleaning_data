# Project of Coursera course
# Getting and Cleaning Data
# User ID: 1917969


# STEP 1
# Merges the training and the test sets to create one data set.

# TRAINING SET
trainData <- read.table("./data/train/X_train.txt") #DIMENSION 7352*561
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

# TEST SET
testData <- read.table("./data/test/X_test.txt") #DIMENSION 2947*561
testLabel <- read.table("./data/test/y_test.txt") 
testSubject <- read.table("./data/test/subject_test.txt")

# JOIN DATA
joinData <- rbind(trainData, testData) #DIMENSION 10299*561
joinLabel <- rbind(trainLabel, testLabel) #DIMENSION 10299*1
joinSubject <- rbind(trainSubject, testSubject) #DIMENSION 10299*1

# STEP 2
# Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt") #DIMENSION 561*2
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2]) #LENGTH 66
joinData <- joinData[, meanStdIndices] #DIMENSION 10299*66
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) #CLEAN remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) #CLEAN capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) #CLEAN capitalize S
names(joinData) <- gsub("-", "", names(joinData)) #CLEAN remove "-" in column names 


# STEP 3
# Uses descriptive activity names to name the activities in the data set. 
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# STEP 4
# Appropriately labels the data set with descriptive variable names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData) #DIMENSION 10299*68
write.table(cleanedData, "merged_data.txt")

# STEP 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)
write.table(result, "data_with_means.txt")