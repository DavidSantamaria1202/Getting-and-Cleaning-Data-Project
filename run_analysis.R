## This script will download/unzip and read the data from the UCI HAR Dataset, specifically
## train and test folders, then it will create two data frames, one for test and other for train
## which will later be merged.
## After this operation only variables with mean or standard deviations are selected.
## With the new data frame, the activity index(number) is replaced by the activity label.
## Then more descriptive names replace the original variable (column) names
## A new tidy data frame is created with the mean for each variable per subject and activity.

## The initial part of the code asks if the zip files has already been downloaded,
## if false then it downloads the file, unzip it and finaly removes the zip file.
## If the zip was already downloaded but wasn't unziped then it will unzip the file.
## The last 
## after the verifications either 3 options will do the same:
##      1) Read features.txt and create a data frame
##      2) Get the file names both in train and test libraries
##      3) Select the files that end with .txt by the grep function
##      4) Create a vector for all the tables that will be read
##      5) Use a loop over the vector of names to read the .txt files
##          5.1) This will read the .txt file
##          5.2) Store the data frame in an element of a list
##          5.3) We end with two lists (train and test) each with three items

# In case neither the zipfile and the unziped folder exist:
if (file.exists("compressedData.zip")== F & file.exists("UCI HAR Dataset")== F) {
  
  ## Download and unzip the file
  
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL,"compressedData.zip",method = "curl", mode = "wb")
  unzip("compressedData.zip")
  file.remove("compressedData.zip")
  
  ## Creates a data frame with the features for the test and train files
  features <- read.csv("./UCI HAR Dataset/features.txt",header=FALSE, sep = " ")
  
  ## Extracts the names found at the test and train folders
  namesTest <- list.files("./UCI HAR Dataset/test")
  namesTrain <- list.files("./UCI HAR Dataset/train")
  
  ## Extracs only the txt files within the folders
  namesTest <- namesTest[grep("txt$",namesTest)]
  namesTrain <- namesTrain[grep("txt$",namesTrain)]
  
  ## Creates a vector of the names of the files but without the .txt
  listTestNames <- gsub(".txt","",namesTest)
  listTrainNames <- gsub(".txt","",namesTrain)
  
  # Creates null lists that will be used to store the data frames for each test and train
  listTest <- list()
  listTrain <- list()
  
  # Loop for reading and storing the tables
  for(i in 1:3){
    listTest[[listTestNames[i]]] <- read.csv(paste("./UCI HAR Dataset/test/",namesTest[i],sep=""),sep = "",header=FALSE,fill = FALSE)
  }
  for(i in 1:3){
    listTrain[[listTrainNames[i]]] <- read.csv(paste("./UCI HAR Dataset/train/",namesTrain[i],sep=""), sep = "",header=FALSE,fill=FALSE)
  }
  # In case the unziped file already exists:
} else if(file.exists("UCI HAR Dataset")== T){
  
  features <- read.csv("./UCI HAR Dataset/features.txt",header=FALSE, sep = " ")
  
  namesTest <- list.files("./UCI HAR Dataset/test")
  namesTrain <- list.files("./UCI HAR Dataset/train")
  
  namesTest <- namesTest[grep("txt$",namesTest)]
  namesTrain <- namesTrain[grep("txt$",namesTrain)]
  
  listTestNames <- gsub(".txt","",namesTest)
  listTrainNames <- gsub(".txt","",namesTrain)
  
  listTest <- list()
  listTrain <- list()
  
  for(i in 1:3){
    listTest[[listTestNames[i]]] <- read.csv(paste("./UCI HAR Dataset/test/",namesTest[i],sep=""),sep= "",header = FALSE,fill = FALSE)
  }
  for(i in 1:3){
    listTrain[[listTrainNames[i]]] <- read.csv(paste("./UCI HAR Dataset/train/",namesTrain[i],sep=""),sep = "",header = FALSE,fill=FALSE)
  }
  # In case the zip file exists but it is not unziped:
} else {
  
  unzip("compressedData.zip")
  file.remove("compressedData.zip")
  
  features <- read.csv("./UCI HAR Dataset/features.txt",header=FALSE, sep = " ")
  
  namesTest <- list.files("./UCI HAR Dataset/test")
  namesTrain <- list.files("./UCI HAR Dataset/train")
  
  namesTest <- namesTest[grep("txt$",namesTest)]
  namesTrain <- namesTrain[grep("txt$",namesTrain)]
  
  listTestNames <- gsub(".txt","",namesTest)
  listTrainNames <- gsub(".txt","",namesTrain)
  
  listTest <- list()
  listTrain <- list()
  
  for(i in 1:3){
    listTest[[listTestNames[i]]] <- read.csv(paste("./UCI HAR Dataset/test/",namesTest[i],sep=""),sep="", header = FALSE,fill=FALSE)
  }
  for(i in 1:3){
    listTrain[[listTrainNames[i]]] <- read.csv(paste("./UCI HAR Dataset/train/",namesTrain[i],sep=""),sep="", header = FALSE,fill=FALSE)
  }
}

#Creates a data frame for train information
dataFrameTrain <- cbind(listTrain[[1]],listTrain[[3]],listTrain[[2]])
names(dataFrameTrain) <- c("subject","activity",features[,2])

#Creates a data frame for Test information
dataFrameTest <- cbind(listTest[[1]],listTest[[3]],listTest[[2]])
names(dataFrameTest) <- c("subject","activity",features[,2])

#Creates a data frame with the complete information of test and train
completeData <- rbind(dataFrameTest,dataFrameTrain)

#Extrats only the columns which contain mean o standard deviations
i<-grep("([Mm][Ee][Aa][Nn][(]|[Ss][Tt][Dd])",x = names(completeData))
completeData<-select(completeData,subject,activity,i)

#Creates a data frame making reference to the activities based on the activity_labels.txt file
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
names(activities) <- c("activity","description")

#Replaces de activity code by its description in the completeData data frame
completeData<-mutate(completeData,activity=join(completeData,activities,by="activity")$description)

#Changes the name of the variables to a more descriptive name

names(completeData)<-gsub("^t","timeDependent",names(completeData)) #Replace the initial t for time dependent
names(completeData)<-gsub("^f","frequencyDomain",names(completeData)) #Replace the initial f for frecuency domain
names(completeData)<-gsub("[(][)]","",names(completeData)) #Replace te "()" after the mean or std, by ""
names(completeData)<-gsub("[-]","",names(completeData)) #Delete all "-"
names(completeData)<-gsub("[Mm][Ee][Aa][Nn]","Mean",names(completeData)) #Replace mean by Mean
names(completeData)<-gsub("[Ss][Tt][Dd]","StandardDeviation",names(completeData)) #Replace std by StandarsDeviation
names(completeData)<-gsub("Acc","Accelerometer",names(completeData)) #Replace Acc by accelerometer
names(completeData)<-gsub("Gyro","Gyroscope",names(completeData)) #Replace Gyro by Gyroscope
names(completeData)<-gsub("[Mm][Aa][Gg]","Magnitude",names(completeData)) #Replace mag by Magnitude
names(completeData)<-gsub("X$","Xaxis",names(completeData)) #Incorporates the word axis after the X
names(completeData)<-gsub("Y$","Yaxis",names(completeData)) #Incorporates the word axis after the Y
names(completeData)<-gsub("Z$","Zaxis",names(completeData)) #Incorporates the word axis after the Z

# Group the actual data frame by subject and activity
completeData <- group_by(completeData,subject,activity)

#Create a new tidy data frame with the mean of each variable per subject and activity
summaryDataFrame <- summarise_all(completeData,.funs = mean)

#In this part of the code the dataset will be converted into tidy by spliting the operations
# some of them were means and other standard deviations, thus a column calles operation is
# added to identify which values are means and which are standard deviations

idNames <- names(summaryDataFrame)[1:2]
meassureNames <- names(summaryDataFrame)[3:68]
summaryDataFrame <- melt(as.data.frame(summaryDataFrame),id=idNames,measure.vars = meassureNames)
operation <- ifelse(grepl("Mean",summaryDataFrame$variable),"Mean","Standard deviation")
summaryDataFrame <- mutate(summaryDataFrame,operation = operation)

summaryDataFrame <- mutate(summaryDataFrame,variable = gsub("Mean","",variable))
summaryDataFrame <- mutate(summaryDataFrame,variable = gsub("StandardDeviation","",variable))
summaryDataFrame <- group_by(summaryDataFrame,subject,activity,operation)
summaryDataFrame <- arrange(summaryDataFrame,operation)

# Rename and rearange the variables (columns)
names(summaryDataFrame) <- c("subject","activity","measurement","value","operation")
summaryDataFrame <-summaryDataFrame[,c(1,2,5,3,4)]

#Give once again the name of the activity for each index
summaryDataFrame<-mutate(summaryDataFrame,activity=join(summaryDataFrame,activities,by="activity")$description)

#Write the table into a new txt 
write.table(summaryDataFrame,file="summary activity track.txt",sep=",")
