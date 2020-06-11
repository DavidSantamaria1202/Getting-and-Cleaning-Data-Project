# Code Book for "Summary activity track" Data frame

### Variables:

  1. subject
  2. activity
  3. operation
  4. measurement
  5. value
  
These are the variables listed in the tidy data frame, each of them posses different values, on this file each variable and their possible values will be explained:

### Subject

There are 30 subjects of study, 21 that provided train data and 9 that provided test data
In this row of the data frame you will encounter only the #ID of the study subject.

Test subjects are:
  2
  4
  9
  10
  12
  13
  18
  20
  24
  
Train subjects are:
  1
  3
  5
  6
  7
  8
 11
 14
 15
 16
 17
 19
 21
 22
 23
 25
 26
 27
 28
 29
 30
 
### Activity

Activity is the column which indicates what action the subject did while the data from the "measurement" column was taken.
There are 6 different activities, each with an index, however in this table only the description is used.

  1. WALKING
  2. WALKING_UPSTAIRS
  3. WALKING_DOWNSTAIRS
  4. SITTING
  5. STANDING
  6. LAYING
  
### Operation

Since only mean and standard deviations were selected we have only two types of operations, those that represent a mean of a measurement or 
a standard deviation of a measurement. Therefore, a column indicating which type of operation is being displayed rather than including this
in the measurement name. The two values the variable can take are:

  - Mean
  - Standard Deviation
  
It is important to mention that each measurement will have both a Mean and a Standard Deviation.

### Measurement

This variable is the description of the measurement, this description specifies, the domain (time or frequency), type (Body or Gravity), 
instrument of measurement (Accelerometer or Gyroscope) and the axis where the measurement was taken (X, Y or Z)

There are 33 different values for this variable:

  - "timeDependentBodyAccelerometerXaxis"
  - "timeDependentBodyAccelerometerYaxis"
  - "timeDependentBodyAccelerometerZaxis"
  - "timeDependentGravityAccelerometerXaxis"
  - "timeDependentGravityAccelerometerYaxis"
  - "timeDependentGravityAccelerometerZaxis"
  - "timeDependentBodyAccelerometerJerkXaxis"
  - "timeDependentBodyAccelerometerJerkYaxis"
  - "timeDependentBodyAccelerometerJerkZaxis"
  - "timeDependentBodyGyroscopeXaxis"
  - "timeDependentBodyGyroscopeYaxis"
  - "timeDependentBodyGyroscopeZaxis"
  - "timeDependentBodyGyroscopeJerkXaxis"
  - "timeDependentBodyGyroscopeJerkYaxis"
  - "timeDependentBodyGyroscopeJerkZaxis"
  - "timeDependentBodyAccelerometerMagnitude"
  - "timeDependentGravityAccelerometerMagnitude"
  - "timeDependentBodyAccelerometerJerkMagnitude"
  - "timeDependentBodyGyroscopeMagnitude"
  - "timeDependentBodyGyroscopeJerkMagnitude"
  - "frequencyDomainBodyAccelerometerXaxis"
  - "frequencyDomainBodyAccelerometerYaxis"
  - "frequencyDomainBodyAccelerometerZaxis"
  - "frequencyDomainBodyAccelerometerJerkXaxis"
  - "frequencyDomainBodyAccelerometerJerkYaxis"
  - "frequencyDomainBodyAccelerometerJerkZaxis"
  - "frequencyDomainBodyGyroscopeXaxis"
  - "frequencyDomainBodyGyroscopeYaxis"
  - "frequencyDomainBodyGyroscopeZaxis"
  - "frequencyDomainBodyAccelerometerMagnitude"
  - "frequencyDomainBodyBodyAccelerometerJerkMagnitude"
  - "frequencyDomainBodyBodyGyroscopeMagnitude"
  - "frequencyDomainBodyBodyGyroscopeJerkMagnitude"
  
### Result

The final column of the data frame is the result, this is only the mean of the measurement, thus we have the mean of the mean measurements
and the mean of the standard deviations of each measurement. Since the data was normalized no transformation for the results was needed. 
