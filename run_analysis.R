#set my own personal working directory for my comp
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

#Finally, we can row bind everything to one set
allTheData= rbind(training,testing)

##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names. 
##5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
