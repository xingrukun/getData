#load dplyr package
library(dplyr)

#read the data from 'test' folder
data_y <- read.table("UCI HAR Dataset/test/y_test.txt", header = F)
data_x <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)
data_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = F)

#merge the data together
data_test <- cbind(data_subject, data_y, data_x)

#deal the data within 'train' folder in the same way
data_y <- read.table("UCI HAR Dataset/train/y_train.txt", header = F)
data_x <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)
data_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = F)

data_train <- cbind(data_subject, data_y, data_x)

#merge the 'test' and 'train' data together
data_raw <- rbind(data_test, data_train)

#name the columns of data_raw
title <- read.table("UCI HAR Dataset/features.txt", header = F)
title <- c("subject", "activity", as.vector(as.character(title[, 2])))
names(data_raw) <- make.names(title)

#change the activity names
data_raw$activity <- gsub('1','WALKING',data_raw$activity)
data_raw$activity <- gsub('2','WALKING_UPSTAIRS',data_raw$activity)
data_raw$activity <- gsub('3','WALKING_DOWNSTAIRS',data_raw$activity)
data_raw$activity <- gsub('4','SITTING',data_raw$activity)
data_raw$activity <- gsub('5','STANDING',data_raw$activity)
data_raw$activity <- gsub('6','LAYING',data_raw$activity)

#subset the raw data
subsetter <- sapply(title, FUN = function(t) {
    if(t == "subject" | t == "activity" | 
           (grepl("mean", t)) | (grepl("std", t))) {
        return(TRUE)
    } else {
        return(FALSE)
    }
})

#generate the final dataset
tidyData <- data_raw[, subsetter] %>% 
    group_by(activity, subject) %>% 
    summarise_each(funs(mean))

#write the data set to file
write.table(tidyData, file = "getData_3_cp.txt", row.names = F, col.names = F)

#cleanup the temporary variables
rm(data_y, data_x, data_subject, data_test, data_train, title, subsetter, data_raw)
