run_analysis <- function() {         

##load required library
	library(reshape2)
	library(plyr)
##check for UCI HAR Dataset
	root <- getwd()
	print("checking for files")
	dataDir = "./UCI HAR Dataset"
	if (!file.exists(dataDir)) {
	print("error UCI HAR Dataset not found")
	}

		##function for rading files	
				ReadData <- function(FPath) {
				return(read.table(sprintf("%s/%s", dataDir, FPath), header=FALSE))
				}

##Acquire labels
	df_ActLabels <- ReadData("activity_labels.txt")
	names(df_ActLabels) <- c("index", "activity name")
	
	df_Features <- ReadData("features.txt")
	names(df_Features) <- c("index", "descriptiveVariableNames")
Features <- df_Features
	print("labels aquired")

##read in datasets
	df_Train_Subject <- ReadData("train/subject_train.txt") 
	df_Train_Y <- ReadData("train/y_train.txt") 
	df_Train_X <- ReadData("train/X_train.txt") 

	print("Train datasets aquired")

	df_Test_Subject <- ReadData("test/subject_test.txt")
	df_Test_Y <- ReadData("test/y_test.txt")
	df_Test_X  <- ReadData("test/X_test.txt")


	print("Test datasets aquired")

##Merge datasets and label

	Merge_subjects <- c(df_Train_Subject[, 1], df_Test_Subject[, 1])
    Merge_labels <- c(df_Train_Y[, 1], df_Test_Y[, 1])
	##Create activity labels column based on index
	ActivityNames <- factor(Merge_labels, levels=c(1, 2, 3, 4, 5, 6), labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
	


	##Merge_df <- cbind(Merge_labels,Merge_subjects)
	Merge_df <- data.frame(ActivityNames,Merge_subjects)
	names(Merge_df) <- c("ActivityNames", "Subject")

	##Create activity labels column based on index 
	

	Merge_data <- rbind(df_Train_X , df_Test_X )
    names(Merge_data) <- df_Features$descriptiveVariableNames

	Merge_df2 <- cbind(Merge_df,Merge_data)

	Raw_mergedData <<- Merge_df2
	print("datasets merged")

##subset mean and standard deviation variables
	ListMeanVars <- grepl("mean()", df_Features$descriptiveVariableNames) 
	ListStdevVars <- grepl("std()", df_Features$descriptiveVariableNames)
	VarsList <- ListMeanVars | ListStdevVars
	
	sub_df <- Merge_data[,VarsList]
	tidy_df <- cbind(Merge_df,sub_df)
	
	print("Subset Mean and Standard Deviation variables Completed")


##melt dataset calc means and sort
	values <-colnames(tidy_df)
	data_melt <- melt(tidy_df, id=c("ActivityNames", "Subject"), measure.vars=values[3:81])
	TidyData <- dcast(data_melt, ActivityNames+Subject~variable,value.var = "value", mean)
	TidyData <- arrange(TidyData,ActivityNames,Subject)

	print("Tidy dataset created, writing files")
##write files
	write.table(Raw_mergedData,file=file.path(root , "Raw_mergedData.txt"),sep=" ",row.names=FALSE)
	write.table(TidyData,file=file.path(root , "tidy_data.txt"),sep=" ",row.names=FALSE)
	print("Analysis finished")
} 