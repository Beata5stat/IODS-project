# Beata Anton, 18.11.2019
# Data wrangling - student performance.
# Source: Paulo Cortez, University of Minho, Portugal

url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"

# web address for math class data
url_math <- paste(url, "student-mat.csv", sep = "/")

# print out the address
url_math

# read the math class questionaire data into memory
math <- read.table(url_math, sep = ";" , header=TRUE)

# web address for portuguese class data
url_por <- paste(url, "student-por.csv", sep ="/")

# print out the address
url_por

# read the portuguese class questionaire data into memory
por <- read.table(url_por, sep = ";", header = TRUE)

# look at the column names of both data
colnames(math)
colnames(por)
#expoloring the dimentions and structure of the data:

str(math)
dim(math)

str(por)
dim(por)

# Data includes 649 observations of 33 variables (for por), and 396 observations of 33 variables (for math)

