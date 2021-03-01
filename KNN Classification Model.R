# Installing Packages 
install.packages("e1071") 
install.packages("caTools") 
install.packages("class") 

# Loading package 
library(e1071) 
library(caTools) 
library(class) 

# Loading data 
data<-multiTimeline
head(data) 

#Cleaning the Data
#s <- s[-1] 
any(is.na(data))
sum(is.na(data))
na.omit(data)
summary(data)
s[2]
plot(data$X2, col=c('red','blue','green', 'orange'))
str(data)
dim(data)

# Build your own `normalize()` function
normalize <- function(x) {
  num <- (x - min(x))
  denom <- (max(x) - min(x))
  return (num/denom)
}

#normalize data
data_norm <- as.data.frame(lapply(s[2:2], normalize)) #works
#s[2:2] ignore this, just testing
summary(data_norm)
data_norm
#the normalized data is now in s_norm

# Splitting data into train 
# and test data 
split <- sample.split(data, SplitRatio = 0.7) 
train_cl <- subset(data, split == "TRUE") 
test_cl <- subset(data, split == "FALSE") 

# Feature Scaling 
train_scale <- scale(train_cl[, 2:2]) 
test_scale <- scale(test_cl[, 2:2]) 

# Fitting KNN Model k=1 
# to training dataset 
classifier_knn1 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 1) 
classifier_knn1 
plot(classifier_knn1, col=c('red','green'))

# Confusiin Matrix k=1
cm1 <- table(test_cl$X2, classifier_knn1) 
cm1 
plot(cm1, col=c('red','green'))

# Fitting KNN Model k=3
# to training dataset 
classifier_knn3 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 3) 
classifier_knn3 
plot(classifier_knn3, col=c('yellow','purple'))

# Confusiin Matrix k=3
cm3 <- table(test_cl$X2, classifier_knn3) 
cm3 
plot(cm3, col=c('yellow','purple'))

# Fitting KNN Model k=5
# to training dataset 
classifier_knn5 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 5) 
classifier_knn5 
plot(classifier_knn5, col=c('orange','green'))

# Confusiin Matrix k=5
cm5 <- table(test_cl$X2, classifier_knn5) 
cm5 
plot(cm5, col=c('orange','green'))


# Fitting KNN Model k=7
# to training dataset 
classifier_knn7 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 1) 
classifier_knn7 
plot(classifier_knn7, col=c('red','blue'))

# Confusiin Matrix k=7
cm7 <- table(test_cl$X2, classifier_knn7) 
cm7
plot(cm7, col=c('red','blue'))


# Model Evaluation - Choosing K 
# Calculate out of Sample error 
misClassError <- mean(classifier_knn1 != test_cl$X2) 
print(paste('Accuracy =', 1-misClassError)) 

# K = 3 
classifier_knn3 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 3) 
misClassError <- mean(classifier_knn3 != test_cl$X2) 
print(paste('Accuracy =', 1-misClassError)) 

# K = 5 
classifier_knn5 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 5) 
misClassError <- mean(classifier_knn5 != test_cl$X2) 
print(paste('Accuracy =', 1-misClassError)) 

# K = 7 
classifier_knn7 <- knn(train = train_scale, 
                      test = test_scale, 
                      cl = train_cl$X2, 
                      k = 7) 
misClassError <- mean(classifier_knn7 != test_cl$X2) 
print(paste('Accuracy =', 1-misClassError)) 

#Euclidean and Manhattan Disatnce function
#For k=1
#dist(classifier_knn1 , method = "euclidean")
dist(cm1  , method = "euclidean")
dist(cm1 , method = "manhattan")

#For k=3
dist(cm3  , method = "euclidean")
dist(cm3 , method = "manhattan")

#For k=5
dist(cm5  , method = "euclidean")
dist(cm5 , method = "manhattan")

#For k=7
dist(cm7  , method = "euclidean")
dist(cm7 , method = "manhattan")
