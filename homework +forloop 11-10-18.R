train <- read.csv('C:/Data Science/Kaggle/train.csv', na.strings = c("", "NA"), stringsAsFactors =T)
test <- read.csv('C:/Data Science/Kaggle/test.csv', na.strings = c("", "NA"), stringsAsFactors = T)
library(rpart)
library(rpart.plot)

#bind
survived<-train$Survived
train$Survived<-NULL
total<-rbind(train,test)

#data cleaning
str(total)
summary(total)

total$PassengerId<-NULL
total$Cabin<-NULL
total$Ticket<-NULL

total$Name<- as.character(total$Name)
split<-strsplit(total$Name," ")

total$Title<-NA
total$Title[1]<-split[[1]][2]

for (i in 2:nrow(total)) {total$Title[i]<-split[[i]][2]
  
}


total$Name<-NULL
total$Title <- as.factor(total$Title)
title <- total$Title
total$Title <- NULL
 #NA treatment


 age.model<-rpart(Age~.,total)
 rpart.plot(age.model)
 prediction<-predict(age.model,total)
 total$Age[is.na(total$Age)]<-prediction[is.na(total$Age)]
 
 embarked.model<-rpart(Embarked~.,total)
 rpart.plot(embarked.model)
 prediction<-predict(embarked.model,total,type = 'class')
 total$Embarked[is.na(total$Embarked)]<-prediction[is.na(total$Embarked)]
 
 Fare.model<-rpart(Fare~.,total)
 rpart.plot(Fare.model)
 prediction<-predict(Fare.model,total)
 total$Fare[is.na(total$Fare)]<-prediction[is.na(total$Fare)]
 total$title <- title
 
 #split
 train<-total[1:nrow(train),]
 test<-total[(nrow(train)+1):nrow(total),]
 train$Survived<-survived
 train$Survived<-as.factor(train$Survived)
 
 #modeling
 model<-rpart(Survived~.,train)
 rpart.plot(model)
 
 #prediction
 prediction<-predict(model,test,type = 'class')
 
submit<- data.frame(PassengerId=892:1309,Survived=prediction)
write.csv(submit,'C:/Data Science/Kaggle/submit.csv',row.names = F) 
