install.packages("forecast")
install.packages("tseries")
install.packages("lmtest")
library(lmtest)
library(forecast)
library(tseries)

#1 Identifying time series data set
data("austres")
class(austres)
start(austres)
end(austres)
frequency(austres)
sum (is.na(austres)) #to check missing values
summary(austres)
plot(austres, col="red", main="Austres vs Time Graph")
cycle(austres)

#explorartory data analysis or boxplots we  can identify trend/ seasonability
boxplot(austres~cycle(austres),col= heat.colors(5), main="Boxplot")
#boxplot(austres~cycle(austres),col= rainbow(4, start = 0.7, end = 0.9))
View(austres)

#1bc decomposing = breaking it in trend seasonaloity random
tsdata<-ts(austres,frequency = 12)
ddata<-decompose(tsdata, "multiplicative")
plot(ddata,col= "red")

#ddata= Decomposed data
#1st- actual data, 2-trend, 3- seasonal 4 irregularity

#B.1 The Durbin Watson (DW) statistic is a test for autocorrelation in the residuals from a statistical regression analysis. The Durbin-Watson statistic will always have a value between 0 and 4. ... Values from 0 to less than 2 indicate positive autocorrelation and values from from 2 to 4 indicate negative autocorrelation.
#data must have constant variance and mean ie stationary before statring TSA
#fit the model with ARIMA

#dwtest(formula, order.by = NULL, alternative = c("greater", "two.sided", "less"),iterations = 15, exact = NULL, tol = 1e-10, data = list())

library(lmtest)
data("cars")
plot(cars, col= "blue") 
summary(cars)
x<-(cars$speed)
y<-(cars$dist)
dwtest(y~x)

#B.2 ARIMA
mymodel<-auto.arima(austres)
mymodel

#lets run with trace to confirm information criteria
auto.arima(austres,ic="aic",trace = TRUE)
plot.ts(mymodel$residuals, col= "blue", main = "Arima model graphical representation: Residuals vs Time")

#ACF and PACF, for future 10yrs prediction
acf(ts(mymodel$residuals),main='ACF Residual')
pacf(ts(mymodel$residuals), main='PACF Residual')
#95% confidence interval, h=forecast horizon period in months
#forecast for 10yrs
myforecast<-forecast(mymodel, level = c(95),h=10*12)
plot(myforecast)
#to validate findings in ARIMA, we use Ljhung-Box test
Box.test(mymodel$resid, lag=5, type="Ljung-Box")
Box.test(mymodel$resid, lag=10, type="Ljung-Box")
Box.test(mymodel$resid, lag=15, type="Ljung-Box")
#p-values are fairly low, means our model is accurate
# conclusion, ARIMA output, parameters(2,1,1) has shown to adequately fit the data

