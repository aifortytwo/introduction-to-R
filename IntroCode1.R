# Very introductionary Introduction to R
# Sine Zambach, 2021

# Part 1
# Syntax and calculations

# atomic variable
x <- 3
# vector
v <- c(3,5,7,9)
# dataframe
df <- data.frame(matrix(c(1,3,5,2,"hello","world"), ncol = 3))


# to get data out of the variables again
x         # print value of x
print(x)  # print value of x
v[1]      # first element of vector

# more ways to access same element of a dataframe
df[2,1]
df$X1[2]
df[2,"X1"]

# change datatype

# Changing data type
v <- as.character(v) # typically text
v <- as.factor(v) # good for (non-ordered) categories
# and back 
v <- as.numeric(as.character(v))# from factor-type, you need this workaround

str(df)
df$X2 <- as.numeric(df$X2) # really numeric, so we change
str(df)

# Calculations

y <- x*2 # you can multiply an atomic variable with e.g. 2
v2 <- as.numeric(v)*2 # you can multyply a vector with e.g. 2

x^2 # Reads x-squared
x^3 # Reads x-cubed
sqrt(x^3) # reads square root of x cubed
log(10)   # natural logarithm (ln)
log10(10) # log ten 

v+x # okay - adds 3 to each element of vector v
df$X3 + x # bad idea 
df$X2 + x # okay (same data type, numeric)


# Functions

# t-tests
x = rnorm(10)
y = rnorm(10)
t.test(x,y)

# Playing around with t-tests
x = rnorm(10)+5
y = rnorm(10)
t.test(x,y, alternative = "less") #using extra argument 
t.test(x,y, alternative = "greater")
t.test(x,y)   # what do we see with P-value?


## More on dataframes
# consider to Create new project in an existing folder where your r-stuff 
# and data files are

# Our old friend
df <- data.frame(matrix(c(1,3,5,2,"hello","world"),ncol = 3))
df$X1 <- as.numeric(as.character(df$X1))
df$X2 <- as.numeric(df$X2)

# Inspect
nrow(df) # check number of rows
View(df) # look at data in an tabular format
str(df)  # check out datatypes
summary(df) # check average, quantile information, etc for numeric 


# Use library to unpack the package "readxl"
library(readxl)

# New friends 
# Find path using the "Import Dataset" from 
# "Environment" (normally upper right corner)
who_disease <- read.csv("who_disease.csv") # CSV-file
BOO <- read_excel("BagsOfOranges_Fact.xlsx")

# inspect 
nrow(who_disease)
View(who_disease)
str(who_disease)
summary(who_disease)
max(who_disease[,"cases"]) # can you find it in the summary?
max(who_disease$cases) # equal to the one above

length(unique(who_disease$disease))
