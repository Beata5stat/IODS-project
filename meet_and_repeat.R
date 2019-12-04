#Data Wrangling, Beata Anton, 3.6.2019

#BPRS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

#Take a look at the data set:
names(BPRS)
dim(BPRS)
str(BPRS)
summary(BPRS)

#Convert the categorical variables of both data sets to factors:
library(dplyr)
library(tidyr)
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
glimpse(BPRS)

#Convert the data sets to long form. Add a week variable to BPRS:
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#Check the variable names, view the data contents and structures, and create some brief summaries of the variables:
glimpse(BPRSL)
names(BPRS)
dim(BPRS)
str(BPRS)
summary(BPRS)

#RATS
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#Take a look at the data set:
names(RATS)
dim(RATS)
str(RATS)
summary(RATS)

#Convert the categorical variables of both data sets to factors:
library(dplyr)
library(tidyr)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
glimpse(RATS)

#Convert the data sets to long form. Add a Time variable to RATS:
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#Check the variable names, view the data contents and structures, and create some brief summaries of the variables:
glimpse(RATSL)
names(RATSL)
dim(RATSL)
str(RATSL)
summary(RATSL)

getwd()
setwd("C:/Users/Omistaja/Documents/IODS-project/data")
getwd()
write.csv(BPRS, file = "~/IODS-project/data/BPRS.csv")
write.csv(BPRSL, file = "~/IODS-project/data/BPRSL.csv")
write.csv(RATS, file = "~/IODS-project/data/RATS.csv")
write.csv(RATSL, file = "~/IODS-project/data/RATSL.csv")

#The wide and the long form of data contain the same infromation, but they differ in the way they represent it.  
#In the examples above, the BPRS data in the wide form has 40 observations and 11 variables, while in the long form, it has 360 observations of 5 variables.   
#The RATS data in the wide form had 16 observations of 13 variables, while in the long form it contains 176 observations of 5 variables. 