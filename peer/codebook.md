Codebook
=================================================
Getting and Cleaning Data

File with variables descriptions: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      

RUN_ANALYSIS.R Step by Step  

- Read X_train.txt, y_train.txt and subject_train.txt from the data/train folder.
- Store train values in trainData, trainLabel and trainSubject variables respectively.       
- Read X_test.txt, y_test.txt and subject_test.txt from the data/test folder.
- Store test values in testData, testLabel and testsubject variables respectively.  
- Concatenate testData to trainData to generate a 10299x561 data frame called joinData.
- Concatenate testLabel to trainLabel to generate a 10299x1 data frame called joinLabel.
- Concatenate testSubject to trainSubject to generate a 10299x1 data frame called joinSubject.  
- Read the features.txt file from the /data folder.
- Store the data in a variable called features. We only extract the measurements on the mean and standard deviation. Get a subset of joinData with the 66 corresponding columns.  
- Clean the column names of the subset. Remove the "()" and "-" in the names, first letter of mean and std a capital letter M and S.   
- Read the activity_labels.txt file from the ./data folder.
- Store the data in a variable called activity.  
- Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore remove it and capitalize the letter after the underscore.  
- Transform the values of joinLabel according to the activity data frame.  
- Combine the joinSubject, joinLabel and joinData by column to get a new cleaned 10299x68 data frame called cleanedData. The subject column contains integers that range 1 to 30. The activity column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1.  
- Write the cleanedData out to merged_data.txt file in current working directory.  
- Generate a second tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.
- Write the result out to data_with_means.txt file in current working directory.