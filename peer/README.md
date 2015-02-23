README
========================================
Getting and Cleaning Data

RUN THE ANALYSIS

- 1 Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder "data"
- 2 The folder "data" and the run_analysis.R script are both in the current working directory. setwd(...DIR...)
- 3 Call the command source("run_analysis.R") in RStudio
- 4 At the end you will find two output files in working dir
  - merged_data.txt: it contains a data frame called cleanedData with 10299*68 dimension.
  - data_with_means.txt: it contains a data frame called result with 180*68 dimension.
- 5 Use data <- read.table("data_with_means.txt") command in RStudio to read the file.