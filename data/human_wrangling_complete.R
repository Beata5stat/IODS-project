#Data wrangling, Beata Anton, 20.11.2019 & 27.11.2019

#Read the data into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Look at the structure & dimensions, create the summary
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

#Rename the variables with shorter descriptive names
colnames(hd) 
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life.exp"
colnames(hd)[5] <- "Edu.exp"
colnames(hd)[6] <- "Edu.mean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI.Minus.Rank"
colnames(gii)
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "Mat.Mor"
colnames(gii)[5] <- "Ado.Birth"
colnames(gii)[6] <- "Parli.F"
colnames(gii)[7] <- "Edu2.F"
colnames(gii)[8] <- "Edu2.M"
colnames(gii)[9] <- "Labo.F"
colnames(gii)[10] <- "Labo.M"

colnames(hd)
colnames(gii)

#Mutate the “Gender inequality” data and create two new variables: the ratio of Female and Male populations with secondary education in each country (see: edu2F_edu2M_ratio), and the ratio of labour force participation of females and males in each country (see: laboF_laboM_ratio). 

library(dplyr)
gii = mutate(gii, edu2F_edu2M_ratio=Edu2.F/Edu2.M)
head(gii)

library(dplyr)
gii = mutate(gii, laboF_laboM_ratio=Labo.F/Labo.M)
head(gii)

#join together the two datasets, using the varable Country as identifier. 
library(dplyr)
join_by <- c("Country")
hd_gii <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))
colnames(hd_gii)
glimpse(hd_gii)

#The joined data have 195 observations and 19 variables
dim(hd_gii)

#Call the new joined data "human" and save it in your data folder. - There were some problems during the workshop, so with one of the tutors we created "human2" while trying to find the solution to the complications. 

human <- hd_gii
dim(human)
head(human)
write.csv(human, file= "human2.csv")
human2 <- human 
getwd()
human2 <-read.csv("human2.csv", header = T)
str(human2)


#27.11.2019
human2 <- read.csv("~/IODS-project/data/human2.csv")
str(human2)
dim(human2)
head(human2)

#Description: the data was collected by the UN to measure Human Development Index (HDI) around the world. The variables refer to, among others, life expectancy, education, gender inequality, etc.

#Mutate the data: transform the Gross National Income (GNI) variable to numeric

library(stringr)
str(human2$GNI)
str_replace(human2$GNI, pattern=",", replace ="") %>% as.numeric

#Exclude unneeded variables & Remove all rows with missing values (1 point).
keep <- c("Country", "edu2F_edu2M_ratio", "laboF_laboM_ratio", "Life.exp", "Edu.exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human2 <- select(human2, one_of(keep))
complete.cases(human2)
data.frame(human2[-1], comp = complete.cases(human2))
human2_ <- filter(human2, complete.cases(human2))

#Remove the observations which relate to regions instead of countries. (1 point)

tail(human2_, 10)
last <- nrow(human2_) - 7
human2_ <- human2_[1:last, ]

#Define the row names of the data by the country names
rownames(human2_) <- human2_$Country

#and remove the country name column from the data.
human2_ <- select(human2_, -Country)

#The data should now have 155 observations and 8 variables.
dim(human2_)
#[1] 155   8 - correct!

#Save the human data in your data folder (1 point).
human <- human2_


