CleaningDataAssignment
======================
The r script and codebook for Data Science, Getting and Cleaning Data Course, Week 3

There is only one script. It is named: run_analysis.R

The script, as well as its accompanying codebook can be found in this repository

The script follows exactly the step by step process outlined in the codebook

The script is also properly annotated in a step by step fashion, so it too should work as an instruction list

For any additional information I refer you to either the script or the codebook

Discussion:
It seems to me that the instructions as to what goes where in regards to this readme file and the codebook is a bit confusing. From the lessons it seems the codebook should focus on presenting pre and post data, while the instruction list focuses on the coded process. It even says the instruction list could be the script itself. I assume as long as it is well annotated.
From that point of view my codebook provides the information this readme file should provide, so I’m in the wrong here. However, because my code is properly annotated I still feel I am following the principles we have learned from the lessons. That is, my script also doubles as my instruction list.
Further, reading the instructions for this specific assignment, and as this assignment is all about cleaning and transforming data, I interpret “any transformations or work that you performed to clean up the data” that should go into
the codebook, in this case must be an instructive list of the actual code. So from that point of view it confirms that the instruction list of what the code does should go into the codebook, to comply with assignment instructions.

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
  * Name the columns in data frame totaldata (again based on the CamelCasing principle)
  * Table of how the column names relate to the data frames they came with:
  
    - DATA FRAME ORIGIN ==  COLUMN NAME IN totaldata
    - combinedlevels  ==  TypeOfHumanActivity
    - combinedsubjects  ==  TestSubjectIdNumber
    - combinedset ==  Se table at end of document, for original and new names

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
