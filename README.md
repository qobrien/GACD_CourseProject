This README file provides information on the study description (i.e., how raw signal data were obtained) and data cleaning (i.e., provided files and raw data, as well as the methodology for how the final dataset was created).

##Study Description
###From the study team itself: 

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain (Reyes-Ortiz et al 2012).

##Data Cleaning
Based on the above study description, raw data in the form of 561 feature variables were provided for 30 subjects performing 6 activities. The purpose of the code presented in "run_analysis.R" is to coherently form a final dataset that contains the means and standard deviations of each mean() and std() raw variable per each subject and each activity. In order to do this a systematic process was employed, described below. It is first necessary to define the original inputs provided by the *Human Activity Recognition Using Smartphones Dataset* (Reyes-Ortiz et al 2012).

###Provided Files
The study team provided the following files used for this particular analysis:

* README.txt
* features_info.txt - shows information about the features variables
* features.txt - list of all features
* activity_labels.txt - links numerical codes (1-6) to activities performed
* X_train.txt - training set
* y_train.txt - training labels
* subject_train.txt - proper subject labels (1-30) for training set
* X_test.txt - test set
* y_test.txt - test labels
* subject_test.txt - proper subject labels (1-30) for test set

###Description of Raw Data Provided
Raw data is provided by the Reyes-Ortiz study team for each individual record:

* Triaxial (X, Y, and Z directions) acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial angular velocity from the gyroscope.
* A 561-feature vector with time (t) and frequency (f) domains variables; these are the 561 variables mentioned above.
* An activity label (6 possible).
* A numerical identifier of the specific subject (1-30).

##Method

1. After defining the proper working directory, the reshape R package was employed to ensure proper reshaping (i.e., melting and casting) of data.
2. The provided files were loaded into the R environment.

+ The file activity_labels.txt was loaded first since it would be used by both the training and test datasets.
+ The test data files (subject_test.txt, X_test.txt, and y_test.txt) were loaded next.
+ The y_test.txt column data was renamed to Activity and labeled with the activity labels.
+ Using cbind, the files were combined into a test dataset, organized with Activity in the first column, then the Subject identifier (subject_test.txt) and the feature variables (X_test.txt)
+ The train data files (subject_train.txt, X_train.txt, and y_train.txt) were loaded next.
+ The y_train.txt column data was renamed to Activity and labeled with the activity labels.
+ Using cbind, the files were combined into a test dataset, organized with Activity in the first column, then the Subject identifier (subject_train.txt) and the feature variables (X_train.txt)

3. Using rbind, the test and train datasets were combined.
4. Appropriate column labels were added to each of the variables.

+ The features.txt file was loaded into the R environment, as it contained labels for the 561 feature variables.
+ Using the names() function, the dataset columns were labeled as Activity, Subject, and the 561 features.

5. Only the variables coding for measurements of mean and standard deviation were extracted from the dataset and loaded into the initial tidy data set (tidy_data.txt). This was done using grep to perform a wildcard search of "mean()" and "std()" from the feature variables and loading the extracted features into a new tidy dataset along with the Activity and Subject. This tidy dataset was then written out of R as "tidy_data.txt".

+ A message was printed to notify the user that the datset was created and is saved in the working directory.

6. The final dataset (tidy_data_means_only.txt) was created by reshaping the data so that the only the average (mean) of each variables for each activity and each subject is shown.

+ First, the tidy data was melted by the extracted means and std variables.
+ Next, the melted data was cast by the means of the extracted variables using the dcast function.
+ Finally, the newly reshaped data was written out of R as "tidy_data_means_only.txt".
+ A second message was printed to notify the user that the datset was created and is saved in the working directory.

##Final Products
* tidy_data.txt - a dataset containing only measurements on the mean and standard deviation
* tidy_data_means_only.txt - a dataset containing only the average of each variable for each activity and each subject

##References/License
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. Human Activity Recognition Using Smartphones Dataset. Version 1.0. Nov 2012
