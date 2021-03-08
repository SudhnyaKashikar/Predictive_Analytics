#A. Package 'MASS' which provides a description of the datasets available in the MASS package 
#Then, complete the following analysis of the identified data from the library. 
#Part A
install.packages('MASS')
library(MASS)


#B. One-sample t-test: 
#Use the "chem" dataset to answer the question, "is the flour production company producing whole meal flour with greater than 1 part per million copper in it?" 
#Part B
data(chem)
summary(chem)
One_sample<- t.test(chem,mu=1, alternative = "greater",conf.level=0.95)
One_sample

#C. Two-sample t-test: 
#Use the "cats" dataset to answer the question, "do male and female cat samples have the same body weight?" 
#Part C
data(cats)
summary(cats)

female <-subset(cats, Sex=="F")
female

male <- subset(cats,Sex=="M")
male

Two_sample<- t.test(male$Bwt, female$Bwt, alternative="two.sided")
Two_sample


#D. Paired t-test: 
#Use the "shoes" dataset to answer the question, "did material A wear better than material B?" 
#Part D
data(shoes)
summary(shoes)
paired<- t.test(shoes$A,shoes$B,paired = TRUE, alternative = "greater")
paired


#E. Test of equal or given proportions: 
#Use the "bacteria" data set to answer the question, "did the drug treatment have a significant effect of the presence of the bacteria compared with the placebo?"
#Part E
data("bacteria")
summary(bacteria)
bac<- table(bacteria$y,bacteria$ap)
bac
prop.test(bac,correct = FALSE, alternative = "two.sided", conf.level= 0.95)


#F. F-test: 
#Use the "cats" data set to test for the variance of the body weight in male and female cats. 
#Part F
data(cats)
summary(cats)
female<- subset(cats, Sex == "F")
female
male<- subset(cats, Sex == "M")
male
f_test= var.test(female$Bwt,male$Bwt)
f_test
