run_analysis <- function()  {
    
    # For a discussion of what this r sript does, and for
    # a list of original and restructured variable names
    # see the accompanying codebook and readme text, which can be found here:
    # https://github.com/optisizer/ExploratoryDataAssignment
    
    # Place it in your current working directory

    # Locate and download file, as instructed by assignment text:
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "SamsungAccelerometerData.zip")

    # Unzip file into directory: 
    zipfile <- "SamsungAccelerometerData.zip"
    unzip(zipfile)
    
    # Read the feature list - one column only - into a data frame and name the column:
    featurelist <- subset(read.table("./UCI HAR Dataset/features.txt", header=FALSE), select=2)
    colnames(featurelist) <- "featurelist"
    
    # Find the list items holding data for -mean() and -std() calculations and place in vector...
    # To achieve, make initial name structuring:
    featurelist$featurelist <- gsub("\\()", "-", featurelist$featurelist)
    # Then find correct columns and place in itemselect vector:
    means <- grep("-mean-", featurelist$featurelist)
    stds <- grep("-std-", featurelist$featurelist)
    itemselect <- sort(c(means, stds))
    # Shorten the feature list according to the itemselect vector:
    featurelist <- featurelist$featurelist[itemselect]
    
    # Additional name structuring of the items in the modified featurelist:
        # (based on the CamelCasing principle for readability - as opposed to course guidelines)
    featurelist <- gsub(" ", "", featurelist)
    featurelist <- gsub("-", "", featurelist)
    featurelist <- sub("^t", "TimeSignal", featurelist)
    featurelist <- sub("^f", "FrequencySignal", featurelist)
    featurelist <- sub("BodyBody", "Body", featurelist)     # Correcting what I assume is a typing error
    featurelist <- sub("Body", "FromBody", featurelist)
    featurelist <- sub("Gravity", "FromGravity", featurelist)
    featurelist <- sub("Acc", "AccelerometerData", featurelist)
    featurelist <- sub("Gyro", "GyroscopeData", featurelist)
    featurelist <- sub("Jerk", "OfJerkMove", featurelist)
    featurelist <- sub("Mag", "Magnitude", featurelist)
    featurelist <- sub("mean", "MeanValue", featurelist)
    featurelist <- sub("std", "StandardDeviationValue", featurelist)
    featurelist <- sub("X$", "InTheXplane", featurelist)
    featurelist <- sub("Y$", "InTheYplane", featurelist)
    featurelist <- sub("Z$", "InTheZplane", featurelist)
    
    # Read the train and test sets into individual data frames:
        # Use the subset function to select columns from the itemselect vector
    trainset <- subset(read.table("./UCI HAR Dataset/train/x_train.txt", header=FALSE), select=itemselect)
    testset <- subset(read.table("./UCI HAR Dataset/test/x_test.txt", header=FALSE), select=itemselect)
    
    # "Merge" the two data sets by simple r-binding:
        # ("Merge" is a misnormer here as we are not merging on any shared info or id-key)
    combinedset <- rbind(trainset, testset)
    
    # Read the activity levels for the train and test sets - one column each - and combine them:
    trainlevels <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
    testlevels <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
    combinedlevels <- rbind(trainlevels, testlevels)
    
    # Read the subject identification info for the train and test sets - one column each - and combine them:
    trainsubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
    testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
    combinedsubjects <- rbind(trainsubjects, testsubjects)
    
    # Combine all combined- data frames created into one main data frame, and name the columns:
    totaldata <- cbind(combinedlevels, combinedsubjects, combinedset)
    # When we have combined everything we can remove any rows with uncomplete cases
        # (we could not do this earlier as we would have interupted the alignment between the data frames)
    colnames(totaldata) <- c("TypeOfHumanActivity", "TestSubjectIdNumber", featurelist)
    totaldata <- totaldata[complete.cases(totaldata), ]
    
    # Factorize the activity levels and the subject identification info...
    # Read the table comparing numbered and spelled out activities, and store as character vector
    activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
    activitylabels <- as.character(activitylabels[, 2])
    # Restructure the labels (based on the CamelCasting principle)
    activitylabels <- sub("WALKING", "Walking", activitylabels)
    activitylabels <- sub("UPSTAIRS", "Upstairs", activitylabels)
    activitylabels <- sub("DOWNSTAIRS", "Downstairs", activitylabels)
    activitylabels <- sub("SITTING", "Sitting", activitylabels)
    activitylabels <- sub("STANDING", "Standing", activitylabels)
    activitylabels <- sub("LAYING", "Laying", activitylabels)
    activitylabels <- sub("WALKING", "Walking", activitylabels)
    activitylabels <- gsub("_", "", activitylabels)
    
    # Factorize variable TypeOfHumanActivity:
    totaldata$TypeOfHumanActivity <- factor(totaldata$TypeOfHumanActivity , levels=1:6, labels = activitylabels)
    # Factorize variable TestSubjectIdNumber, but keep the number:
    totaldata$TestSubjectIdNumber <- factor(totaldata$TestSubjectIdNumber)
    
    # Preparations for running loops to calculate mean values on measured values...
    collectedaverages <- data.frame()
    # Split original data frame into a list, according to activities and count list items:
    activitybuckets <- split(totaldata, totaldata$TypeOfHumanActivity)
    activities <- length(activitybuckets)
    
    # Double loop for calculating mean values, depending on activity and test subject...
    # Run through outer loop one time per activity:
    for(i in 1:activities)   {
        selectetactivity <- activitybuckets[[i]]
        # Split each activity-split data frame into a list, according to test subjects, and count list items:
        humanbuckets <- split(selectetactivity, selectetactivity$TestSubjectIdNumber)
        humans <- length(humanbuckets)
        
        # Run through inner loop one time per test subject:
        for(j in 1:humans)   {
            selectedhuman <- humanbuckets[[j]]
            # Function colMeans is selected for simplicity, for the means calculations:
                # (in favor of lapply or sapply, which also can be used on multi-column list items)
            averages <- c(i, j, colMeans(selectedhuman[, 3:68]))
            # New and tidy independent data frame is created here:
            collectedaverages <- rbind(collectedaverages, averages)
        }
    }
    
    # The above loop will produce a wide table with all activities grouped one by one,
    # all test subjects listed sequentially for each activity, followed by all calculated variables
    
    # Name the columns in the new and tidy data frame, same way as the original one:
    colnames(collectedaverages) <- c("TypeOfHumanActivity", "TestSubjectIdNumber", featurelist)

    # Factorize variable TypeOfHumanActivity:
    collectedaverages$TypeOfHumanActivity <- factor(collectedaverages$TypeOfHumanActivity , levels=1:6, labels = activitylabels)
    # Factorize variable TestSubjectIdNumber, but keep the number:
    collectedaverages$TestSubjectIdNumber <- factor(collectedaverages$TestSubjectIdNumber)
    
    # Save table as a comma separated txt file, so it can be read correctly with the read.csv function
    write.table(collectedaverages, file="TidyAverageAccelerometerData.txt", sep=",", row.names = FALSE)
    
    print("Done! Created file can be found in your working directory, named TidyAverageAccelerometerData.txt")
    
}