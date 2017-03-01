#Assignment Preparation
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
dir<-setwd('C:/Users/Jane_Liao/Desktop/JL/Coursera/3. Getting and Cleaning Data/Assignment/')
download.file(fileURL, 'UCI.zip')
unzip('UCI.zip')

# Config - activity and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
colnames(activityLabels)  = c('activityID','activityType')
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#1. Merges the training and the test sets to create one data set
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
xTrain <- read.table("UCI HAR Dataset/train/x_train.txt",header=FALSE)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
colnames(subjectTrain)  = "subjectID"
colnames(xTrain)        = features[,2] 
colnames(yTrain)        = "activityID"

trainingData = cbind(yTrain,subjectTrain,xTrain)

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
xTest <- read.table("UCI HAR Dataset/test/x_test.txt",header=FALSE)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
colnames(subjectTest) = "subjectID"
colnames(xTest)       = features[,2]
colnames(yTest)       = "activityID"

testingData = cbind(yTest,subjectTest,xTest)

data = rbind(trainingData,testingData)
column = colnames(data)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
validcol = (grepl("activity..",column) | grepl("subject..",column) | grepl("mean\\()$",column) | grepl("std\\()$",column) )
datafinal = data[validcol==TRUE]

#3. Uses descriptive activity names to name the activities in the data set
datafinal <- merge(datafinal,activityLabels,by='activityID')
column = colnames(datafinal)

#4. Appropriately labels the data set with descriptive variable names

for (i in 1:length(column)) 
{
        column[i] = gsub("\\()","",column[i])
        column[i] = gsub("-std$","StdDev",column[i])
        column[i] = gsub("-mean$","Mean",column[i])
        column[i] = gsub("^t","time",column[i])
        column[i] = gsub("^f","freq",column[i])
        column[i] = gsub("([Gg]ravity)","Gravity",column[i])
        column[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",column[i])
        column[i] = gsub("[Gg]yro","Gyro",column[i])
        column[i] = gsub("AccMag","AccMagnitude",column[i])
        column[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",column[i])
        column[i] = gsub("JerkMag","JerkMagnitude",column[i])
        column[i] = gsub("GyroMag","GyroMagnitude",column[i])
}

colnames(datafinal)<-column

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.

library(reshape)
library(reshape2)
melted = melt(datafinal, id.var = c("subjectID", "activityID","activityType"))
means = dcast(melted , activityType + subjectID ~ variable, mean)
means
write.table(means, file="./tidy_data.txt")
