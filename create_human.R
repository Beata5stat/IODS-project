#Data wrangling, Beata Anton, 20.11.2019

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

#Call the new joined data "human" and save it in your data folder
human <- hd_gii
dim(human)
write.csv(human, file= "~/IODS-project/data/human.csv")
