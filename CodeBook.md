Introduction

This assignment consisted of cleaning up the data, renaming variables and calculating averages from an experiment
on “Human Activity Recognition Using Smartphones”. Then create a tidy table and upload to Coursera a text file
containing the created table, together with some accompanying documentation (such as this codebook) and an R script
file (run_analysis.R). A short description of the experiment by the original makers, explaining the variables, can be
found at the end of this document. Also at the end of a document is a complete list of variables in the table, listed
with both original and new names.

The assignment recommended the following step by step process:

Create one R script called run_analysis.R that does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4.  Appropriately labels the data set with descriptive variable names. 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Simultaneously a code book (this document), called CodeBook.md, should be created that:
  * describes the variables
  * the data
  * any transformational work
  * the process to clean up the data

Download and read the file

My step by step process

What follows is the step by step process I followed in order to complete the assignment. I have listed a few more
and detailed steps here than shown in the original assignment list. Where my steps coincide with the assignment list,
the order also differs slightly, as will be explained in each step. This is also the sequence followed in the
submitted run_analysis.R file. This document does not list the actual R-functions used, or any of the arguments
such functions might use. They are all apparent in the run_analysis.R file

Step 1 – Downloading the data
  * Locate and download file, as instructed by assignment text
  * Unzip file into directory

Step 2 – Select what to read into R

Reading through the downloaded data and its documentation, we find in the Readme.txt file that we need to read
the following files into R:

  * features.txt – List of all features
  * train/X_train.txt – Training set measured on human activity by test subjects
  * test/X_test.txt – Test set measured on human activity by test subjects
  * train/y_train.txt – Training levels in range 1:6, identifying human activity
  * test/y_test.txt – Test levels in range 1:6, identifying human activity
  * train/subject_train.txt – Numbers in range 1:30 identifying the test subjects
  * test/subject_test.txt – Numbers in range 1:30 identifying the test subjects
  * activity_labels.txt – Spelled out activities, corresponding to the Y_train.txt and Y_test.txt files

Step 3 – Reading the features.txt file
  * Read the features.txt file, one column only, into a data frame named featurelist
  * Find the items in the data frame featurelist holding data for -mean() and -std() calculations (in accordance
  * with assignment step 2) and place in vector. To achieve
    - Make initial name structuring
    - Find correct columns and place in a vector named itemselect.
    - Shorten the data frame featurelist by subsetting according to the itemselect vector
  * Perform additional name structuring of the items in the modified featurelist (in accordance with assignment step 4) 

* Note: Based on the CamelCasing principle for readability, as opposed to course guidelines, which suggests lower case only
* Note: Also correcting what I assume is a typing error (the phrase “BodyBody” appears in the featurelist, but not in the documentation, I have assumed it should say just “Body”)

Step 4 – Reading the X_train.txt and the X_test.txt files
  * Read the train and test sets into individual data frames, named trainset and testset, selecting only columns from
  the itemselect vector (in accordance with assignment step 2)
  * “Merge" the two data frames (in accordance with assignment step 1) into one data frame named combinedset

* Note: "Merge" is a misnomer here as we are not truly merging on any shared info or id-key, only combining

Step 5 – Reading the Y_train.txt and the Y_test.txt files
  * Read the activity levels for the train and test sets, one column each, and place into data frames trainlevels
  and testlevels
  * Combine the data frames trainlevels and testlevels into one data frame named combinedlevels

Step 6 – Reading the subject_train.txt and the subject_test.txt files
  * Read the subject identification info for the train and test sets, one column each, and place into data
  frames trainsubjects and testsubjects
  * Combine the data frames trainsubjects and testsubjects into one data frame named combinedsubjects

Step 7 – Combining the created data frames
  * Combine all combined- data frames created into one main data frame called totaldata
  * Name the columns in data frame totaldata (again based on the CamelCasing principle):

Data frame originColumn name in totaldatacombinedlevelsTypeOfHumanActivitycombinedsubjectsTestSubjectIdNumbercombinedsetSe table at end of document, for original and new names

  * Check for and remove any rows with un-complete cases
    - Note: Not possible at any earlier stage as that would have interrupted the alignment between the data frames

Step 8 – Factorize columns in totaldata
  * Read the activity_labels.txt file, which assigns spelled out activities to the numbered levels in the Y_train.txt
  and Y_test.txt files
  * Store as character vector named activitylabels
  * Restructure the labels (based on the CamelCasting principle)
  * Factorize column TypeOfHumanActivity
  * Factorize column TestSubjectIdNumber

Step 9 – Calculate averages of each variable for each activity and each subject

(in accordance with assignment step 5)

Discussion: I like working with loops, as it helps me understand the process intuitively. Therefore I have chosen not
to work with any of the commandline loop functions, such as lapply, tapply, etc. Further, I once read in the help
files, but can’t remember where, that it is recommended not to use commandline loops in programmed code. To begin:

  * Create empty data frame named collectedaverages
  * Split data frame totaldata according to factorized variable TypeOfHumanActivity
  * This creates the list activitybuckets, holding six items (one for each activity)
  * Run outer loop on each item in the activitybuckets list
    - Split each item according to factorized variable TestSubjectIdNumber
    - This creates the list humanbuckets, holding 30 items (one for each test subject)
    - Run inner loop on each item in the humanbuckets list
      + Calculate the averages for the test variables
      + Combine the calculations with data frame collectedaverages
  * When loops completed
    - Name the columns in data frame collectedaverages the same way as previously named in data frame totaldata
    (see Step 7)
    - Factorize the columns TypeOfHumanActivity and TestSubjectIdNumber same way as previously factored in data
    frame totaldata (see step 8)

Step 10 – Saving data to file
  * Save the data frame collectedaverages to a comma separated text file named TidyAverageAccelerometerData.csv
  in your working directory

Original experiment description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each
person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have
been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets,
where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which
has gravitational and body motion components, was separated using a Butterworth low-pass filter into body
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a
filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ
and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using
a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low
pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also
the magnitude of these three-dimensional signals were calculated using the Euclidean norm.

Finally a Fast Fourier Transform (FFT) was applied to some of these signals.

List of variable names

  * Derived from the features.txt file
  * Original names are restructured to new names in Step 3, above
  * Applied to the totaldata and collectedaverages data frames
  * The actual data have previously been derived from the X_train.txt and X_test.txt files
  * Reading the list below, the original names to the left, the new names to the right, separated by ==
  * Because of their length, the new names are based on the CamelCasing principle for readability. This is not in line
  with the course recommendations.
  * From top to bottom, the new names are applied left to right in the data frames, immediately following the
  columns TypeOfHumanActivity and TestSubjectIdNumber.
  * It is unclear from the original documentation as to what are the measured units, but as the data also are normalized
  I have assumed they are simply unit-less values in the range -1 to 1.

* tBodyAcc-mean()-X ==  TimeSignalFromBodyAccelerometerDataMeanValueInTheXplane
* tBodyAcc-mean()-Y ==  TimeSignalFromBodyAccelerometerDataMeanValueInTheYplane
* tBodyAcc-mean()-Z ==  TimeSignalFromBodyAccelerometerDataMeanValueInTheZplane
* tBodyAcc-std()-X  ==  TimeSignalFromBodyAccelerometerDataStandardDeviationValueInTheXplane
* tBodyAcc-std()-Y  ==  TimeSignalFromBodyAccelerometerDataStandardDeviationValueInTheYplane
* tBodyAcc-std()-Z  ==  TimeSignalFromBodyAccelerometerDataStandardDeviationValueInTheZplane
* tGravityAcc-mean()-X  ==  TimeSignalFromGravityAccelerometerDataMeanValueInTheXplane
* tGravityAcc-mean()-Y  ==  TimeSignalFromGravityAccelerometerDataMeanValueInTheYplane
* tGravityAcc-mean()-Z  ==  TimeSignalFromGravityAccelerometerDataMeanValueInTheZplane
* tGravityAcc-std()-X ==  TimeSignalFromGravityAccelerometerDataStandardDeviationValueInTheXplane
* tGravityAcc-std()-Y ==  TimeSignalFromGravityAccelerometerDataStandardDeviationValueInTheYplane
* tGravityAcc-std()-Z ==  TimeSignalFromGravityAccelerometerDataStandardDeviationValueInTheZplane
* tBodyAccJerk-mean()-X ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveMeanValueInTheXplane
* tBodyAccJerk-mean()-Y ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveMeanValueInTheYplane
* tBodyAccJerk-mean()-Z ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveMeanValueInTheZplane
* tBodyAccJerk-std()-X  ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveStandardDeviationValueInTheXplane
* tBodyAccJerk-std()-Y  ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveStandardDeviationValueInTheYplane
* tBodyAccJerk-std()-Z  ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveStandardDeviationValueInTheZplane
* tBodyGyro-mean()-X  ==  TimeSignalFromBodyGyroscopeDataMeanValueInTheXplane
* tBodyGyro-mean()-Y  ==  TimeSignalFromBodyGyroscopeDataMeanValueInTheYplane
* tBodyGyro-mean()-Z  ==  TimeSignalFromBodyGyroscopeDataMeanValueInTheZplane
* tBodyGyro-std()-X ==  TimeSignalFromBodyGyroscopeDataStandardDeviationValueInTheXplane
* tBodyGyro-std()-Y ==  TimeSignalFromBodyGyroscopeDataStandardDeviationValueInTheYplane
* tBodyGyro-std()-Z ==  TimeSignalFromBodyGyroscopeDataStandardDeviationValueInTheZplane
* tBodyGyroJerk-mean()-X  ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveMeanValueInTheXplane
* tBodyGyroJerk-mean()-Y  ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveMeanValueInTheYplane
* tBodyGyroJerk-mean()-Z  ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveMeanValueInTheZplane
* tBodyGyroJerk-std()-X ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveStandardDeviationValueInTheXplane
* tBodyGyroJerk-std()-Y ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveStandardDeviationValueInTheYplane
* tBodyGyroJerk-std()-Z ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveStandardDeviationValueInTheZplane
* tBodyAccMag-mean()  ==  TimeSignalFromBodyAccelerometerDataMagnitudeMeanValue
* tBodyAccMag-std() ==  TimeSignalFromBodyAccelerometerDataMagnitudeStandardDeviationValue
* tGravityAccMag-mean() ==  TimeSignalFromGravityAccelerometerDataMagnitudeMeanValue
* tGravityAccMag-std()  ==  TimeSignalFromGravityAccelerometerDataMagnitudeStandardDeviationValue
* tBodyAccJerkMag-mean()  ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveMagnitudeMeanValue
* tBodyAccJerkMag-std() ==  TimeSignalFromBodyAccelerometerDataOfJerkMoveMagnitudeStandardDeviationValue
* tBodyGyroMag-mean() ==  TimeSignalFromBodyGyroscopeDataMagnitudeMeanValue
* tBodyGyroMag-std()  ==  TimeSignalFromBodyGyroscopeDataMagnitudeStandardDeviationValue
* tBodyGyroJerkMag-mean() ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveMagnitudeMeanValue
* tBodyGyroJerkMag-std()  ==  TimeSignalFromBodyGyroscopeDataOfJerkMoveMagnitudeStandardDeviationValue
* fBodyAcc-mean()-X ==  FrequencySignalFromBodyAccelerometerDataMeanValueInTheXplane
* fBodyAcc-mean()-Y ==  FrequencySignalFromBodyAccelerometerDataMeanValueInTheYplane
* fBodyAcc-mean()-Z ==  FrequencySignalFromBodyAccelerometerDataMeanValueInTheZplane
* fBodyAcc-std()-X  ==  FrequencySignalFromBodyAccelerometerDataStandardDeviationValueInTheXplane
* fBodyAcc-std()-Y  ==  FrequencySignalFromBodyAccelerometerDataStandardDeviationValueInTheYplane
* fBodyAcc-std()-Z  ==  FrequencySignalFromBodyAccelerometerDataStandardDeviationValueInTheZplane
* fBodyAccJerk-mean()-X ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveMeanValueInTheXplane
* fBodyAccJerk-mean()-Y ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveMeanValueInTheYplane
* fBodyAccJerk-mean()-Z ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveMeanValueInTheZplane
* fBodyAccJerk-std()-X  ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveStandardDeviationValueInTheXplane
* fBodyAccJerk-std()-Y  ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveStandardDeviationValueInTheYplane
* fBodyAccJerk-std()-Z  ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveStandardDeviationValueInTheZplane
* fBodyGyro-mean()-X  ==  FrequencySignalFromBodyGyroscopeDataMeanValueInTheXplane
* fBodyGyro-mean()-Y  ==  FrequencySignalFromBodyGyroscopeDataMeanValueInTheYplane
* fBodyGyro-mean()-Z  ==  FrequencySignalFromBodyGyroscopeDataMeanValueInTheZplane
* fBodyGyro-std()-X ==  FrequencySignalFromBodyGyroscopeDataStandardDeviationValueInTheXplane
* fBodyGyro-std()-Y ==  FrequencySignalFromBodyGyroscopeDataStandardDeviationValueInTheYplane
* fBodyGyro-std()-Z ==  FrequencySignalFromBodyGyroscopeDataStandardDeviationValueInTheZplane
* fBodyAccMag-mean()  ==  FrequencySignalFromBodyAccelerometerDataMagnitudeMeanValue
* fBodyAccMag-std() ==  FrequencySignalFromBodyAccelerometerDataMagnitudeStandardDeviationValue
* fBodyBodyAccJerkMag-mean()  ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveMagnitudeMeanValue
* fBodyBodyAccJerkMag-std() ==  FrequencySignalFromBodyAccelerometerDataOfJerkMoveMagnitudeStandardDeviationValue
* fBodyBodyGyroMag-mean() ==  FrequencySignalFromBodyGyroscopeDataMagnitudeMeanValue
* fBodyBodyGyroMag-std()  ==  FrequencySignalFromBodyGyroscopeDataMagnitudeStandardDeviationValue
* fBodyBodyGyroJerkMag-mean() ==  FrequencySignalFromBodyGyroscopeDataOfJerkMoveMagnitudeMeanValue
* fBodyBodyGyroJerkMag-std()  ==  FrequencySignalFromBodyGyroscopeDataOfJerkMoveMagnitudeStandardDeviationValue"
