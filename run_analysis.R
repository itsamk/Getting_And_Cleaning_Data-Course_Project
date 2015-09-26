## Loading dplyr package
library("dplyr")

## Reading Data into separate tables called 'test' and 'train'
train <- cbind(read.table("~/train/y_train.txt", sep=""), 
               read.table("~/train/subject_train.txt", sep = ""), 
               read.table("~/train/X_train.txt", sep = ""))

test  <- cbind(read.table("~/test/y_test.txt", sep=""), 
               read.table("~/test/subject_test.txt", sep = ""), 
               read.table("~/test/X_test.txt", sep = ""))

## Creating a variable to extract feature names

names <- read.table("features.txt")

## Making a new Data Frame with Test and Train data combined

Data_Full <- rbind(train, test);

## Assigning column names in the Data Frame

colnames(Data_Full) <- c("Activity","Person", as.character(names[,2]))

## Removing any invalid or repeated variables

Tidy_dataset_one <- Data_Full[ !duplicated(names(Data_Full)) ]

## Selecting out only variables with 'mean' and 'std' in them

Tidy_dataset_one <- select(Tidy_dataset_one, 
                           contains("mean", ignore.case = TRUE),
                           contains("std", ignore.case = TRUE))

## Re-joining the first 2 columns that were removed in the above process

Tidy_dataset_one <- cbind(Data_Full[,1], Data_Full[,2], Tidy_dataset_one)

names(Tidy_dataset_one)[1:2] <- c("Activity", "Person")

## Naming all the variables in Column 1 (Activity) to More Descriptive Variables

activity <- read.table("activity_labels.txt", sep = "")

for (i in 1:dim(Tidy_dataset_one)[1])
{
        k = Tidy_dataset_one[i,1]
        switch(k, 
               '1' ={
                       Tidy_dataset_one[i,1] = as.character(activity[1,2])
               },
               '2'={
                       Tidy_dataset_one[i,1] = as.character(activity[2,2])
               },
               '3'={
                       Tidy_dataset_one[i,1] = as.character(activity[3,2])
               },
               '4'={
                       Tidy_dataset_one[i,1] = as.character(activity[4,2])
               },
               '5'={
                       Tidy_dataset_one[i,1] = as.character(activity[5,2])
               },
               '6'={
                       Tidy_dataset_one[i,1] = as.character(activity[6,2])
               }
        )
}

## Performing Step 4 to rename all the variables to more descriptive forms
## 'Time' and 'Frequency' mean that the particular variables was obtained in
## the respective domain.

s<- names(Tidy_dataset_one)
s<-gsub("Acc","Accelaration",s)
s <-gsub("std","Standard Deviation",s)
s<- gsub("Freq","Frequency",s)
s<- gsub("tBody","Time-Body",s)
s<- gsub("fBody","Frequency-Body",s)
s<- gsub("tGravity","Time-Gravity",s)
s<- gsub("fGravity","Frequency-Gravity",s)

names(Tidy_dataset_one) <- s

## Step 5: Creating an independent data frame to summarize the means of variables

Final_Data <- arrange(Tidy_dataset_one, Person, Activity)

Final_Data <- Final_Data %>% group_by(Person,Activity) %>% summarise_each(funs(mean))



