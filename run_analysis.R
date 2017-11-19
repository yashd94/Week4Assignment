#This script combines the test and train datasets into a single data set, and tidies the data.

##Reading in the two datasets into separate data frames:

setwd("~/Documents/R-WD")
X_TEST <- read.table("UCI HAR Dataset/test/X_test.txt")
X_TRAIN <- read.table("UCI HAR Dataset/train/X_train.txt")


##Reading in the test labels and combining them:

X_TEST_LABELS <- read.table("UCI HAR Dataset/test/y_test.txt")
X_TRAIN_LABELS <- read.table("UCI HAR Dataset/train/y_train.txt")
LABELS <- rbind(X_TEST_LABELS, X_TRAIN_LABELS)
names(LABELS) <- "Label"

##Reading in the subject IDs and combining them:
SUBJECTS_TEST <- read.table("UCI HAR Dataset/test/subject_test.txt")
SUBJECTS_TRAIN <- read.table("UCI HAR Dataset/train/subject_train.txt")
SUBJECTS_SET <- rbind(SUBJECTS_TEST, SUBJECTS_TRAIN)

##Reading in the label number to label name file and updating the names of the dataset:

LABEL_NAMES <- read.table("UCI HAR Dataset/activity_labels.txt")
names(LABEL_NAMES) <- c("Label", "LabelName")

##Combining the test and train datasets:

COMBINED_SET_1 <- rbind(X_TEST, X_TRAIN)

##Reading in the variable names from the 'features.txt' file into a data frame and 
##creating a factor array:

VarNames <- read.table("UCI HAR Dataset/features.txt")
VarNames <- VarNames$V2

##Assigning VarNames to the names of the initial combined dataset and 
##adding labels, label names, and subject ID columns:

COMBINED_SET_2 <- COMBINED_SET_1
names(COMBINED_SET_2) <- VarNames
COMBINED_SET_2$Label <- LABELS$Label
COMBINED_SET_2$LabelName <- NULL
COMBINED_SET_2 <- merge(COMBINED_SET_2, LABEL_NAMES, by = "Label", all.x = TRUE)
COMBINED_SET_2$Subject <- SUBJECTS_SET

##Extracting only those data which have information regarding mean or standard deviation:
COMBINED_SET_2_mean <- COMBINED_SET_2[grep("mean()", names(COMBINED_SET_2))]
Mean_Names <- grep("mean()", names(COMBINED_SET_2), value = TRUE)
COMBINED_SET_2_std <- COMBINED_SET_2[grep("std()", names(COMBINED_SET_2))]
Std_Names <- grep("std()", names(COMBINED_SET_2), value = TRUE)
COMBINED_SET_2_Labels <- COMBINED_SET_2$Label
COMBINED_SET_2_LabelNames <- COMBINED_SET_2$LabelName
COMBINED_SET_2_Subjects <- COMBINED_SET_2$Subject
VarNamesFilt <- c(c("Subject", "Label", "LabelName"), Mean_Names, Std_Names)
COMBINED_SET_3 <- cbind(COMBINED_SET_2_Subjects, COMBINED_SET_2_Labels, COMBINED_SET_2_LabelNames, COMBINED_SET_2_mean, COMBINED_SET_2_std)
names(COMBINED_SET_3) <- VarNamesFilt

##Grouping the set by Subject and Activity, and summarise each column to calculate the mean:
COMBINED_SET_4 <- COMBINED_SET_3 %>% group_by(COMBINED_SET_3$Subject, COMBINED_SET_3$LabelName) %>% summarise_all(mean, na.rm=TRUE) 

#Cleaning up unwanted columns:
COMBINED_SET_4$Subject <- NULL
COMBINED_SET_4$Label <- NULL
COMBINED_SET_4$LabelName <- NULL

colnames(COMBINED_SET_4)[1] <- "Subject"
colnames(COMBINED_SET_4)[2] <- "Activity"

##Writing the tidied data to a tab delimited text file:
write.table(COMBINED_SET_4, "Week4AssignmentData-Tidy.txt", sep = "\t", row.name=FALSE)
