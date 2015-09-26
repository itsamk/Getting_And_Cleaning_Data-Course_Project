# Getting And Cleaning Data - Course_Project

The attached R-script in this repository runs the required analysis as mentioned in the required course project in "Getting and Cleaning Data" Course under the "Data Science Specialization" in Coursera. 

Here is a link for you to check out the course.
[https://class.coursera.org/getdata-032/][1]


The requirement of the course project was to take the database from the [UCI Database][2].


  [1]: https://class.coursera.org/getdata-032/
  [2]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The code performs following tasks based on the assumption that the data is in the working directory(here, working directory and home directory are assumed to be the same).

 1. Merging the Training Set and Test Set Data.

       The first part of the code reads the data from the training set and merges the "X_train", "y_train" and "Subject_Train" to form a new data frame called 'train'.
    
    The same process is repeated to create another dataset with all the test values into the data frame 'test'.

    The above procedure is obtained through 'cbind' command to bind the columns together.

    The code proceeds further to use 'rbind' to bind the rows from the training set and the test set together.
    
    The code then assigns the variable names to all the columns reading into the "features.txt" file. The final data frame obtained is named "Data_Full".


      
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

      The code first removes all the columns with invalid and repeating variable names from the data frame. After this the code uses the 'select' function of the 'dplyr' package and selects all the variables that contain 'mean' or 'std' strings in them. This is again directly overwritten into the previously obtained data frame called "Tidy_dataset_one".

       NOTE: Strings looked for here are 'mean' and 'std' and NOT 'mean()' and 'std()' as all the columns that have means and standard deviations are to be considered.

    This also happens to remove the first 2 columns of the dataset that include 'activity' and the 'person' id. These columns are again re-added.

 3. Naming all the variables in Column 1 (Activity) to More Descriptive Variables

   This part of the code renames all the values(from 1 to 6) to their respective meanings as suggested by the "activity_labels.txt" file. Switch function is used to achieve the task and can be seen in a more descriptive way into the script itself.

 4. Appropriately labels the data set with descriptive variable names. 

    In this part of the script, all the variables are accordingly re-named to more descriptive names. The prefixes 'Time' or 'Frequency' indicate the domain the data is recorded in. The remaining parts are understandable by the variable names themselves. (As this was itself the requirement of this particular step).

    The function *gsub* is used to substitute the parts of the strings as necessary.

 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

     In this step, the code uses the *arrange* function of the *dplyr* package to sort the rows first according to the 'Person' id and then, the 'Activity' and then, uses 'group_by' function to group the data into separate levels and then, finds means of the observations that belong to the respective groups. In this way we obtain a new data frame called Final_Data is obtained.




   In these course of processes the final result is achieved. 


#**Required Packages:**
dplyr