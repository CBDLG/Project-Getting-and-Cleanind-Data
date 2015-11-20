# Project-Getting-and-Cleanind-Data
Getting and Cleaning Data Course Project Assignment

run_analysis.R script
This script creates a tidy data set with the average of each combination of subject and activity for each of the mean and stddev variables of the training and test data sets resulting from the experimient: “Human Activity Recognition Using Smartphones Dataset Version 1.0” located in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To be able to run the script your working directory needs to have the files X_train, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt, activity_labels.txt and features.txt.

The script requires the plyr package to be installed.

After loading the files the script  merge subjects, activities and data of the training and test sets to create only one data set.

A subset (set dfsub in the script) with the subjects, the activities, the 33 means and the 33 standard deviations is also created.  A total of 68 variables are the scope of this analysis.

The numeric values representing activities are replaced with the description of the activity.

The features are used next to name the variables of the subset set with minor changes (see Codbook.md)

A tidy data set (dfmeans) is created with the means of each of the 66 numeric variables for each combination of subject and activity. The data set is saved in  "MeansDataSet.txt".
