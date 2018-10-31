# **Titanic**
*Predict Survival of Titanic*

## Table of contents

- [Introduction](#introduction)
- [Preparation](#preparation)
- [Prediction](#prediction)
- [Conclusion](#conclusion)


## Introduction
This is my first time using Github and I will be doing a data cleaning and create model to evalate the survival of Titanic.

## Preparation
#### Initial works
```
library(rpart)
library(rpart.plot)
```
```
train <- read.csv('C:/Data Science/Kaggle/train.csv', na.strings = c("", "NA"), stringsAsFactors =T)
test <- read.csv('C:/Data Science/Kaggle/test.csv', na.strings = c("", "NA"), stringsAsFactors = T)
```
#### Binding train and test
Before doing a data clean, I will bind the train and test data.
```
#bind
survived<-train$Survived
train$Survived<-NULL
total<-rbind(train,test)
```
#### Data cleaning
Now I will do a data clean as the data has some missing values. As some of the informations are not useful for the final modeling , I will take it out to produce a better model.
```
#data cleaning
str(total)
summary(total)
```
```
total$PassengerId<-NULL
total$Cabin<-NULL
total$Ticket<-NULL
```
```
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
```
```
 #NA treatment
 age.model<-rpart(Age~.,total)
 rpart.plot(age.model)
 prediction<-predict(age.model,total)
 total$Age[is.na(total$Age)]<-prediction[is.na(total$Age)]
 ```
 ```
 embarked.model<-rpart(Embarked~.,total)
 rpart.plot(embarked.model)
 prediction<-predict(embarked.model,total,type = 'class')
 total$Embarked[is.na(total$Embarked)]<-prediction[is.na(total$Embarked)]
 ```
 ```
 Fare.model<-rpart(Fare~.,total)
 rpart.plot(Fare.model)
 prediction<-predict(Fare.model,total)
 total$Fare[is.na(total$Fare)]<-prediction[is.na(total$Fare)]
 total$title <- title
 ```
 #### Split back to train and test
 As all data has been cleaned all together, I will split back the train and test back to a sperate data.
 ```
 #split
 train<-total[1:nrow(train),]
 test<-total[(nrow(train)+1):nrow(total),]
 train$Survived<-survived
 train$Survived<-as.factor(train$Survived)
 ```
 #### Modeling
 I will now use the train data to make a model to predict the survival for the test data.
 ```
 #modeling
 model<-rpart(Survived~.,train)
 rpart.plot(model)
 ```
 ## Prediction
 By using the model I have made, I will now apply it to the test data.
 
```
 #prediction
 prediction<-predict(model,test,type = 'class')
 
 submit<- data.frame(PassengerId=892:1309,Survived=prediction)
write.csv(submit,'C:/Data Science/Kaggle/submit.csv',row.names = F) 
 ```
 
 ## Conclusion
 This was an analysis of what sort of people were most likely to survive in the titanic and to find the percentage of how accurate the model is to predict the survival of different types of people. According to the model i have made and submitted to kaggle, the model had about 0.80382 percent accuracy of prediction made.

