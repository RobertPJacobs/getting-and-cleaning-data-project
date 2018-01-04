# License:
# ========
# Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
# 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# 
# This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the 
# authors or their institutions for its use or misuse. Any commercial use is prohibited.
# 
# Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

run_analysis <- function () {
        # Set the libraries
        library(RCurl)
        library(plyr)
        
        # 1 - Download the data
        
        # check to see if the '/data' directory exists
        if (!file.exists("./data")) { 
                dir.create("./data")
        }        
        # check to see if the './data/Dataset.zip' file exists which means file was previously downloaded
        if (!file.exists("./data/Dataset.zip")) {
                fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(fileUrl, destfile = "./data/Dataset.zip", method = "libcurl")
        }
        # get the dataset path
        dsPath <- file.path("./data" , "UCI HAR Dataset")
        # check to see if the dataset parth exists which means file was previously unzipped
        if (!file.exists(dsPath)) { 
                # Unzip the downloaded files
                unzip(zipfile="./data/Dataset.zip",exdir="./data")
        }
        ## check the files downloaded
        # filesList <- list.files(dsPath, recursive = TRUE)
        # filesList
        # [1] "activity_labels.txt"                          
        # [2] "features.txt"                                
        # [3] "features_info.txt"                            
        # [4] "README.txt"                                  
        # [5] "test/Inertial Signals/body_acc_x_test.txt"    
        # [6] "test/Inertial Signals/body_acc_y_test.txt"   
        # [7] "test/Inertial Signals/body_acc_z_test.txt"    
        # [8] "test/Inertial Signals/body_gyro_x_test.txt"  
        # [9] "test/Inertial Signals/body_gyro_y_test.txt"   
        # [10] "test/Inertial Signals/body_gyro_z_test.txt"  
        # [11] "test/Inertial Signals/total_acc_x_test.txt"   
        # [12] "test/Inertial Signals/total_acc_y_test.txt"  
        # [13] "test/Inertial Signals/total_acc_z_test.txt"   
        # [14] "test/subject_test.txt"                       
        # [15] "test/X_test.txt"                              
        # [16] "test/y_test.txt"                             
        # [17] "train/Inertial Signals/body_acc_x_train.txt"  
        # [18] "train/Inertial Signals/body_acc_y_train.txt" 
        # [19] "train/Inertial Signals/body_acc_z_train.txt"  
        # [20] "train/Inertial Signals/body_gyro_x_train.txt"
        # [21] "train/Inertial Signals/body_gyro_y_train.txt" 
        # [22] "train/Inertial Signals/body_gyro_z_train.txt"
        # [23] "train/Inertial Signals/total_acc_x_train.txt" 
        # [24] "train/Inertial Signals/total_acc_y_train.txt"
        # [25] "train/Inertial Signals/total_acc_z_train.txt" 
        # [26] "train/subject_train.txt"                     
        # [27] "train/X_train.txt"                            
        # [28] "train/y_train.txt"  
        
        # 2 - Merge the training and the test sets to create one data set.
        # reading training tables
        xTrain <- read.table(file.path(dsPath,"train","X_train.txt"))
        yTrain <- read.table(file.path(dsPath,"train","y_train.txt"))
        subjectTrain <- read.table(file.path(dsPath,"train","subject_train.txt"))

        # read the test tables
        xTest <- read.table(file.path(dsPath,"test","X_test.txt"))
        yTest <- read.table(file.path(dsPath,"test","y_test.txt"))
        subjectTest <- read.table(file.path(dsPath,"test","subject_test.txt"))

        # merge the various tables
        dataX <- rbind(xTrain, xTest)
        dataY <- rbind(yTrain, yTest)
        dataSubject <- rbind(subjectTrain, subjectTest)
        
        #names(dataX)
        # [1] "V1"   "V2"   "V3"   "V4"   "V5"   "V6"   "V7"   "V8"   "V9"   "V10"  "V11"  "V12"  "V13"  "V14"  "V15" 
        # [16] ...
        #names(dataY)
        #[1] "V1"
        #names(dataSubject)
        #[1] "V1"
        
        # 3 - Extract only the measurements on the mean and standard deviation for each measurement.
        
        # read the features
        features <- read.table(file.path(dsPath,"features.txt"))
        # get only columns with 'mean()' or 'std()' in the column names
        subsetCols <- grep("-(mean|std)\\(\\)", features[, 2])
        # subset the data xwith only mean and std columns
        dataX <- dataX[, subsetCols]
        # correct the column names
        names(dataX) <- features[subsetCols, 2]
        
        # check the column names for dataX for 'mean()' and 'std()'
        # names(dataX)
        # [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
        # [4] "tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
        # [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
        # [10] "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
        # [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
        # [16] "tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
        # [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
        # [22] "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
        # [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
        # [28] "tBodyGyroJerk-std()-X"       "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
        # [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"           "tGravityAccMag-mean()"      
        # [34] "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
        # [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"    
        # [40] "tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
        # [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"           
        # [46] "fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
        # [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
        # [52] "fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
        # [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"          
        # [58] "fBodyGyro-std()-Z"           "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
        # [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
        # [64] "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
        
        # 3 - Use descriptive activity names to name the activities in the data set
        
        # read the activity labels
        activityLabels = read.table(file.path(dsPath,"activity_labels.txt"))
        # update values with correct activity names
        dataY[,1] <- activityLabels[dataY[,1],2]
        # correct the column name
        names(dataY) <- "Activity"
        
        # #check  dataY 
        # head(dataY)
        # activity
        # 1 STANDING
        # 2 STANDING
        # 3 STANDING
        # 4 STANDING
        # 5 STANDING
        # 6 STANDING
        
        # 4 - Appropriately labels the data set with descriptive variable names.
        
        # correct the column name
        names(dataSubject) <- "Subject"
        
        # bind all the data in a single data set
        dataAll <- cbind(dataX, dataY, dataSubject)
        
        # clean up the column names
        names(dataAll)<-gsub("^t", "Time", names(dataAll))
        names(dataAll)<-gsub("^f", "Frequency", names(dataAll))
        names(dataAll)<-gsub("Acc", "Accelerometer", names(dataAll))
        names(dataAll)<-gsub("Gyro", "Gyroscope", names(dataAll))
        names(dataAll)<-gsub("Mag", "Magnitude", names(dataAll))
        names(dataAll)<-gsub("BodyBody", "Body", names(dataAll))
        names(dataAll)<-gsub("std\\(\\)", "StandardDev", names(dataAll))
        names(dataAll)<-gsub("mean\\(\\)", "Mean", names(dataAll))
        names(dataAll)<-gsub(" ", "", names(dataAll))
        names(dataAll)<-gsub("-", "", names(dataAll))
        
        # 5 - From the data set in step 4, creates a second, independent tidy data set with the average 
        # of each variable for each activity and each subject.
        
        tidydata <- ddply(dataAll, .(Subject, Activity), function(x) colMeans(x[,1:66]))
        # test to see if columns and data is correct
        # names(tidydata)
        # [1] "Subject"                                            "Activity"                                          
        # [3] "TimeBodyAccelerometerMeanX"                         "TimeBodyAccelerometerMeanY"                        
        # [5] "TimeBodyAccelerometerMeanZ"                         "TimeBodyAccelerometerStandardDevX"                 
        # [7] "TimeBodyAccelerometerStandardDevY"                  "TimeBodyAccelerometerStandardDevZ"                 
        # [9] "TimeGravityAccelerometerMeanX"                      "TimeGravityAccelerometerMeanY"                     
        # [11] "TimeGravityAccelerometerMeanZ"                      "TimeGravityAccelerometerStandardDevX"              
        # [13] "TimeGravityAccelerometerStandardDevY"               "TimeGravityAccelerometerStandardDevZ"              
        # [15] "TimeBodyAccelerometerJerkMeanX"                     "TimeBodyAccelerometerJerkMeanY"                    
        # [17] "TimeBodyAccelerometerJerkMeanZ"                     "TimeBodyAccelerometerJerkStandardDevX"             
        # [19] "TimeBodyAccelerometerJerkStandardDevY"              "TimeBodyAccelerometerJerkStandardDevZ"             
        # [21] "TimeBodyGyroscopeMeanX"                             "TimeBodyGyroscopeMeanY"                            
        # [23] "TimeBodyGyroscopeMeanZ"                             "TimeBodyGyroscopeStandardDevX"                     
        # [25] "TimeBodyGyroscopeStandardDevY"                      "TimeBodyGyroscopeStandardDevZ"                     
        # [27] "TimeBodyGyroscopeJerkMeanX"                         "TimeBodyGyroscopeJerkMeanY"                        
        # [29] "TimeBodyGyroscopeJerkMeanZ"                         "TimeBodyGyroscopeJerkStandardDevX"                 
        # [31] "TimeBodyGyroscopeJerkStandardDevY"                  "TimeBodyGyroscopeJerkStandardDevZ"                 
        # [33] "TimeBodyAccelerometerMagnitudeMean"                 "TimeBodyAccelerometerMagnitudeStandardDev"         
        # [35] "TimeGravityAccelerometerMagnitudeMean"              "TimeGravityAccelerometerMagnitudeStandardDev"      
        # [37] "TimeBodyAccelerometerJerkMagnitudeMean"             "TimeBodyAccelerometerJerkMagnitudeStandardDev"     
        # [39] "TimeBodyGyroscopeMagnitudeMean"                     "TimeBodyGyroscopeMagnitudeStandardDev"             
        # [41] "TimeBodyGyroscopeJerkMagnitudeMean"                 "TimeBodyGyroscopeJerkMagnitudeStandardDev"         
        # [43] "FrequencyBodyAccelerometerMeanX"                    "FrequencyBodyAccelerometerMeanY"                   
        # [45] "FrequencyBodyAccelerometerMeanZ"                    "FrequencyBodyAccelerometerStandardDevX"            
        # [47] "FrequencyBodyAccelerometerStandardDevY"             "FrequencyBodyAccelerometerStandardDevZ"            
        # [49] "FrequencyBodyAccelerometerJerkMeanX"                "FrequencyBodyAccelerometerJerkMeanY"               
        # [51] "FrequencyBodyAccelerometerJerkMeanZ"                "FrequencyBodyAccelerometerJerkStandardDevX"        
        # [53] "FrequencyBodyAccelerometerJerkStandardDevY"         "FrequencyBodyAccelerometerJerkStandardDevZ"        
        # [55] "FrequencyBodyGyroscopeMeanX"                        "FrequencyBodyGyroscopeMeanY"                       
        # [57] "FrequencyBodyGyroscopeMeanZ"                        "FrequencyBodyGyroscopeStandardDevX"                
        # [59] "FrequencyBodyGyroscopeStandardDevY"                 "FrequencyBodyGyroscopeStandardDevZ"                
        # [61] "FrequencyBodyAccelerometerMagnitudeMean"            "FrequencyBodyAccelerometerMagnitudeStandardDev"    
        # [63] "FrequencyBodyAccelerometerJerkMagnitudeMean"        "FrequencyBodyAccelerometerJerkMagnitudeStandardDev"
        # [65] "FrequencyBodyGyroscopeMagnitudeMean"                "FrequencyBodyGyroscopeMagnitudeStandardDev"        
        # [67] "FrequencyBodyGyroscopeJerkMagnitudeMean"            "FrequencyBodyGyroscopeJerkMagnitudeStandardDev"
        
        # head(tidydata,1)
        # Subject Activity TimeBodyAccelerometerMeanX TimeBodyAccelerometerMeanY TimeBodyAccelerometerMeanZ
        # 1       1   LAYING                  0.2215982                -0.04051395                 -0.1132036
        # TimeBodyAccelerometerStandardDevX TimeBodyAccelerometerStandardDevY TimeBodyAccelerometerStandardDevZ
        # 1                        -0.9280565                        -0.8368274                        -0.8260614
        # TimeGravityAccelerometerMeanX TimeGravityAccelerometerMeanY TimeGravityAccelerometerMeanZ
        # 1                    -0.2488818                     0.7055498                     0.4458177
        # TimeGravityAccelerometerStandardDevX TimeGravityAccelerometerStandardDevY TimeGravityAccelerometerStandardDevZ
        # 1                             -0.89683                             -0.90772                           -0.8523663
        # TimeBodyAccelerometerJerkMeanX TimeBodyAccelerometerJerkMeanY TimeBodyAccelerometerJerkMeanZ
        # 1                     0.08108653                    0.003838204                     0.01083424
        # TimeBodyAccelerometerJerkStandardDevX TimeBodyAccelerometerJerkStandardDevY
        # 1                            -0.9584821                            -0.9241493
        # TimeBodyAccelerometerJerkStandardDevZ TimeBodyGyroscopeMeanX TimeBodyGyroscopeMeanY TimeBodyGyroscopeMeanZ
        # 1                            -0.9548551            -0.01655309            -0.06448612              0.1486894
        # TimeBodyGyroscopeStandardDevX TimeBodyGyroscopeStandardDevY TimeBodyGyroscopeStandardDevZ
        # 1                    -0.8735439                    -0.9510904                    -0.9082847
        # TimeBodyGyroscopeJerkMeanX TimeBodyGyroscopeJerkMeanY TimeBodyGyroscopeJerkMeanZ
        # 1                 -0.1072709                -0.04151729                -0.07405012
        # TimeBodyGyroscopeJerkStandardDevX TimeBodyGyroscopeJerkStandardDevY TimeBodyGyroscopeJerkStandardDevZ
        # 1                        -0.9186085                        -0.9679072                        -0.9577902
        # TimeBodyAccelerometerMagnitudeMean TimeBodyAccelerometerMagnitudeStandardDev
        # 1                         -0.8419292                                -0.7951449
        # TimeGravityAccelerometerMagnitudeMean TimeGravityAccelerometerMagnitudeStandardDev
        # 1                            -0.8419292                                   -0.7951449
        # TimeBodyAccelerometerJerkMagnitudeMean TimeBodyAccelerometerJerkMagnitudeStandardDev
        # 1                             -0.9543963                                    -0.9282456
        # TimeBodyGyroscopeMagnitudeMean TimeBodyGyroscopeMagnitudeStandardDev TimeBodyGyroscopeJerkMagnitudeMean
        # 1                     -0.8747595                            -0.8190102                          -0.963461
        # TimeBodyGyroscopeJerkMagnitudeStandardDev FrequencyBodyAccelerometerMeanX FrequencyBodyAccelerometerMeanY
        # 1                                 -0.935841                      -0.9390991                      -0.8670652
        # FrequencyBodyAccelerometerMeanZ FrequencyBodyAccelerometerStandardDevX FrequencyBodyAccelerometerStandardDevY
        # 1                      -0.8826669                             -0.9244374                             -0.8336256
        # FrequencyBodyAccelerometerStandardDevZ FrequencyBodyAccelerometerJerkMeanX FrequencyBodyAccelerometerJerkMeanY
        # 1                             -0.8128916                          -0.9570739                          -0.9224626
        # FrequencyBodyAccelerometerJerkMeanZ FrequencyBodyAccelerometerJerkStandardDevX
        # 1                          -0.9480609                                 -0.9641607
        # FrequencyBodyAccelerometerJerkStandardDevY FrequencyBodyAccelerometerJerkStandardDevZ
        # 1                                 -0.9322179                                  -0.960587
        # FrequencyBodyGyroscopeMeanX FrequencyBodyGyroscopeMeanY FrequencyBodyGyroscopeMeanZ
        # 1                  -0.8502492                  -0.9521915                  -0.9093027
        # FrequencyBodyGyroscopeStandardDevX FrequencyBodyGyroscopeStandardDevY FrequencyBodyGyroscopeStandardDevZ
        # 1                         -0.8822965                          -0.951232                         -0.9165825
        # FrequencyBodyAccelerometerMagnitudeMean FrequencyBodyAccelerometerMagnitudeStandardDev
        # 1                              -0.8617676                                     -0.7983009
        # FrequencyBodyAccelerometerJerkMagnitudeMean FrequencyBodyAccelerometerJerkMagnitudeStandardDev
        # 1                                  -0.9333004                                          -0.921804
        # FrequencyBodyGyroscopeMagnitudeMean FrequencyBodyGyroscopeMagnitudeStandardDev
        # 1                          -0.8621902                                 -0.8243194
        # FrequencyBodyGyroscopeJerkMagnitudeMean FrequencyBodyGyroscopeJerkMagnitudeStandardDev
        # 1                              -0.9423669                                     -0.9326607
        
        write.table(tidydata, "tidydata.txt", row.name = FALSE)
}

# run the program
# source("run_analysis.R")
# run_analysis()

