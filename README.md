# Function run_analysis()
A single function that performs all the analysis required by the course project, and writes a file "Step5-data.txt" in the current working directory with the output. 

## Prerequisites:

1. The working directory needs to be the root directory where the Samsung wearable data is unzipped, and the original directory hierarchy of the archive must not be altered.
2. The file "run_analysis.R" must be placed in the current working directory, and executed as follows:

source("run_analysis.R")
run_analysis()


## Functional Steps:

1. The first 8 lines read the original data-sets into data frames with analogous names (and prefix "DF_").
2. Column names are obtained from the original "features.txt" file, and then pre-pended  with "Subject" and "Activity" in the first two positions, to obtain the final vector of column names (valiable column_names2).
3. The y_test and y_train data-sets are each merged with the activity labels (obtained from the activity_labels.txt file), that merge results in the DF_test and DF_train data frames respectively.
4. Both of these data frames are assigned meaningul column names with the content of the column_names2 vector.
5. At this point we contatenate the DF_test and DF_train data frames using rbind(), the resulting data frame is DF_all.
6. We then define the interesting_column_idx as a numeric vector that contains columns #1 and #2 (Subject and Activity), as well as all other columns that represent either mean or standard deviation data.  We then subset DF_all with this index to obtain a data frame with only the columns we care about.
7. We create another index "ind" as a list of the variables by which we want to do grouping when means are calculated (Activity and Subject).
8. DF_New is the resulting data frame, after the mean function is applied to each column of DF_std_mean (starting from the third), and the results are grouped by unique combinations of the values in column 1 and 2.
9. Finally, after fixing the first two column names, we output DF_new as a result file. 


## Codebook
See the file "Codebook.csv" for complete list of new variables used in the script.  
