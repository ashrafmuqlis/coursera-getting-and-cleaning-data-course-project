
#Merges the training and the test sets to create one data set.
setwd("~/UCI HAR Dataset/test/Inertial Signals/") #Reading all files in test/Inertial Signals
          Test.bodyaccx<-read.table("body_acc_x_test.txt")
          Test.bodyaccy<-read.table("body_acc_y_test.txt")
          Test.bodyaccz<-read.table("body_acc_z_test.txt")
          Test.bodygyrox<-read.table("body_gyro_x_test.txt")
          Test.bodygyroy<-read.table("body_gyro_y_test.txt")
          Test.bodygyroz<-read.table("body_gyro_z_test.txt")
          Test.totalaccx<-read.table("total_acc_x_test.txt")
          Test.totalaccy<-read.table("total_acc_y_test.txt")
          Test.totalaccz<-read.table("total_acc_z_test.txt")
setwd("~/UCI HAR Dataset/test/") #Reading all files in test/ 
          Test.subject<-read.table("subject_test.txt")
          Test.x<-read.table("X_test.txt")
          Test.y<-read.table("y_test.txt")
setwd("~/UCI HAR Dataset/train/Inertial Signals/") #Reading all files in train/Inertial Signals
          Train.bodyaccx<-read.table("body_acc_x_train.txt")
          Train.bodyaccy<-read.table("body_acc_y_train.txt")
          Train.bodyaccz<-read.table("body_acc_z_train.txt")
          Train.bodygyrox<-read.table("body_gyro_x_train.txt")
          Train.bodygyroy<-read.table("body_gyro_y_train.txt")
          Train.bodygyroz<-read.table("body_gyro_z_train.txt")
          Train.totalaccx<-read.table("total_acc_x_train.txt")
          Train.totalaccy<-read.table("total_acc_y_train.txt")
          Train.totalaccz<-read.table("total_acc_z_train.txt")
setwd("~/UCI HAR Dataset/train/") #Reading all files in train/ 
          Train.subject<-read.table("subject_train.txt")
          Train.x<-read.table("X_train.txt")
          Train.y<-read.table("y_train.txt")

#Merging Train and Test datasets          
Subject<-rbind(Train.subject,Test.subject)          
Y<-rbind(Train.y,Test.y)
X<-rbind(Train.x,Test.x)
BodyAccX<-rbind(Train.bodyaccx,Test.bodyaccx)
BodyAccY<-rbind(Train.bodyaccy,Test.bodyaccy)          
BodyAccZ<-rbind(Train.bodyaccz,Test.bodyaccz)                    
BodyGyroX<-rbind(Train.bodygyrox,Test.bodygyrox)
BodyGyroy<-rbind(Train.bodygyroy,Test.bodygyroy)
BodyGyroz<-rbind(Train.bodygyroz,Test.bodygyroz)
TotalAccX<-rbind(Train.totalaccx,Test.totalaccx)
TotalAccy<-rbind(Train.totalaccy,Test.totalaccy)
TotalAccz<-rbind(Train.totalaccz,Test.totalaccz)
#read features and activity labels
setwd("~/UCI HAR Dataset/")
     ActivityLabel<-read.table("activity_labels.txt")
     Features<-read.table("features.txt")
     Features<-Features[,2] #remove V1 column
#set values in Features as headers for X 
     Features<-as.character(Features) #change the class of Features from factor to character
     names(X)<-Features  #append values of Features as headers in X
#merging Activity Label with Y
     Activity<-merge(Y,ActivityLabel)
     names(Activity)<-c("ActCode","ActDesc")
#merging X and Activity Columns
     X<-cbind(X,Activity)
#merging X and Subject Columns     
     names(Subject)<-"Subject"
     X<-cbind(X,Subject)
     X[,grep("std",colnames(X))] #Extract only the measurement on the std deviations
     X[,grep("mean",colnames(X))] #Extract only the measurement on the means
     #create a tidy data txt file
     write.table(X,"tidy.txt",row.names = F)
     #create a second tidy data for number 5
     tidy2<-aggregate(X,by=list(X$Subject,X$ActDesc),mean)
     write.table(tidy2,"tidy2.txt",row.names = F)
     