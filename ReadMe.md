---
title:
author:
output: html_document
---

Course project ReadMe
========================================================
Coursera Johns Hopkins Data Science course #3 Getting and Cleaning Data
________________________________________________________

# Description 
For this project we were to work with a published dataset on human movement data collected from smartphones and prepare a tidy dataset that could be used for further analysis. 

To fulfill the assignment we were to:  

1. write an R script called run_analysis.R that does the following:  
 * Merges the training and the test sets to create one data set.
 * Extracts only the measurements on the mean and standard deviation for each measurement. 
 * Uses descriptive activity names to name the activities in the data set
 * Appropriately labels the data set with descriptive variable names. 
 * Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
2. output and submit the tidy dataset
3. write a ReadMe markdown document to describe how the code works
4. make a Codebook markdown document that serves as a key to the variables in the tidy dataset

# Data source:
Data were obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## information about the data set 
Thirty subjects (people) each performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) and their linear acceleration and angular velocity were recorded using the smartphone accelerometer and gyroscope. The authors of the dataset used this raw data to calculate 33 different measures (which the authors call features) relating to speed and movement of the subjects at various timepoints.  

The 33 features are as follows (note that -XYZ really indicates three features, one for each direction):  
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ: 
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag  

Each feature name describes the variables comprising the feature:  
* t/f = the signal domain:time or frequency
* Body/Gravity = the motion component captured: body or gravity
* Acc/Gyro = the sensor signal: acceleration (which gives linear acceleration) or gyroscope (which gives angular velocity)
* Jerk/ = whether the value is a derivation or not: jerk (derived in time) or not
* Mag/X/Y/Z = the component of the vector measured: either the magnitude or X, Y, Z direction  

These features were in turn summarized and combined in various ways, resulting in a dataset of 561 different quanitative variables. More specific details regarding calculation and summary of the features are beyond the scope of this project, so I will direct the reader to the README.txt and features_info.txt documents provided with the Human Activity Recognition Using Spartphones Dataset for further information.

For their analysis, the authors divided the study subjects into training (70%) and test (30%) datasets.
The quantitative measures for the training and test data sets are containted in the "X_train.txt" and "X_test.txt" files which each have 561 columns corresponding to each of the feature vectors. The feature vector names are containted in the second column of the file features.txt. The rows of the training and test datasets correspond to different subjects and activities. The activity labels for the rows are contained in the files y_train.txt and y_test.txt as integers which correspond to the key in activity_labels.txt (1 = WALKING, 2 = WALKING UPSTAIRS, 3 = WALKING DOWNSTAIRS, 4 = SITTING, 5 = STANDING, 6 = LAYING). The subject labels for the rows are contained in the files y_train.txt and y_test.txt as integers.

# what tidy data might look like for this example:
According to Hadly Wickham's paper on tidy data http://vita.had.co.nz/papers/tidy-data.pdf, 
> tidy data have three key features: 
>
> 1. each varaible forms a column,
> 2. each observation forms a row,
> 3. and each type of observational unit forms a table.
>

Our course instructors (and others) also suggest other guidelines, including that the first row of the table should have varaible names, the variable names should be human readable and descripitive.

In the raw dataset, the numerical data are spread across two main tables for which the columns are actually different values of a single variable "features", the subject and activity descriptors are in seperate tables, and column names for the numerical data are in yet another file. What we need for our Tidydata summary is a table with four variables: *subject*, *activity*, *feature*, and our calculated summary statistic, *mean*:  

subject  |  activity  | feature           |   mean
-------- | ---------- | ----------------- | -------
1       | walking  | tBodyAcc-mean()-X | 3.5
1       | walking  | tBodyAcc-std()-X  | 4.0

Dedending on the subsequent analysis, one might also argue that the variable *feature* is really multiple variables stored in one column, descriped in section 3.2 in Hadley's paper. Thus the feature could be split into  six variables:
* *domain*: time or frequency
* *motion*: body or gravity
* *sensor*: acceleration or gyroscope
* *derivation*: yes or no
* *vector*: magnitude, X, Y, Z
* *summarystatistic*: mean or std  

Thus our tidy data would have the following columns:  

subject | activity | domain | motion | sensor | derivation | summarystatistic | vector |  mean 
------- | -------- | ------ | ------ | ------ | ---------- | ---------------- | ------ | ----
1        | walking   | time  | body  | acceleration | no | mean | X | 3.5
1        | walking   | time  | body  | acceleration | no | std | X  | 4.0  

# Code:
The script in run_analysis.R was written in R version 3.1.2 and requires the packages reshape2, plyr, stringr. It takes as input features.txt, subject_test.txt, subject_train.txt, X_test.txt, X_train.txt, y_test.txt, x_train.txt files, so for running this, the user needs to have these files in the working directory. The code combines the various files, selects features associated with mean and standard deviation, and summarizes them by cacluating their mean value by subject, activity, and feature. An option is included for splitting the *feature* variable into its components as described above. Finally, it outputs a tidy subset of this data (Tidydata.csv) into the working directory. 

