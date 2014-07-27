#set my own personal working directory for my comp
#used some code from github to fill in holes
setwd("~/Desktop/coursera/GettingandCleaningData/getting_and_cleaning_data_project")

##TASK 1: MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET

#Train- load the set from X, Y & subject
training = read.csv ("UCI HAR Dataset/train/X_train.txt", sep= "", header= FALSE)
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

#Testing- load the set from X, Y & subject
testing = read.csv ("UCI HAR Dataset/test/X_test.txt", sep= "", header= FALSE)
testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

#Activities- only one file
activity = read.csv ("activity_labels.txt", sep= "", header= FALSE)

# Read features and make the feature names better suited for R with some substitutions
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

#Finally, we can row bind everything to one set
allTheData= rbind(training,testing)

##TASK 2.Extracts only the measurements on the mean and standard deviation for each measurement.
demCols <- grep(".*Mean|.*Std", features [,2])
features <- features[demCols,]
demCols <- c(demCols, 562, 563)
#removed unwanted data, cleaned up
allTheData <- allTheData[,demCols]

##TASK 3.Uses descriptive activity names to name the activities in the data set
colnames(allTheData) <-c(features, "Activities", "Subjects")
##TASK 4.Appropriately labels the data set with descriptive variable names. 
colnames(allTheData) <- tolower(colnames(allTheData))
#this is where i got stuck mostly
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  allTheData$activity <- gsub(currentActivity, currentActivityLabel, allTheData$activity)
  currentActivity <- currentActivity + 1
}

allTheData$activity <- as.factor(allTheData$activity)
alThelData$subject <- as.factor(allTheData$subject)
##TASK 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy = aggregate(allTheData, by=list(activity = allTheData$activity, subject=allTheData$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")

