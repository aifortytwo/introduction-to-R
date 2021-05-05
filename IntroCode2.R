# Introduction to R 2.0
# Sine Zambach, 2021

# Data frames ----

# Dataframes versus matrix
df <- data.frame(matrix(c(1,3,5,2,"hello","world"), ncol = 3))
str(df)

df <- data.frame(c(1,3),c(5,2),c("hello","world"))
names(df) <- c("X1","X2","X3")
str(df)

## more ways to access same element of a dataframe
df[2,1]
df$X1[2]
df[2,"X1"]


# Use library to unpack the package "readxl"
library(readxl)


# Find path using the "Import Dataset" from 
# "Environment" (normally upper right corner)

who_disease <- read.csv("who_disease.csv") # CSV-file
BOO <- read_excel("BagsOfOranges_Fact.xlsx")

# inspect - recap
View(who_disease) # in this pane

nrow(who_disease) # in the console
str(who_disease)
summary(who_disease)

length(unique(who_disease$disease))

## Wrangle ------
library(tidyverse)


# Joining/merging 

who_disease$country <- as.character(who_disease$country)

BOO <- left_join(BOO, unique(who_disease[,c("country","region")]), by=c("origin" = "country"))
View(BOO)

left_join(BOO, unique(who_disease[,c("country","region")]), by=c("origin" = "country")) %>% View()


# counting instances in dataset
count(BOO, origin)

# mutate
BOO <- mutate(BOO, new_price=3+prize)

# group_by You can now create

group_by(BOO, origin) %>%
  summarise(m = mean(prize), nm = mean(new_price))




## Plotting ------
library(ggplot2)

ggplot(who_disease, aes(region, cases)) +
  geom_col(aes(fill=disease)) +
  facet_wrap(vars(year))

ggplot(who_disease, aes(region, cases)) +
  geom_col(aes(fill=disease),position="fill") +
  facet_wrap(vars(year))
 

ggplot(BOO, aes(foodLabel, prize)) +
  geom_point(aes(color=origin))+
  geom_jitter()



## Stat-tests ----

# t-tests used to compare
# t-tests Example 1:
x = rnorm(10)
y = rnorm(10)
t.test(x,y) # to vectors with numeric values 

# t-tests Example 2:
t.test(BOO$prize ~ BOO$foodLabel)



# fishers-tests
TeaTasting <- matrix(c(3, 1, 1, 3), 
                     nrow = 2, 
                     dimnames = list(Guess = c("Milk", "Tea"), 
                                     Truth = c("Milk", "Tea"))) 

fisher.test(TeaTasting, alternative = "greater") 

## Modelling and the pipe ----

lm(prize ~ origin + foodLabel, data=BOO) %>% summary()
# hmm weird?

lm(prize ~ ., data=BOO) %>% summary()
# now it makes sense

lm(prize ~ .-bagNo, data=BOO) %>% summary()
# better sense
