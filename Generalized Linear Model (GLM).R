trainingset <- mnist_train
trainingset$label <- as.factor(trainingset$label)

trainingset[,-1] <- (trainingset[,-1]/255)

covar <- var(as.matrix(trainingset[,-1])) 
diag(covar) <- 0

X <- svd(covar)$d 
Y <- svd(covar)$u

var <- .99

for (k in seq(length(X)))
{
  if( (sum(X[1:k])/sum(X)) >= var){break}
}

Y <- Y[,1:k]

ReducedData <- as.matrix(trainingset[,-1]) %*% Y

trainingset <- data.frame(trainingset[,1],ReducedData)
names(trainingset)[1] <- "label"

isEqualZero <- as.numeric(trainingset$label == 0)
isEqualOne <- as.numeric(trainingset$label == 1)
isEqualTwo <- as.numeric(trainingset$label == 2)
isEqualThree <- as.numeric(trainingset$label == 3)
isEqualFour <- as.numeric(trainingset$label == 4)
isEqualFive <- as.numeric(trainingset$label == 5)
isEqualSix <- as.numeric(trainingset$label == 6)
isEqualSeven <- as.numeric(trainingset$label == 7)
isEqualEight <- as.numeric(trainingset$label == 8)
isEqualNine <- as.numeric(trainingset$label == 9)

trainzero <- cbind(isEqualZero, trainingset[,-1])
trainone <- cbind(isEqualOne, trainingset[,-1])
traintwo <- cbind(isEqualTwo, trainingset[,-1])
trainthree <- cbind(isEqualThree, trainingset[,-1])
trainfour <- cbind(isEqualFour, trainingset[,-1])
trainfive <- cbind(isEqualFive, trainingset[,-1])
trainsix <- cbind(isEqualSix, trainingset[,-1])
trainseven <- cbind(isEqualSeven, trainingset[,-1])
traineight <- cbind(isEqualEight, trainingset[,-1])
trainnine <- cbind(isEqualNine, trainingset[,-1])
rm(isEqualZero, isEqualOne, isEqualTwo, isEqualThree, isEqualFour, isEqualFive, isEqualSix, isEqualSeven, isEqualEight, isEqualNine)

#training
model1 <- glm(isEqualOne ~ . , data = trainone, family = "binomial")
model2 <- glm(isEqualTwo ~ . , data = traintwo, family = "binomial")
model3 <- glm(isEqualThree ~ . , data = trainthree, family = "binomial")
model4 <- glm(isEqualFour ~ . , data = trainfour, family = "binomial")
model5 <- glm(isEqualFive ~ . , data = trainfive, family = "binomial")
model6 <- glm(isEqualSix ~ . , data = trainsix, family = "binomial")
model7 <- glm(isEqualSeven ~ . , data = trainseven, family = "binomial")
model8 <- glm(isEqualEight ~ . , data = traineight, family = "binomial")
model9 <- glm(isEqualNine ~ . , data = trainnine, family = "binomial")
model0 <- glm(isEqualZero ~ . , data = trainzero, family = "binomial")

testingset <- mnist_test
testingset <- as.matrix(testingset) %*% Y
testingset <- data.frame(testingset)

predictionProbabilities <- data.frame(predict(model1,testingset),
                                      predict(model2,testingset),
                                      predict(model3,testingset),
                                      predict(model4,testingset),
                                      predict(model5,testingset),
                                      predict(model6,testingset),
                                      predict(model7,testingset),
                                      predict(model8,testingset),
                                      predict(model9,testingset),
                                      predict(model0,testingset))


softmax <- rep(NA, nrow(predictionProbabilities))
for (i in seq(nrow(predictionProbabilities)))
{
  softmax[i] <- which.max(predictionProbabilities[i,])
}
softmax[softmax == 10] <- 0

outputFile <- seq(length(softmax))
toBeWritten <- data.frame(outputFile,softmax)
write.csv(toBeWritten, file = "C:/Users/18563/Documents/excel files/MINST/finalPredictions.csv",row.names = FALSE)
