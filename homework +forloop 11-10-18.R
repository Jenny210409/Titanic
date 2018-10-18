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

name-null. same onwards- submit
