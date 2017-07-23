# Peer review assignment
# Coursera: Week 4, Module: Getting and cleaning data
# Irwin Cassells (please don't stalk lol)

# Clear global environment
rm(list = ls())

# Remove all warning messages
options(warn=-1)

# Install neccessary packages if they are not avaliable
if(!require(dplyr)) install.packages("dplyr")
if(!require(plyr)) install.packages("plyr")
if(!require(tidyr)) install.packages("tidyr")


# Set working directory but first install the neccesary package to make the useful code run
if(!require(rstudioapi)) install.packages("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))                 # No reason to import the rstudio api, it magically just works

# Import all the packages needed or use just because it is comfortably there when you do need them (especiialy dplyr and tidyr)
require("dplyr")
require("plyr")
require("tidyr") 


# Source functions and files to write read me and markdown files (I just prefer to do this from R; please don't mark me down for it)
source("readme.R")              # Just for the read me file - please don't penalise me for this
source("markdown.R")            # I know you can use the makrdown feature but i prefer writing my own script and then outputting to [userfile].md

# For me to know how long the programme ran for
start_time = Sys.time()

# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #
# -------------------------------------------------------------- Stage 0: Read Me and Markdown Docs ---------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #
readMe() ; markDownFile()


# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #
# -------------------------------------------------------------- Stage 1: Import Data ------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #

# Read all data into R (need a bit of memory to do that; I prefer data frames)

    # List of activity labels as per file
    activityLabels = as.data.frame(read.table("activity_labels.txt"))
    
    # List of train data as per file
    trainX = as.data.frame(read.table("train/X_train.txt"))
    trainY = as.data.frame(read.table("train/y_train.txt"))
    trainSub = as.data.frame(read.table("train/subject_train.txt"))
    
    # List of test data as per file
    testX = as.data.frame(read.table("test/X_test.txt"))
    testY = as.data.frame(read.table("test/y_test.txt"))
    testSub = as.data.frame(read.table("test/subject_test.txt"))
    
    # Pull in what each of the columns mean
    features = as.data.frame(read.table("features.txt"))
    
    
    # Side note
    # -
    # X is the values for each feature
    # Y is the value for each activity
    # Sub is the value for each user in the study
    # I prefer using "=" instead of "<-" - it isn't wrong, just makes a little more sense to me

# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #
# -------------------------------------------------------------- Stage 2: Reduce Data Size ------------------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #

#  Determine which columns are for means and standard deviations (note: I am final all)

    # List of indices/names where mean are found
    meanListIndex = grep("[mM]ean",features$V2)
    meanListNames = grep("[mM]ean",features$V2,value = T)
    
    # List of indices/names where std are found
    stdListIndex = grep("std",features$V2)
    stdListNames = grep("std",features$V2,value = T)
    
# Make the column names a little more prettier
    meanListNames = gsub("mean|Mean|\\(|\\)|-|Body|,","",meanListNames)
    meanListNames = gsub("angle|anglet|anglef","Angular",meanListNames)
    meanListNames = gsub("Acc","Acceleration",meanListNames)
    meanListNames = gsub("Gyro","Gyroscope",meanListNames)
    meanListNames = gsub("Freq","Frequency",meanListNames)
    meanListNames = gsub("gravity","Gravity",meanListNames)
    meanListNames = paste0(meanListNames,"Mean")
    
    stdListNames = gsub("std|Std|\\(|\\)|-|Body|,","",stdListNames)
    stdListNames = gsub("angle|anglet|anglef","Angular",stdListNames)
    stdListNames = gsub("Acc","Acceleration",stdListNames)
    stdListNames = gsub("Gyro","Gyroscope",stdListNames)
    stdListNames = gsub("Freq","Frequency",stdListNames)
    stdListNames = gsub("gravity","Gravity",stdListNames)
    stdListNames = paste0(stdListNames,"STD")
    
# Collect only the list of mean and std data and remove the big list 
    
    # Test set of data
    meanTestX = testX[,meanListIndex] ; colnames(meanTestX) = meanListNames
    stdTestX = testX[,stdListIndex] ; colnames(stdTestX) = stdListNames
    
    # Train set of data
    meanTrainX = trainX[,meanListIndex] ; colnames(meanTrainX) = meanListNames
    stdTrainX = trainX[,stdListIndex] ; colnames(stdTrainX) = stdListNames
    
    # Remove big sets and clear some memory
    rm(testX,trainX,features)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #
# -------------------------------------------------------------- Stage 3: Merge Sets ------------------------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #

# Redefine set of activities
    activityLabels$V2 = c("Walking","WalkingUpstairs","WalkingDownstairs","SittingDown","StandingUp","LayingDown")
    
# Assign the activity to number (merge sorts the data even with sort = F, so I used join to keep the row elements the same)
    testY = join(testY,activityLabels)
    trainY = join(trainY,activityLabels)
    
# Conbined mean and std sets
    fullTestSet = cbind(meanTestX,stdTestX)
    fullTrainSet = cbind(meanTrainX,stdTrainX)
    
# Set activities to each set
    fullTestSet = cbind(testY$V2,fullTestSet); colnames(fullTestSet)[1] = "Activity" 
    fullTrainSet = cbind(trainY$V2,fullTrainSet); colnames(fullTrainSet)[1] = "Activity"
    
# Assign username
    fullTestSet = cbind(testSub$V1,fullTestSet); colnames(fullTestSet)[1] = "Subject" 
    fullTrainSet = cbind(trainSub$V1,fullTrainSet); colnames(fullTrainSet)[1] = "Subject"
    
# Combind to finally get the full data set
    fullDataSet = rbind(fullTestSet,fullTrainSet)
    
# Remove sets you will not need anymore
    rm(testSub,testY,trainY,trainSub,fullTestSet,fullTrainSet,activityLabels,meanTestX,meanTrainX,stdTestX,stdTrainX)
    rm(meanListIndex,meanListNames,stdListIndex,stdListNames)
    
# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #
# -------------------------------------------------------------- Stage 4: Second Data Set -------------------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------------------------------------------ #

# Using the summarise function, create the second data set
    secondDataSet = fullDataSet %>% group_by(Subject,Activity) %>% summarise_all(mean) 
    
# Output files to csv
    write.csv(fullDataSet,"fullDataSet.csv",row.names = F)
    write.csv(secondDataSet,"secondDataSet.csv",row.names = F)
 
# End time of programme
end_time = Sys.time()

# Print run time to console (ancient method, well aware)
print(paste("Data cleaning time (seconds)", round(difftime(end_time,start_time,units="secs"),2), sep = ": "))

# Remove all files at the end of the programme
rm(list = ls())