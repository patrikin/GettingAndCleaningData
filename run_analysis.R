#Course project

#Getting and unzipping data
getwd()
dir <- "CourseProject"
if (!file.exists(dir)) {dir.create(dir)}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- paste0(dir, "/data.zip")
download.file(url, path, method = "curl")
dateDownloaded <- date()
setwd(dir)
unzip("data.zip")


#You should create one R script called run_analysis.R that does the following.

#1. Merges the training and the test sets to create one data set.

train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

comb <- rbind(train, test)

features <- read.table("UCI HAR Dataset/features.txt")
names(comb) <- features$V2


#2. Extracts only the measurements on the mean and standard deviation for each measurement.

meansOnly <- comb[, grep("mean\\()", names(comb))]
stdOnly <- comb[, grep("std", names(comb))]

#3. Uses descriptive activity names to name the activities in the data set

descriptiveNamesMean <- gsub("-mean\\()", "", names(meansOnly))
descriptiveNamesMean2 <- gsub("-", "", descriptiveNamesMean)
descriptiveNamesMean3 <- paste0(descriptiveNamesMean2, "Mean")
descriptiveNamesMean3
names(meansOnly) <- descriptiveNamesMean3

descriptiveNamesStd <- gsub("-std\\()", "", names(stdOnly))
descriptiveNamesStd2 <- gsub("-", "", descriptiveNamesStd)
descriptiveNamesStd3 <- paste0(descriptiveNamesStd2, "Std")
descriptiveNamesStd3
names(stdOnly) <- descriptiveNamesStd3

comb2 <- cbind(meansOnly, stdOnly)

namesOrdered <- sort(names(comb2))
comb3 <- comb2[, namesOrdered]

#4. Appropriately labels the data set with descriptive variable names.
meansAndStandardDeviationsOnly <- comb3
write.csv(comb3, "meansAndStandardDeviationsOnly.csv", row.names = FALSE)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subjectTrain) <- "Subject"
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subjectTest) <- names(subjectTrain)
subjectCombined <- rbind(subjectTrain, subjectTest)

#Add 'average' to column names in comb3:
namesWithAverage <- paste0(names(comb3), "Average")
comb3WithAverage <- comb3
names(comb3WithAverage) <- namesWithAverage

comb4 <- cbind(subjectCombined, comb3WithAverage)

library(tidyverse)
comb5 <-
  comb4 %>%
  group_by(Subject) %>%
  summarise_all(funs(mean))

write.csv(comb5, "meansAndStandardDeviationsOnlyAverageForEachSubject.csv", row.names = FALSE)