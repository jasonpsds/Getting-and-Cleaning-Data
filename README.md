#Coursera Data Science Specialization Getting and Cleaning Data
-----
This is the peer assessment project for the Coursera Data Science Specialization Getting and Cleaning Data course.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones] 

Here is the link to the data for this project: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

*Download the data and unzip to you working directory.*

run_analysis.R  (R script for this project must be in the root folder not the UCI HAR Dataset folder)
###Description of function
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Before running the function set your working directory to whatever directory you have downloaded the files into. In this example the working directory would be Project. 

The run_analysis() function does not take any parameters, and will check for the UCI HAR Dataset directory in the same directory. If you put the run_analysis file inside the UCI HAR Dataset directory it will not work and will give an error message.

The run_analysis() function **requires the reshape2 and plyr packages installed** and will load the libraries when the function runs. Feedback statements are presented by the run_analysis() function at each stage of the data analysis and files 

Full details of files and variables are available in the codebook.md file 
