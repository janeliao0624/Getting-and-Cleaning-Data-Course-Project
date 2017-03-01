## Getting-and-Cleaning-Data-Course-Project

# Introductions

This project contains one R script, run_analysis.R, which will calculate means per activity, per subject of the mean and Standard deviation of the Human Activity Recognition Using Smartphones Dataset Version 1.0 [1]. This dataset should be downloaded and extracted directly into the data directory.

Once executed, the resulting dataset maybe found at ./data/tidy_data.txt

For futher details, refer to CodeBook.md

# References

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


# Required R Packages

The R package reshape2 is required to run this script. This maybe installed with,

install.packages("reshape2")
