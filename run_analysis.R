# Coursera Data Science course3: Getting and Cleaning Data
# Course project
# started Oct 2014

# check directory
getwd()
R.version.string

# load packages
require(reshape2)
require(plyr)
require(stringr)

# 1. load the data from the X_train.txt and X_test.txt, cbind subject and activity codes, and rbind into one dataset

    # Data for subjects in test data
    Test_data <- read.table("X_test.txt") 
    Test_labels <- read.table("y_test.txt") 
    Test_subjects <- read.table("subject_test.txt")
    # table(Test_subjects)
    
    # relabel column headings in subject and labels
    Test_subjects <- rename(Test_subjects, c("V1" = "subject"))
    Test_labels <- rename(Test_labels, c("V1" = "activity"))
    # rows match across dataframes, so cbind is the solution
    Test <- cbind(Test_subjects, Test_labels, Test_data)

    # Data for subjects in the train data
    Train_data <- read.table("X_train.txt")
    Train_labels <- read.table("y_train.txt")
    Train_subjects <- read.table("subject_train.txt")
    # table(Train_subjects)
    
    Train_subjects <- rename(Train_subjects, c("V1" = "subject"))
    Train_labels <- rename(Train_labels, c("V1" = "activity"))
    
    Train <- cbind(Train_subjects, Train_labels, Train_data)

    # now r bind Test and Train together
    Data <- rbind(Test, Train)

    # label activities
    Data$activity <- factor(Data$activity, 
                labels = c("walking","walkingupstairs","walkingdownstairs","sitting","standing","laying"))

# 2. load the names for the features and select those associated with mean and std summary stats

    Features <- read.table("features.txt") 
    str(Features)
    # head(Features)
    # tail(Features)
    # table(Features$V2)

    # select features which contain mean() or a std()
    # "mean" also included meanFreq() - so fixed = T
    Features_subset <- droplevels(Features[grepl("mean()", Features$V2, fixed = T) | grepl("std", Features$V2),])

    # for tidyness, rename V2
    Features_subset <- rename(Features_subset, c("V2" = "feature"))

# 3. merge features with data and select just std and mean variables at the same time

    # make a column index to match the column labels in Data
    Features_subset$columnindex <- paste("V", Features_subset$V1, sep = "")
    Features_subset$V1 <- NULL

    # melt Data
    Data_melted <- melt(Data, id = c("subject", "activity"))
    str(Data_melted)
    # in this data set "variable" is a factor and matches with the columnindex in Features_subset
    Data_melted <- rename(Data_melted, c("variable" = "columnindex")) 
    # I want and inner join - where the key is found in both sets, but drop where not. 
    # droplevels drops factor levels that aren't in the data anymore - so for the variable and feature stuff
    Data_merged <- droplevels(merge(Data_melted, Features_subset))
    str(Data_merged) # good 66 levels of the column index
    
    # summarize 
    Tidydata <- ddply(Data_merged, .(subject, activity, feature), 
                       summarize, mean = mean(value))
    # this results 11880 obs - 30 subj, 6 activities, 66 features
    str(Tidydata)

# 4. Optional: parse out the feature names in separate variables
    Featurevariables <- as.data.frame(str_match(Features_subset$feature, 
                        "^([tf])(Body|Gravity)+(Acc|Gyro)(Jerk)?(Mag)?-(std|mean)\\(\\)(-([XYZ]))?.*$"))
    # clean up the variables a bit
    names(Featurevariables) <- c("feature","domain","motion","sensor","derivation","magnitude","summarystatistic","extra","direction")
    Featurevariables$extra <- NULL
    levels(Featurevariables$domain)
    levels(Featurevariables$domain) <-  c("frequency", "time")
    levels(Featurevariables$motion)
    levels(Featurevariables$motion) <-  factor(tolower(as.character(Featurevariables$motion)))
    levels(Featurevariables$sensor)
    levels(Featurevariables$sensor) <-  c("acceleration", "gyroscope")
    levels(Featurevariables$derivation)
    levels(Featurevariables$derivation) <-  c("no", "yes")
    Featurevariables$vector <- factor(tolower(paste0(Featurevariables$magnitude, Featurevariables$direction)))
    Featurevariables$magnitude <- NULL
    Featurevariables$direction <- NULL

    # merge Tidydata
    Tidydata <- merge(Tidydata, Featurevariables)
    str(Tidydata)
    Tidydata$feature <- NULL
    # sort and reorder things for clarity
    Tidydata <- arrange(Tidydata, subject, activity, domain, motion, sensor, derivation,summarystatistic, vector)
    Tidydata <- Tidydata[,c(1,2,4:7,9,8,3)]
    str(Tidydata)

# 5. output
write.csv(Tidydata, file = "Tidydata.csv", row.names = FALSE)
