run_analysis <- function() {
        cat(".")
        ## Read all the relevant files into data frames
        DF_X_test<- read.table("test/X_test.txt"); cat(".")
        DF_y_test<- read.table("test/y_test.txt"); cat(".")
        DF_subject_test<- read.table("test/subject_test.txt"); cat(".")
        DF_X_train<- read.table("train/X_train.txt"); cat(".")
        DF_y_train<- read.table("train/y_train.txt"); cat(".")
        DF_subject_train<- read.table("train/subject_train.txt"); cat(".")
        DF_column_names<- read.table("features.txt")
        activity_labels<-read.table("activity_labels.txt")
        ## Convert the data frame containing the column-name information to a char vector
        column_names<- as.vector(DF_column_names[,2])
        ## map activity codes to names by merging the two data-sets
        DF_y_test_aug<-merge(DF_y_test, activity_labels)
        DF_y_train_aug<-merge(DF_y_train, activity_labels)
        ## merge the test and training data-sets with their subjects and activity names
        DF_test<- cbind(DF_subject_test, DF_y_test_aug[,2], DF_X_test)
        DF_train<- cbind(DF_subject_train, DF_y_train_aug[,2], DF_X_train)
        ## Adjust the column names to reflect the merges, and assign them to the DFs
        column_names2<- c("Subject", "Activity", column_names)
        colnames(DF_test)<- column_names2
        colnames(DF_train)<- column_names2
        ## Now that the two data frames have the same column names, 
        ## merge them
        DF_all<- rbind(DF_test, DF_train)
        ## Identify the columns of interest
        ## First and second, which contain our subjects and their activity?
        ## then the ones that contain mean and standard deviation measurements
        interesting_column_idx<- c(as.numeric("1"), as.numeric("2"), grep("std|mean", column_names2))
        ## Subset the data frame with only the interesting columnts
        DF_std_mean<-DF_all[, interesting_column_idx]
        ## Create index including first Activity, then Subject
        ind<-list(DF_std_mean$Activity, DF_std_mean$Subject)
        ## Generate a new data frame using the index
        DF_new<-aggregate(DF_std_mean[,3:ncol(DF_std_mean)], by=ind, mean)
        ## Fix the first and second column names
        colnames(DF_new)[1]<-"Activity"
        colnames(DF_new)[2]<-"Subject"
        ## Write the output file
        write.table(DF_new, file="Step5-data.txt", row.name=FALSE)
        cat("Done.  \nOutput file is 'Step5-data.txt' in current working directory\n")
}
       