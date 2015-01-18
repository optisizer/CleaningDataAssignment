##CodeBook
(This is a permitted repost of my original assignment, made about 6 months ago. I am retaking the course awaiting the capstone project. Due to business travels I didn have time to redo the assignment.)
###Original experiment description

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

###Table of how column names in the data frame totaldata relates to the original data frames, holding the data:
 * Relating to Step 7, in the readme file
    - DATA FRAME ORIGIN ==  COLUMN NAME IN totaldata
    - combinedlevels  ==  TypeOfHumanActivity
    - combinedsubjects  ==  TestSubjectIdNumber
    - combinedset ==  Se table below, for original and new names

###List of variable names

  * These are the variables originaly read into the data frame combinedset
  * Derived from the features.txt file
  * Original names are restructured to new names in Step 3 in the readme file
  * Applied to the totaldata and collectedaverages data frames, in Steps 7 and 9 in the readme file
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
