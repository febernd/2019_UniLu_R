rm(list=ls()) # Remove what is in working memory
graphics.off()  # Reset default window state


#########################
## Getting Started

#First, set paths to where the course data is saved. 
#The necessary R-libraries will be loaded in the sections where they are used.



# Putting path to data and place to save outputs.

path_general="C:/Users/carol/Documents/Data Fittery/R-Kurs UniLu/Visual Analysis/"
path_data=paste(path_general, "Data/", sep="") #path to data
dir.create(paste(path_general, "Output/", sep=""), showWarnings=FALSE) #put output folder
path_output=paste(path_general, "Output/", sep="") #path to output folder


# Read in the WHO-MDS data sample
Smpl_who=read.csv(file=paste(path_data, "WHO_MDS_large.csv", sep=""), 
                  header=TRUE, sep=",")

#gives the structure of Smpl_who datasete
str(Smpl_who)
