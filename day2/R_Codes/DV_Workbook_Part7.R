
####################################
# Table one

library(tableone)

# Checking the scale level of the variables
Fac=c("sex", "getting_out","energy", "relating", "stress", "anxiety")
Num=c("age", "health")

for(i in 1:length(Fac)){Smpl_who[,Fac[i]]=as.factor(Smpl_who[,Fac[i]])}
for(i in 1:length(Num)){Smpl_who[,Num[i]]=as.numeric(Smpl_who[,Num[i]])}


# Variables to describe
vars=c("age", "health", "anxiety", "getting_out", "energy", "relating")

# Set the stratification variable here, for example a description per gender group
strata=c("sex")

CreateTableOne(vars=c("sex", vars), data=Smpl_who)

# Same table stratified by gender
CreateTableOne(vars=vars, strata=strata, data=Smpl_who)

# The table can be saved through print(CreateTableOne(....))

# Exercise 

# Make a descriptive table with 3 columns:
#1. the overall descriptive 
#2. the female participants
#3. the male participants
# Take out p-values and test columns.

