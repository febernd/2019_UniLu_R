# #######################
# Data Preparation with R
# #######################

# Demo Code for Course Day 1
# Authors: Dr. Bernd Fellinghauer, Dr. Carolina Fellinghauer
# 2 day workshop at University of Lucerne, 2019/2020

# First steps
1 + 2

1 +
  2

?mean

## vignette("readr")

# Assignments
my_variable = 1 + 2
my_variable <- 1 + 2 # default for "ALT and -" 

# Comments
3 + 4 # this is a comment and not executed

## ##########################
## Working with Excel data
## ##########################
require(readxl)
# list of example data sets
readxl_example()[1:3]
readxl_example()[4:6]
# get the path to the deaths-data set
path_xlsx <- readxl_example("deaths.xlsx")

## "/path/to/file.xlsx"

## "C:/path/to/file.xlsx" # or
## "C:\\\\path\\\\to\\\\file.xlsx"

# Example paths
data_folder <- "/Users/fellingh/.../readxl/extdata/"
file_deaths <- "deaths.xlsx"
full_path <- paste0(data_folder,file_deaths)
full_path

excel_sheets(path_xlsx)

d <- read_excel(path=path_xlsx, 
                sheet = "arts", 
                range = cell_rows(5:11), 
                na=c("8888","9999"))

# Interactive Data View
View(d)

# Char Vector
treatment <- c("Old", "New", "New", "Placebo")

# Numeric Vector
days_since_injury <- c(1, 2, 1, 3)

# Logical Vector
complications <- c(TRUE, FALSE, FALSE, FALSE)

# Select a Variable from a data frame
d$Age
d[1:3, "Age"] # tibble - this does not return a vector!
as.data.frame(d)[1:3, "Age"]

# unordered factors
(v_factor_unord <- factor(c("B", "A", "C"), 
                          levels = c("A","B","C")))

## v_factor_unord[4] <- "C"
## v_factor_unord[5] <- "D"

# ordered factors
(v_factor_ord <- factor(c("L", "H", "M"), 
                        ordered = TRUE, 
                        levels = c("L","M","H")))

str(v_factor_unord)
str(v_factor_ord)

# define a factor of numbers
v_factor_num <- factor(c("4","3","8"),
                        levels=c("3", "4", "8"))

# how NOT to transform a factor of numbers back to numeric vector
as.numeric(v_factor_num)

# correct way to transform a factor of numbers back to numeric vector
as.numeric(as.character(v_factor_num)) # true values

## ###########################
## sequences and repetitions
## ###########################
3:6
-5:-8

seq(from=1, to=5, by=2)

seq(from=1, to=4, length.out=7)

rep(5, times = 4)
 
rep(c(2,3,4), times=2)

rep(c(2,3,4), length.out=7)

rep(c(2,3,4), each=2)


# Solutions
c("A", "B", "C", "D")

seq(-1, -4, -1)

rep(c(6,7,8), each = 3)

# calculating descriptive statistics
set.seed(123) # reproducible random number generation
v_norm <- rnorm(100000) # sample 100'000 vars

# Solution
mean(v_norm)
min(v_norm)
max(v_norm)
round(quantile(v_norm),2)
quantile(v_norm, probs = c(0.975))

## ##############
## Strings
## ##############
length(d$Name) # same as nrow(d), dim(d)

nchar(d$Name)

substring(d$Name, 1, 5)

paste("path_to_file/","file_name.txt", sep = "")

tolower(d$Name)
toupper(d$Name)

"Chuck Berry" %in% d$Name

which("Chuck Berry" == d$Name)

# the stringr package
require(stringr)
first_name <- word(d$Name, 1)
last_name <- word(d$Name, 2)

# partial match
which(str_detect(d$Name, "Berry")) # or grep in base R

## ####################
## selecting elements
## ####################
d[1:3, 1:3]

d[, c("Name", "Profession", "Age")]

subset(d, Age > 60)

# Be sure to load dplyr
require(dplyr)
# This will make the dplyr::filter call the default
dplyr::filter(d, Age > 60)
filter(d, Age > 60) # same result
# stats::filter(d, Age > 60) # gives an error - this is a different function
# Also note: ?filter shows references to the 
#               two versions of the filter-function

d$has_kids <- d$`Has kids`

subset(d, has_kids == TRUE)
filter(d, Profession == "musician")
subset(d, has_kids == TRUE
           & Profession == "musician"
                           & Age > 70)

filter(d, Profession != "musician")

subset(d, !(
               has_kids == TRUE
               & Profession == "musician"
                               & Age > 70)
             )


## #############
## Dates
## #############
course_day1 <- as.Date("2019-12-02")

course_day2 <- as.Date("13.01.2020", "%d.%m.%Y")

course_day2 - course_day1

year_day2 <- format(course_day2, "%Y")
year_month_day2 <- format(course_day2, "%Y-%m")

Sys.Date()

as.POSIXct(Sys.time())
as.POSIXlt(Sys.time())

## ########################
## Read (CSV) Data into R
## ########################

# replace the location by the path on your computer
# make sure the path ends with a / or a \\
path_to_data <- "/Users/fellingh/OneDrive/Firma/kurse/R/2019_11_Data_Preparation_and_Analysis_with_R/data/"

path_UTF8 <- paste0(path_to_data,
  "Students_Swiss_Universities_2018_2019_UFT8.csv")

path_LATIN1 <- paste0(path_to_data,
  "Students_Swiss_Universities_2018_2019_LATIN1.csv")

# Try each command - due to encoding issues this may fail
d2_utf8 <- read.csv(path_UTF8)
d2_latin1 <- read.csv(path_LATIN1)


## #########################################
## Read data from other statistics packages
## #########################################
path_sas <- paste0(path_to_data, "sas_example.sas7bdat")

require(haven) 
## # you can try this with sas_example.sas7bdat
d_sas <- read_sas(data_file = path_sas)

# install.packages("foreign")
require(foreign)
path_spss <- system.file("files",
                         "electric.sav", package = "foreign")
d_spss <- read.spss(file=path_spss)


## #######################
## Read / Assess WHO data 
## #######################
d_who <- readRDS(paste0(path_to_data, "who.rds"))

# Solution
dim(d_who) #nrow(d_who) ncol(d_who)
colnames(d_who)[1:4]
colnames(d_who)[5:7]
str(d_who)

summary(d_who)
View(d_who)

head(d_who) # first 6 rows
tail(d_who, n = 10) # last 10 rows

hist(d_who$year)

## Assign Types
as.numeric(c("2", "3"))

str(d_who)

## ###############
## Transform Data 
## ###############

# Solution
colnames(d_who)[5] <- "tb_severity"
colnames(d_who)[7] <- "tb_cnt"

table(d_who$age)

round(100 * table(d_who$age)/length(d_who$age), 2)
# same result, but using R's prop.table function
round(100 * prop.table(table(d_who$age)), 2)

## ifelse(vector, if_true_then, if_false_then)

## Recode variables
d_who$age_grp <- 
       ifelse(d_who$age == "014", "0 - 14",
       ifelse(d_who$age == "1524", "15 - 24",
       ifelse(d_who$age == "2534", "25 - 34",
       ifelse(d_who$age == "3544", "35 - 44",
       ifelse(d_who$age == "4554", "45 - 54",
       ifelse(d_who$age == "5564", "55 - 64",
       ifelse(d_who$age == "65", "65 and older",
       NA # else
       )))))))

## require(dplyr)
## recode(vector, a = "new_name_for_a",
##                b = "new_name_for_b")

d_who$age_grp2 <- recode(d_who$age, 
                    `014` = "0 - 14",
                    `1524` = "15 - 24",
                    `2534` = "25 - 34",
                    `3544` = "35 - 44",
                    `4554` = "45 - 54",
                    `5564` = "55 - 64",
                    `65` = "65 and older"
                  )

table(d_who$age_grp == d_who$age_grp2, useNA ="ifany")

# collapse levels
d_who$age_grp3 <- recode(d_who$age,
                     `014` = "0 - 14",
                     `1524` = "15 - 44",
                     `2534` = "15 - 44",
                     `3544` = "15 - 44",
                     `4554` = "45 and older",
                     `5564` = "45 and older",
                     `65` = "45 and older"
                   )

table(d_who$age_grp3)


# selecting records with differences
d_who$age_grp2[17]
d_who$age_grp2[17] <- "65 and older" 

which(d_who$age_grp != d_who$age_grp2)

d_who[d_who$age_grp != d_who$age_grp2,
                  c("age_grp","age_grp2")]


## #############
## Joining Data 
## #############
d_continents <- readRDS(paste0(path_to_data,
"country_continent.rds"))

head(d_continents[c("Continent_Name",
            "Three_Letter_Country_Code")])

## merge(x=data1, y=data2,
##       by.x=vec_of_cols, by.y=vec_of_cols)

# join - has duplicates
d_who2 <- merge(d_who, d_continents, 
                by.x = "iso3", 
                by.y = "Three_Letter_Country_Code")

nrow(d_who)
nrow(d_who2)

# de-duplication of continents
(iso3_freq <- 
   table(d_continents$Three_Letter_Country_Code))

iso3_freq_1 <- iso3_freq[iso3_freq == 1]

unique_iso3_codes <- names(iso3_freq_1)

d_continents2 <- d_continents[
  d_continents$Three_Letter_Country_Code 
                %in% unique_iso3_codes,]

nrow(d_continents)
nrow(d_continents2)

# join - lacks records
d_who3 <- merge(d_who, d_continents2, 
                by.x = "iso3", 
                by.y = "Three_Letter_Country_Code")

nrow(d_who)
nrow(d_who3)

# join - equal record counts
d_who4 <- merge(d_who, d_continents2, 
                by.x = "iso3", 
                by.y = "Three_Letter_Country_Code", 
                all.x = TRUE)

nrow(d_who) == nrow(d_who4)

## #######################
## Handling Mising Values 
## #######################
# my_data$my_var[my_data$my_var %in% c(8888,9999)] <- NA

table(d_who4$Continent_Name, useNA = "ifany")

## R cannot compare NA values using ==
sum(d_who4$Continent_Name == NA)

## Use is.na() instead
sum(is.na(d_who4$Continent_Name))

## my_data[is.na(my_data$my_var)] <- "did not answer"


## ###############
## Aggregate Data 
## ###############

## ##########
## functions 
## ##########
# sum of tb cases in Switzerland
sum(d_who[d_who$country=="Switzerland", "tb_cnt"])

# nbr of countries
length(unique(d_who4$country))

## function_name <- function(argument1 = value1,
##                           argument2 = value2)
## {
##   ... code_to_execute ...
## }

# function to count tb cases for a country
tb_cnt_country <- function(country) {
    sum(d_who4[d_who4$country==country, "tb_cnt"])
}

# use the function to count tb cases in Switzerland
tb_cnt_country(country = "Switzerland")

# Solution
# adjusted function to count tb cases for a continent
tb_cnt_continent <- function(Continent_Name) {
    sum(d_who4[d_who4$Continent_Name == Continent_Name, 
                        "tb_cnt"], na.rm = TRUE)
}

# apply continent function
tb_cnt_continent("Europe")
tb_cnt_continent("Africa")


## ##########
## loops 
## ##########

## for (i in some_vector) {
##   ... execute code...
## }

for (i in 1:5)
     {print(i)}

# set of countries to loop through
v_countries <- sort(unique(d_who4$country))

# empty results vector
res <- vector()

## apply the country function to each country
for (i in v_countries) {
  res[i] <- tb_cnt_country(i)
}

# get results from results vector
head(res, 3)
tail(res, 3)
res["Switzerland"]

## ######################################
## Outlook: More Aggreagation Approaches 
## ######################################

# aggregate function
res_aggr <- aggregate(d_who$tb_cnt, 
                      by = list(Country = d_who$country),
                      FUN = sum)


res_aggr[res_aggr$Country == "Switzerland",]


# tapply function. 
# Note: there are many apply functions for different data structures
res_tapply <- tapply(d_who$tb_cnt, 
                     d_who$country, FUN=sum)

res_tapply["Switzerland"]

# dplyr package
require(dplyr)

# count for Switzerland only
d_who %>% 
  filter(country=="Switzerland") %>%
  summarize(tb_cnt_CH = sum(tb_cnt))

# count for all countries
res_dplyr <- d_who %>%
  group_by(country) %>%
  summarize(Frequency = sum(tb_cnt))


res_dplyr[res_dplyr$country == "Switzerland", ]

