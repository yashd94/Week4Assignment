
#README File
This readme explains the process followed in the ‘run_analysis.R’  script. The script combines the test and train datasets into a single data set, and tidies the data.

##Reading in the two datasets into separate data frames

The files to be read in are ‘X_train.txt’ and ‘X_test.txt’. Both are tab (‘\t’) delimited. Both are read into separate data frames using the read.table() function.


##Reading in the test labels and combining them:

Next, the labels for the data are read in. These are contained in the ‘y_train.txt’ and ‘y_test.txt’ files, and denote the activity for which an observation is shown. Both test and train labels data are read into data frames, and then combined into a single data frame using ‘rbind()’.

##Reading in the subject IDs and combining them:
The same process that is followed for the labels (above) is also followed for the subjects. 

##Reading in the label number to label name file and updating the names of the dataset:
The activity labels denote certain activities, a mapping for which can be found in the file ‘activity_labels.txt’. This is read into a data frame in order to obtain the activity name from its ID (label) later on in the script.

##Combining the test and train datasets:
The test and the train datasets are combined using ‘rbind()’.


##Reading in the variable names from the 'features.txt' file into a data frame and creating a factor array:

The variables under observation are also present in the UCI HAR Dataset folder, in the ‘features.txt’ file. These are read into R and stored as a factor.

##Assigning VarNames to the names of the initial combined dataset and adding labels, label names, and subject ID columns:

The dataset is now assigned to another data frame. Post this, the variable names are updated to reflect the names from the ‘features.txt’ file. Label names are also obtained against their label IDs by using ‘merge()’ with the label ID to label name data frame created earlier.


##Extracting only those data which have information regarding mean or standard deviation:

Using grep, only those data for which the names of the data frame match either ‘mean’ or ‘std’ are extracted. These are combined. Names are updated accordingly, and a third data frame is created. 

##Grouping the set by Subject and Activity, and summarise each column to calculate the mean:

Using the ‘group_by()’ and ‘summarise_all()’ functionalities of the dplyr package, the data is grouped by subject and activity, and all columns are summarised, i.e. average if taken of each variable over each group.


#Cleaning up unwanted columns:

Since the dataset is now aggregated, columns that are no longer required are cleaned up, and names are updated accordingly.

##Writing the tidied data to a tab delimited text file:

The final tidy dataset (COMBINED_SET_4) is written to a tab (‘\t’) delimited text file. 

