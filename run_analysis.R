library(dplyr)
library(reshape2)


#load test data
read.table("../UCI HAR Dataset/test/X_test.txt")->testdata
read.table("../UCI HAR Dataset/test/subject_test.txt")->testsubject
read.table("../UCI HAR Dataset/test/y_test.txt")->testy

#load train data
read.table("../UCI HAR Dataset/train/X_train.txt")->traindata
read.table("../UCI HAR Dataset/train/subject_train.txt")->trainsubject
read.table("../UCI HAR Dataset/train/y_train.txt")->trainy

#load names
read.table("../UCI HAR Dataset/features.txt")->featurenames
read.table("../UCI HAR Dataset/activity_labels.txt")->activities

#clean up feature names
featurenames%>%mutate(V2=tolower(gsub("[[:punct:]]","",V2)))->featurenames

#set column names
names(activities)<-c("activityid","activityname")
names(featurenames)<-c("varpos","varname")
names(testdata)<-featurenames$varname
names(traindata)<-featurenames$varname
names(testy)<-c("activityid")
names(trainy)<-c("activityid")
names(testsubject)<-c("subjectid")
names(trainsubject)<-c("subjectid")

#add columns from other files
cbind(testdata,testsubject,testy)->testdata
cbind(traindata,trainsubject,trainy)->traindata

#union both data sets together and join to the activity names so we have it all in one
bind_rows(traindata,testdata)%>%inner_join(activities)->alldata

#fix the class, because it is not really an integer
alldata$subjectid<-factor(alldata$subjectid)

#keeper columns
grep("std.$|mean.$|std$|mean$",names(alldata),value=TRUE)->kcols
select (alldata,subjectid,activityname,kcols)->outdata

write.csv(outdata,"../outdata.csv",row.names=FALSE)

#calculate a mean for each column
outdata%>%group_by(subjectid,activityname)%>%melt%>%
  dcast(formula=...~variable,mean)->sumdata

write.csv(sumdata,"../sumdata.csv",row.names = FALSE)

write.table(sumdata,"../sumdata.txt",row.names = FALSE)

