#Installing all read librabries and Packages
install.packages("factoextra")
install.packages("NbClust")
install.packages("MASS")
install.packages("party")
install.packages("partykit")
library(factoextra)
library(NbClust)
library(MASS)
library(party)

#Used for making decision tree
library(partykit)
library(ggplot2)

#Prepare Data
data<- readingSkills
str(data)
data_frame <- readingSkills[c(2:4)]
data_frame



#Partition of Test and Training Datasets

set.seed(1234)
pd<- sample(2,nrow(data),replace = TRUE,prob = c(0.8,0.2))
train<- data[pd==1,]
test <- data[pd==2,]

#Decicion Tree with party package
trees<- ctree(nativeSpeaker ~ age+shoeSize+score,data =train,control = ctree_control(mincriterion = 0.9,minsplit = 50 ))
plot(trees,main = "Decision Tree")
install.packages("rpart.plot")
library(rpart.plot)
trees1<- rpart(nativeSpeaker ~ age+shoeSize+score,data =train)
rpart.plot(trees1,extra = 2,main = "Decision Tree")

#Prediction
pred1 <- predict(trees,newdata = train)
table(pred1,train$nativeSpeaker)

pred <- predict(trees,newdata = test)
table(pred,test$nativeSpeaker)

#Clustering
clust<- scale(data.frame(data[c(2,4)]))
no_of_cluster<- kmeans(clust,2)
fviz_cluster(no_of_cluster,data = data_frame)
clust_dist<- get_dist(clust)
fviz_dist(clust_dist,gradient = list(low="#00AFBB",mid="white",high="#FC4E07"))


#Density Clustering
install.packages("fpc")
library(fpc)
#Remove IDs
z<- data_frame[-3]

#DBScan Clustering
Db_scan<- dbscan(z,eps=0.20,MinPts = 8)

#Compare Clusters with original nativeSpeakers IDs
table(Db_scan$cluster,readingSkills$nativeSpeaker)
plot(z,Db_scan$cluster,main= "Density Plot")



