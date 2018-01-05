# Code book for the Coursera *Getting and Cleaning Data* course project

## Output Data

The output data file 'tidydata.txt' is a space-separated text file.

The first row contains the names of the variables, which are listed and described in the Indentifiers and Variables sections

## Average of measurements

All measurements are floating-point values, normalised and bounded within [-1,1].

Prior to normalisation, acceleration measurements were made in g's (9.81 m.s⁻²) and gyroscope measurements  were made in radians per second (rad.s⁻¹).

Magnitudes of three-dimensional signals (variables containing Magnitude) were calculated using the Euclidean norm.

The measurements are classified in two domains:

    Time-domain signals (variables prefixed by 'Time'), resulting from the capture of accelerometer and gyroscope raw signals.

    Frequency-domain signals (variables prefixed by 'Frequency'), resulting from the application of a Fast Fourier Transform (FFT) to some of the time-domain signals.


## Identifiers

Each row contains 2 identifiers:

   * Subject - Subject identifier, integer, ranges from 1 to 30.

   * Activity - Activity identifier, string with 6 possible values:
     * WALKING   
     * WALKING_UPSTAIRS   
     * WALKING_DOWNSTAIRS   
     * SITTING   
     * STANDING   
     * LAYING
   
        
## Variables

In addition to the identifies each row containss 66 averaged signal measurements:

* Average time-domain body acceleration X, Y and Z directions:
  * TimeBodyAccelerometerMeanX
  * TimeBodyAccelerometerMeanY
  * TimeBodyAccelerometerMeanZ
* Standard deviation of the time-domain body acceleration X, Y and Z directions:
  * TimeBodyAccelerometerStandardDev
  * TimeBodyAccelerometerStandardDevY
  * TimeBodyAccelerometerStandardDevZ
* Average time-domain gravity acceleration X, Y and Z directions:
  * TimeGravityAccelerometerMeanX
  * TimeGravityAccelerometerMeanY
  * TimeGravityAccelerometerMeanZ
* Standard deviation of the time-domain gravity acceleration X, Y and Z directions:
  * TimeGravityAccelerometerStandardDevX
  * TimeGravityAccelerometerStandardDevY
  * TimeGravityAccelerometerStandardDevZ
* Average time-domain body acceleration jerk (derivation of the acceleration in time) X, Y and Z directions:
  * TimeBodyAccelerometerJerkMeanX
  * TimeBodyAccelerometerJerkMeanY
  * TimeBodyAccelerometerJerkMeanZ
* Standard deviation of the time-domain body acceleration jerk (derivation of the acceleration in time) X, Y and Z directions:
  * TimeBodyAccelerometerJerkStandardDevX
  * TimeBodyAccelerometerJerkStandardDevY
  * TimeBodyAccelerometerJerkStandardDevZ
* Average time-domain body angular velocity X, Y and Z directions:
  * TimeBodyGyroscopeMeanX
  * TimeBodyGyroscopeMeanY
  * TimeBodyGyroscopeMeanZ
* Standard deviation of the time-domain body angular velocity X, Y and Z directions:
  * TimeBodyGyroscopeStandardDevX
  * TimeBodyGyroscopeStandardDevY
  * TimeBodyGyroscopeStandardDevZ
* Average time-domain body angular velocity jerk (derivation of the angular velocity in time) X, Y and Z directions:
  * TimeBodyGyroscopeJerkMeanX
  * TimeBodyGyroscopeJerkMeanY
  * TimeBodyGyroscopeJerkMeanZ
* Standard deviation of the time-domain body angular velocity jerk (derivation of the angular velocity in time) X, Y and Z directions:
  * TimeBodyGyroscopeJerkStandardDevX
  * TimeBodyGyroscopeJerkStandardDevY
  * TimeBodyGyroscopeJerkStandardDevZ
* Average and standard deviation of the time-domain magnitude of body acceleration:
  * TimeBodyAccelerometerMagnitudeMean
  * TimeBodyAccelerometerMagnitudeStandardDev
* Average and standard deviation of the time-domain magnitude of gravity acceleration:
  * TimeGravityAccelerometerMagnitudeMean
  * TimeGravityAccelerometerMagnitudeStandardDev
* Average and standard deviation of the time-domain magnitude of body acceleration jerk (derivation of the acceleration in time):
  * TimeBodyAccelerometerJerkMagnitudeMean
  * TimeBodyAccelerometerJerkMagnitudeStandardDev
* Average and standard deviation of the time-domain magnitude of body angular velocity:
  * TimeBodyGyroscopeMagnitudeMean
  * TimeBodyGyroscopeMagnitudeStandardDev
* Average and standard deviation of the time-domain magnitude of body angular velocity jerk (derivation of the angular velocity in time):
  * TimeBodyGyroscopeJerkMagnitudeMean
  * TimeBodyGyroscopeJerkMagnitudeStandardDev
* Average frequency-domain body acceleration X, Y and Z directions:
  * FrequencyBodyAccelerometerMeanX
  * FrequencyBodyAccelerometerMeanY
  * FrequencyBodyAccelerometerMeanZ
* Standard deviation of the frequency-domain body acceleration X, Y and Z directions:
  * FrequencyBodyAccelerometerStandardDevX
  * FrequencyBodyAccelerometerStandardDevY
  * FrequencyBodyAccelerometerStandardDevZ
* Average frequency-domain body acceleration jerk (derivation of the acceleration in time) X, Y and Z directions:
  * FrequencyBodyAccelerometerJerkMeanX
  * FrequencyBodyAccelerometerJerkMeanY
  * FrequencyBodyAccelerometerJerkMeanZ
* Weighted average of the frequency components of the frequency-domain body acceleration jerk (derivation of the acceleration in time) X, Y and Z directions:
  * FrequencyBodyAccelerometerJerkStandardDevX
  * FrequencyBodyAccelerometerJerkStandardDevY
  * FrequencyBodyAccelerometerJerkStandardDevZ
* Average frequency-domain body angular velocity X, Y and Z directions:
  * FrequencyBodyGyroscopeMeanX
  * FrequencyBodyGyroscopeMeanY
  * FrequencyBodyGyroscopeMeanZ
* Standard deviation of the frequency-domain body angular velocity X, Y and Z directions:
  * FrequencyBodyGyroscopeStandardDevX
  * FrequencyBodyGyroscopeStandardDevY
  * FrequencyBodyGyroscopeStandardDevZ
* Average and standard deviation of the frequency components of the frequency-domain magnitude of body acceleration:
  * FrequencyBodyAccelerometerMagnitudeMean
  * FrequencyBodyAccelerometerMagnitudeStandardDev
* Average and standard deviation of the frequency components of the frequency-domain magnitude of body acceleration jerk (derivation of the acceleration in time):
  * FrequencyBodyAccelerometerJerkMagnitudeMean
  * FrequencyBodyAccelerometerJerkMagnitudeStandardDev  
* Average and standard deviation of the frequency components of the frequency-domain magnitude of body angular velocity:
  * FrequencyBodyGyroscopeMagnitudeMean
  * FrequencyBodyGyroscopeMagnitudeStandardDev
* Average and standard deviation of the frequency components of the frequency-domain magnitude of body angular velocity jerk (derivation of the angular velocity in time):
  * FrequencyBodyGyroscopeJerkMagnitudeMean
  * FrequencyBodyGyroscopeJerkMagnitudeStandardDev

## Transformations 

The zip file of source data can be found at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Transformations done:

1. The data was downloaded, unzipped and loaded into individual data tables. 
1. The training and the test sets were merged to create one data set.
1. Only the measurements on the mean and standard deviations for each measurement was extracted and other data was discarded.
1. The Activity column in the data set was expanded to list actual activities.
1. Each column in the data set was labeled the with descriptive variable names.
1. A tidy data file was created and saved set with the average of each variable was created for each activity and each subject.

The transformations listed were implemented by the `run_analysis.R` R script.
