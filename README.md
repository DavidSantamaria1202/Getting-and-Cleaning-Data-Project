# Getting-and-Cleaning-Data-Project
This repository contains the script, README and code book for the Getting and Cleaning Data Project

Content of this repository:

   1. README file explaining the R script and explaining why the last table created is tidy.
   2. There is only one script on this repository, this accomplishes the tasks of downloading, reading, selecting and rearranging the 
      data from the original .zip file
   3. Codebook for the tidy data frame created, describing the variables and its possible values.
   4. A tidy data which summarizes the fata obtained from the train and test experimental results.

In this README file I will explain the process made to achieve the task requested by the project, this task was to create a new tidy data set which had the mean of all variables (Those that had the mean or standard deviation of a measure) per activity (for example: WALKING) and per subject (there are a total of 30 subjects in the study).

The R script code is divided in two main sections

   1. Retrieving the data
   2. Manipulating the data

The first one goes from line 1 until 108, the second one from 109 to 176

beginning with retrieving the data:

first a conditional was added in order to be able to recognize if the file has already been downloaded, here 3 cases are present:
    1. The zip file and de unzipped file are not present in the working directory.
    2. The unzipped file is already present in the working directory.
    3. the unzipped file is not present but the zip file does.

The main difference between the expressions within the 3 cases is that the first one downloads and unzips the file, the third case unzips the file and the second case does only the standard procedure.
The standard procedure is the same for the three cases, here the data is read and saved in a list.

The steps of the standard procedure are the following:

   1. Extract the name of the files within the folders test and train
   2. Extract only the files that are .txt within the folders test and train, with help of grep function in the namesTest and         
      namesTrain variables.
   3. Extracts the name of the files but without the .txt, this to use those names as the names of the list elements that will be    
      created.
   4. Create a null list that will contain the tables read from the .txt files
   5. in a for loop the .txt files are read and saved in a element in the list with the same name of the file but without the ".txt"
    
This procedure is the same for the three if cases, after this we will have two lists one with test data (lisTest) and other with train data (listTrain). Then we go to the second part of the code, where data will be cleaned and arranged.

The second part of the code is in charge of cleaning, merging and arranging the data sets, the steps followed are:

  1. Create a dataframe for the train data (dataFrameTrain) using the cbind function by merging the three elements of the listTrain 
     list.
  2. Use the features data frame to extract the names of the variables and add them to the dataFrameTrain table.
  3. Create a dataframe for the test data (dataFrameTest) using the cbind function by merging the three elements of the listTest list.
  4. Use the features data frame to extract the names of the variables and add them to the dataFrameTest table.
  5. With the help of rbind merge both test and train dataframes into only one called: completeData
  6. Search for the columns that contain either the word mean or std, this with the grep() function which will throw the column indexes 
     that have this data. This are saved in variable i.
  7. Using the i variable and the select function, modify completeData to have ONLY those columns which have a mean or a standard 
     deviation of the data.
  8. Read the activity_labels.txt and save the data table into activities variable.
  9. Give the names for the activities data table, "activity" and "description". Activity is a series of numbers identifying an 
     exercise and description is the word name for each index.
 10. Replace the activity indexes by the word description of the activity.
 11. use gsub replace the name of the variables for them to be more descriptive
        - names beginning with t the t is replaced by timeDependent
        - names beginning with f the f is replaced by frequencyDomain
        - parenthesis are deleted
        - minus "-" signs are removed
        - mean and std are replace by Mean and StandardDeviation respectively
        - Acc, Gyro and Mag are replaced my Accelerometer, Gyroscope and Magnitude respectively
        - the word axis is added to the end of each variable ending with X,Y or Z
      This makes the variables self explanatory, since they will specify their dependence, the instrument of medition, the axis of the 
      measure and  whether it is a mean or a standard deviation.  
 12. Group completeData dataframe by subject and activity. this to be able to summarise by subject and by activity.
 13. Summarise the data by taking the mean of each column per subject and per activity and save it in variable summaryDataFrame.
 
Now in order to make the data tidy it is important to note that there are only two main measurements in the table, means and standard deviations. One of the bases of tidy data is that there is only one variable per column, in this case we have variables in each column and some of them are means while others standard deviations. The variables subject and activity are already each in one column so they are tidy. The proposed tidy data set consists of 5 columns, the first for the subject, the second for the activity, the third for operation (mean or standard deviation), fourth for the name of the measurement and finally the result. This way we will have only one variable per column and we will be able to arrange the data by subject, activity and operation, having one half for mean and the other half for standard deviation information.

in order to create this new data frame the following steps were done:
  1. variable names "subject" and "activity" are stored in idNames
  2. variable names of the vector of names from the summaryDataFrame from 3 to 68 are stored in meassureNames
  3. summaryDataFrame is melt with melt() function with id = idNames and measure. vars = meassureNames
         - It is important to remember to enter summaryDataFrame as a dataframe since melt function has trouble with dyplr package.
         - Now the data frame has all the measured variables in only one column
  4. Create a vector called operation where each position takes the value of "Mean" or "standard deviation" depending on the content of 
     the name of the measure. Ex: timeDependentBodyAccelerometerMeanXaxis will throw "Mean" in the operation vector.
  5. The vector with the operations is added to the data frame summaryDataFrame.
  6. Erase the word Mean and Standard deviation from the measurement name.
  7. Group the summaryDataFrame by subject,activity and operation.
  8. Arrange the summaryDataFrame by operation (first half mean and second half standard deviations)
  9. Assign the description of the activity to the activity index since making summaryDataFrama as dataframe will lose the operation of 
     assignin the name to the index of activity that we did earlier.
  10. Write a table with the new data frame
  
In order to write the table, please use: read.table("summary activity track.txt",sep=",")
