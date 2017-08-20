# Nasir Uddin
# Play with dplyr 
# filter – It filters the data based on a condition
# select – It is used to select columns of interest from a data set
# arrange – It is used to arrange data set values on ascending or descending order
# mutate – It is used to create new variables from existing variables
# summarise (with group_by) – It is used to perform analysis by commonly used operations such as min, max, mean count etc
# 
# install packages
install.packages("dplyr","datasets")

library("dplyr")
data("mtcars")
data("iris")
mydata <-mtcars
# read data
head(mtcars)
# create a local dataframe
mynewdata <- tbl_df(mydata)
myirisdata <- tbl_df(iris)
mynewdata
myirisdata
# filter data with required condition
filter(mynewdata, cyl >4 & gear >4)
filter(mynewdata, cyl >4)
filter(myirisdata, Species %in% c('setosa', 'virginia'))
## use select to pick columns by name
select(mynewdata, cyl,mpg,hp)

# (-) for hid column
select(mynewdata, -cyl)

# chaining or pipelining - multiple operation in one line
mynewdata %>% 
        select(cyl,wt, gear)%>%
        filter(wt >2)
# reorder rows using arrage
mynewdata%>%
        select(cyl,wt,gear)%>%
        arrange(wt)
mynewdata%>%
        select(cyl, wt, gear)%>%
        arrange(desc(wt))
        
# mutate
mynewdata %>%
        select(mpg,cyl)%>%
        mutate(newvariable = mpg*cyl)
## summarise
myirisdata%>%
        group_by(Species)%>%
        summarise(Average = mean(Sepal.Length, na.rm = TRUE))
## summarise each
myirisdata %>%
        group_by(Species)%>%
        summarise_each(funs(mean, n()), Sepal.Length, Sepal.Width)
# rename the variable
mynewdata %>%
        rename(miles = mpg)

############################## Data.table package###############################

# load data
#airquality
data("airquality")
mydata <- airquality
head(airquality)
#iris
data("iris")
myiris <- iris
# install package
install.packages("data.table")
#load package
library(data.table)
mydata
myiris <-data.table(myiris)
myiris
#subset rows: select 2nd to 4th row
mydata[2:4,]
# select column with particular value
myiris[Species== "setosa"]
# select column with multiple values
myiris[Species %in% c('setosa', 'virginica')]
#select column. Return a vector
mydata <- data.table(mydata)
mydata[,Temp]
mydata[, .(Temp,Month)]

# Return sum of selected column
mydata[,sum(Ozone, na.rm = TRUE)]
# return sum and standard deviation
mydata[,.(sum(Ozone, na.rm = TRUE), sd(Ozone, na.rm = TRUE))]
# print and plot
myiris[,{print(Sepal.Length)
plot(Sepal.Width)
NULL}]

#grouping by a variable
myiris[,.(sepalsum = sum(Sepal.Length)), by=Species]

# #select a column for computation, hence need to set the key on column
setkey(myiris,Species)
# select all the rows associated with this data point
myiris['setosa']
myiris[c('setosa', 'virginia')]

############ggplot2##################
install.packages("ggplot2")
library(ggplot2)
install.packages("gridExtra")
library(gridExtra)

df <- ToothGrowth
df$dose <- as.factor(df$dose)
head(df)
# boxplot
bp <- ggplot(df, aes(x = dose, y = len, color = dose)) + geom_boxplot() + theme(legend.position = 'none')
bp
sp <- ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl)))+geom_point(size = 2.5)
# scatter plot
sp <- ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl)))+geom_point(size = 2.5)
sp
#barplot
bp <- ggplot(diamonds, aes(clarity, fill = cut)) + geom_bar() +theme(axis.text.x = element_text(angle = 70, vjust = 0.5))
bp
#compare two plots
plot_grid(sp,bp, labels=c('A','B'), ncol=2, nrow=1)
# histogram
ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 0.25, fill = 'steelblue')+scale_x_continuous(breaks=seq(0,3, by=0.5))

#########reshape2#######3
#create a data
ID <- c(1,2,3,4,5)
Names <- c('Joseph','Matrin','Joseph','James','Matrin')
DateofBirth <- c(1993,1992,1993,1994,1992)
Subject<- c('Maths','Biology','Science','Psycology','Physics')
thisdata <- data.frame(ID, Names, DateofBirth, Subject)
data.table(thisdata)
install.packages('reshape2')
library(reshape2)
#melt 
 mt <- melt(thisdata, id=(c('ID','Names')))
 mt
#########readR#######
install.packages("readr")
library(readr)
 
 read_csv('test.csv',col_names = TRUE)
 read_csv("iris.csv", col_types = list(
         Sepal.Length = col_double(),
         Sepal.Width = col_double(),
         Petal.Length = col_double(),
         Petal.Width = col_double(),
         Species = col_factor(c("setosa", "versicolor", "virginica"))
 ))
 ############### tidyr ##################
 
 # gather() – it ‘gathers’ multiple columns. Then, it converts them into key:value pairs. This function will transform wide from of data to long form. You can use it as in alternative to ‘melt’ in reshape package.
 # spread() – It does reverse of gather. It takes a key:value pair and converts it into separate columns.
 # separate() – It splits a column into multiple columns.
 # unite() – It does reverse of separate. It unites multiple columns into single column
 # 
 