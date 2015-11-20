## This script contains the function merged_ds () which  creates a tidy data set 
## with the average of each combination of subject and activity for each of the mean 
## and stddev variables of the training and test data sets resulting from the 
## experimient: "Human Activity Recognition Using Smartphones Dataset Version 1.0" 
## located in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## To be able to run the script your working directory needs to have the files X_train, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt, activity_labels.txt and features.txt.
## merged_ds () doesn't require additional parameters.
##
## A tidy data set (dfmeans) is created with the means of each of the 66 numeric 
## variables for each combination of subject and activity. 
## The data set is saved in  "MeansDataSet.txt".

merged_ds <- function () {
        ### Call plyr package    
                library(plyr)
    
        ### Read files    
                train_d <- read.table("X_train.txt")
                train_a <- read.table("y_train.txt")
                train_s <- read.table("subject_train.txt")
                test_d <- read.table("X_test.txt")
                test_a <- read.table("y_test.txt")
                test_s <- read.table("subject_test.txt")
        ### Merge files
                ## Merge training files
                dftr <- cbind(train_s,train_a)
                dftr <- cbind(dftr,train_d)
                ## Merge test files
                dfts <- cbind(test_s,test_a)
                dfts <- cbind(dfts,test_d)
                ## Merge training and test files
                dffull <- rbind(dftr,dfts)
                ## clean memory
                rm (train_s,train_a,train_d,test_s,test_a,test_d,dftr,dfts)
        
        ## Subset mean and standard deviation    
                ## Read features to get field names
                features <- read.table("features.txt",sep = " ")
                ## Get columns indexes for mean and std only
                indx <- sort(unlist(lapply(c("mean()","std()"), function (x) {
                        grep (x, features$V2, fixed = TRUE, value = FALSE)})))
                ## create subset dfsub
                dfsub <- dffull[,c(1:2,indx+2)]
                
        ## Update activity names
                ## read activities catalog
                activities <- read.table("activity_labels.txt",sep = " ")
                ## replace activities column with descriptions
                dfsub$V1.1 <- mapvalues (dfsub$V1.1,activities$V1, as.character(activities$V2))
        
        ## Adding descriptive variable names  
                
                ## Correcting duplicated Body label in Mag variables names
                features$V2 <- gsub("BodyBody","Body", as.character (features$V2))
                
                ## Changing mean() and std() for Mean and Stddev for a more uniform name pattern
                
                features$V2 <- gsub("-mean()","Mean",fixed=TRUE, as.character (features$V2))
                features$V2 <- gsub("-std()","Stddev",fixed=TRUE, as.character (features$V2))

                ## Changing variable names to dfsub
                colnames(dfsub) <- c ("Subject", "Activity", as.character(features$V2[indx]))        
                
        ## creates a tidy data set with the average of each variable for each activity and each subject        
                
                dfmeans <- ddply(dfsub,.(Subject, Activity), numcolwise(mean))
                
                ## Save dfmeans as a txt file
                write.table(dfmeans, file = "MeansDataSet.txt", row.name=FALSE)
                
                }