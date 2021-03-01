import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


from scipy.io import arff
import pandas as pd


#Loading the training dataset
print("Loading training dataset..")
data_training = arff.loadarff('Datasets/FruitFlies/FruitFlies_TRAIN.arff')
print("Training dataset loaded")
data_testing = arff.loadarff('Datasets/FruitFlies/FruitFlies_TEST.arff')
print("Testing dataset loaded")

#Creating a dataframe from the loaded dataset
print("Creating training dataframe..")
df_train = pd.DataFrame(data_training[0])
print("Training dataframe created")

#Creating a dataframe from the loaded dataset
print("Creating training dataframe..")
df_test = pd.DataFrame(data_testing[0])
print("Training dataframe created")

df_train.head()
print(df_train.head())

#The last column i.e. 'target' is a byte string which causes the training to fail as it does not recognize the format, hence using the below line to decode it.
df_train['target'] = df_train['target'].str.decode('utf-8')
df_test['target'] = df_test['target'].str.decode('utf-8') 

#No other data cleaning needed as there is no NA values.

df_train.head()
print(df_train.head())

X_train = df_train.iloc[:, :-1].values
X_test = df_test.iloc[:, :-1].values
y_test = df_test.iloc[:, 5000].values
y_train = df_train.iloc[:, 5000].values

#from sklearn.model_selection import train_test_split
#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.50)

print("Implementation of Random Forest algo for trees = 5")
#Using RandomFrosetClassifier for tree = 5
from sklearn.ensemble import RandomForestClassifier
classifier5 = RandomForestClassifier(n_estimators = 5)
classifier5.fit(X_train, y_train)

print("Implementation of Random Forest algo for trees = 50")
#Using RandomFrosetClassifier for tree = 50
from sklearn.ensemble import RandomForestClassifier
classifier50 = RandomForestClassifier(n_estimators = 50)
classifier50.fit(X_train, y_train)

print("Implementation of Random Forest algo for trees = 500")
#Using RandomFrosetClassifier for tree = 500
from sklearn.ensemble import RandomForestClassifier
classifier500 = RandomForestClassifier(n_estimators = 500)
classifier500.fit(X_train, y_train)


print("Prediction of value for tree = 5")
#Prediction of value for tree = 5
y_pred1 = classifier5.predict(X_test)

from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
result = confusion_matrix(y_test, y_pred1)
print("Confusion Matrix for number of trees equal to 5:")
print(result)
result1 = classification_report(y_test, y_pred1)
print("Classification Report for number of trees equal to 5:",)
print (result1)
result2 = accuracy_score(y_test,y_pred1)
print("Accuracy for number of trees equal to 5:",result2)

print("Prediction of value for tree = 50")
#Prediction of value for tree = 50
y_pred2 = classifier50.predict(X_test)


result = confusion_matrix(y_test, y_pred2)
print("Confusion Matrix for number of trees equal to 50:")
print(result)
result1 = classification_report(y_test, y_pred2)
print("Classification Report for number of trees equal to 50:",)
print (result1)
result2 = accuracy_score(y_test,y_pred2)
print("Accuracy for number of trees equal to 50:",result2)

print("Prediction of value for tree = 500")
#Prediction of value for tree = 500
y_pred3 = classifier500.predict(X_test)


result = confusion_matrix(y_test, y_pred3)
print("Confusion Matrix for number of trees equal to 500:")
print(result)
result1 = classification_report(y_test, y_pred3)
print("Classification Report for number of trees equal to 500:",)
print (result1)
result2 = accuracy_score(y_test,y_pred3)
print("Accuracy for number of trees equal to 500:",result2)

