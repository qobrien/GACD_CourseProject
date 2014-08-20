#Getting and Cleaning Data
#COURSE PROJECT
#Quentin O'Brien

setwd("~/Documents/R Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset")

message("Beginning data cleaning...")

#Call necessary reshape package
library(reshape2)

#Importing activities data
activity_labels <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)

#Importing and combining test data
subject_test <- read.table("test/subject_test.txt", header=FALSE)
x_test <- read.table("test/X_test.txt", header=FALSE)
y_test <- read.table("test/y_test.txt", header=FALSE)

test_activity <- data.frame(Activity=factor(y_test$V1, labels=activity_labels$V2))

test_data <- cbind(test_activity, subject_test, x_test)

#Importing and combining training data
subject_train <- read.table("train/subject_train.txt", header=FALSE)
x_train <- read.table("train/X_train.txt", header=FALSE)
y_train <- read.table("train/y_train.txt", header=FALSE)

train_activity <- data.frame(Activity=factor(y_train$V1, labels=activity_labels$V2))

train_data <- cbind(train_activity, subject_train, x_train)

#Combine test and training data
total_data <- rbind(test_data, train_data)

#Importing features data
features <- read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)

#Edit total_data to add appropriate labels
names(total_data) <- c("Activity", "Subject", features[,2])

#Extracting only the measurements on the mean and standard deviation
extract_meansd <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

#Creating and writing the dataset with only mean and std measurements
tidy_data <- total_data[c("Activity","Subject",extract_meansd)]
write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)
message("A data set containing only measurements on the mean and standard
        deviation can now be found in the working directory under the file 
        name 'tidy_data.txt'.")

#Creating a second data set with the average of each variable for each activity 
#and each subject
melted_tidy_data <- melt(tidy_data, id=c("Activity","Subject"), measure.vars=extract_meansd)
tidy_data_means_only <- dcast(melted_tidy_data, Activity + Subject ~ variable,mean)
write.table(tidy_data_means_only, file="tidy_data_means_only.txt", row.names=FALSE)
message("A data set containing only the average of each variable for each
        activity and each subject can now be found in the working directory 
        under the file name 'tidy_data_means_only.txt'.")

