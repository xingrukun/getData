# GetData
Getting and Cleaning Data

# Dependency
This script depends on the "dplyr" package.
There must be a folder named "UCI HAR Dataset" in the current working directory(getwd()) 
which contains all the files needed to run this script.

# Processing steps
1.Use 'read.table' command to read the data from 'test' folder;
2.Use 'cbind' command to merge the data together;
3.Use 'read.table' command to read the data from 'train' folder;
4.Use 'cbind' command to merge the data together;
5.Use 'rbind' command to merge these two data.frame;
6.Modify the data.frame's column names using 'names' and 'make.names' commands;
7.Change the variable values of 'activity' by 'gsub' command;
8.Create a subset vector which matches the 'mean' and 'std' columns of data.frame;
9.Generate the final dataset using 'group_by', 'summarise_each' commands;
10.Write the tidy data into text file and clean up the working directory.
