####################################
# A few more plots


##Diaporama (or Plotorama) syntax to illustrate a few plots


###########################
## Association plots

library(igraph) # A package for network plots

# Putting the numbers as numeric and calculating the rank correlation
Smpl_who[,c("stand_up", "getting_out", "go_somewhere", 
            "dexterity", "energy", "relating", 
            "memory", "relax", "stress", "anxiety")]=
  apply(Smpl_who[,c("stand_up", "getting_out", 
                    "go_somewhere", "dexterity", 
                    "energy", "relating", 
                    "memory", "relax", "stress", 
                    "anxiety")],2,as.numeric)

Correl=cor(Smpl_who[,c("stand_up", "getting_out", "go_somewhere", 
                       "dexterity", "energy", "relating", 
                       "memory", "relax", "stress", "anxiety")], 
           method="spearman",
           use="pairwise.complete.obs")

# Keep positive correlations
Correl[Correl<0.3] = 0  # This can be varied to keep only higher positive correlations

# Make an Igraph object from this matrix:
network = graph_from_adjacency_matrix(Correl, 
                                      weighted=TRUE, 
                                      mode="undirected", 
                                      diag=FALSE)

# Layout the spacial arrangement of vertices based on 
#  the circle-algorithm
coords <- layout_in_circle(network) 

# Basic chart, see ?igraph.plotting for all available options
plot.igraph(network, # data to plot
            layout=coords, # coordinates for vertex arrangement
            vertex.color=Coral, # vertex coloring
            vertex.size=5, # reduce point size
            vertex.frame.color="gray",  # edge color
            vertex.label.color="black", # vertex label color
            vertex.label.cex=0.8, # vertex label size
            vertex.label.dist=2, # distance of label from vertex
            vertex.label.font=2) # increase label font size


############
## Three dimensional plot

library(scatterplot3d)

Complete_Cases=complete.cases(Smpl_who[,c("stand_up", "getting_out", 
                                          "go_somewhere", "dexterity", "energy", "relating", "memory", 
                                          "relax", "stress", "anxiety")])

Smpl_who_CC=Smpl_who[Complete_Cases,c("stand_up", "getting_out", 
                                      "go_somewhere", "dexterity", "energy", "relating", 
                                      "memory", "relax", "stress", "anxiety")]


Principal_Components=prcomp(Smpl_who_CC, scale=TRUE)$rotation

scatterplot3d(x = Principal_Components[,1], 
              y = Principal_Components[,2], 
              z = Principal_Components[,3], 
              xlab="PC1", ylab="PC2", zlab="PC3")

######################33
## GUI for 3D-plot

# On Mac: require installation of XQuartz from xquartz.org
#         need to restart computer after installation
library(rgl)

rgl::plot3d(Principal_Components[,1], 
            Principal_Components[,2], 
            Principal_Components[,3], type="n",
            xlab="PC1", ylab="PC2", zlab="PC3", 
            axes=TRUE, 
            box=FALSE)
rgl::text3d(Principal_Components[,1], 
            Principal_Components[,2], 
            Principal_Components[,3],
            text=rownames(Principal_Components), 
            cex=0.7)

#######################
## Mosaic plot

d_mosaic <- table(Smpl_who$energy, Smpl_who$getting_out)
mosaicplot(d_mosaic, xlab = "Energy", ylab = "Getting Out", color = TRUE)

dev.off()
############################
## Venn diagrams


# Generate 3 sets of 200 numbers that randomly overlap some elements
set1 <- sample(1:500, size = 200, replace = TRUE)
set2 <- sample(1:500, size = 200, replace = TRUE)
set3 <- sample(1:500, size = 200, replace = TRUE)

# install.packages("VennDiagram")
library(VennDiagram)

# Chart
venn.plot=venn.diagram(
  x = list(set1, set2, set3),
  category.names = c("Set 1" , "Set 2 " , "Set 3"),
  filename = NULL,
  
  # Circles
  lwd = 1, # Reduce line width
  fill =  c("Coral", "lightgray", "cornflowerblue"),
  
  # Numbers
  cex = 1, # Reduce size of numbers
  fontfamily = "sans",  # Font without serifs
  
  # Set names
  cat.cex = 1, # Reduce size of labels
  cat.fontface = "bold", # Put labels in bold
  cat.dist = c(0.05, 0.05, 0.05), # Distance of set labels
  cat.fontfamily = "sans") # Font without serifs

grid.draw(venn.plot)
################################
## Word cloud
library(wordcloud)

set.seed(123) # Make the results reproducible
# Selecting 200 colors from the color name list with the function sample()
n <- 200  
# Use rbeta to create frequencies s.t. large weights become increasingly unlikely
# This will allow to plot a word cloud with some larger words and many smaller words 
# This resambles proportions in a typical text analysis word cloud
colors_cloud = data.frame(word = sample(colors(), n), freq = rbeta(n, .2, 5))

# Order from largest to smallest frequency
colors_cloud = colors_cloud[order(colors_cloud$freq, decreasing=T),]
# Keep only frequencies larger than .09 to avoid too extreme size differences
colors_cloud = subset(colors_cloud, freq >= .09)
# Multiply by 1000 to turn frequencies (.05 - 1) into whole numbers (5-1000)
colors_cloud$freq <- round(colors_cloud$freq,3)*1000
# Assign row names
rownames(colors_cloud) = colors_cloud$word

# Draw the word Cloud
wordcloud(words = colors_cloud$word, # Words to draw
          freq = colors_cloud$freq, # Sizing
          colors=(rownames(colors_cloud)), ordered.colors = TRUE) # Coloring

###############
## ggBubble

### Common bubble chart
library(ggplot2)
library(dplyr)

# Calculate the two sub scales
Who_Scales <- data.frame(mental = Smpl_who$stress + Smpl_who$memory + Smpl_who$anxiety,
                         physical = Smpl_who$stand_up + Smpl_who$getting_out +
                           Smpl_who$go_somewhere
)

# Calculate total problems score
Who_Scales$total_problems = Who_Scales$mental + Who_Scales$physical

# Count the number of observations per combination of the two scales
Who_Scales <- Who_Scales %>% 
  group_by(mental, physical, total_problems) %>%
  summarize(count_obs = n())

green_red <- rev(brewer.pal(5, "RdYlGn"))

# Logic for bubble coloring
Who_Scales$total_problems_col = ifelse(Who_Scales$total_problems<5, green_red[1],
                                       ifelse(Who_Scales$total_problems<10, green_red[2],
                                              ifelse(Who_Scales$total_problems<15, green_red[3],
                                                     ifelse(Who_Scales$total_problems<20, green_red[4],
                                                            green_red[5]))))

# Assign the colors also to a vector, so that every element can be named
green_red2 <- green_red
names(green_red2) <- c("<  5", "< 10", "< 15", "< 20", "20+")

# Calculate the re-coded total problems variable for labelling the plot
Who_Scales$total_problems_lab = ifelse(Who_Scales$total_problems<5,  "<  5",
                                       ifelse(Who_Scales$total_problems<10, "< 10",
                                              ifelse(Who_Scales$total_problems<15, "< 15",
                                                     ifelse(Who_Scales$total_problems<20, "< 20",
                                                            "20+"))))

# Remove 4 rows with missing Values
Who_Scales <- Who_Scales[rowSums(is.na(Who_Scales))==0,]

# Call ggplot and define the basic elements to plot
ggplot(Who_Scales, aes(x=physical, y=mental, size = count_obs)) +
  # Draw the bubbles 
  geom_point(alpha=0.7, # Transparency
             pch=21, # Plotting character: circle with border
             color="black", # Black color for the border
             # Color the bubbles based on the values of the total score
             aes(fill=total_problems_lab)) +
  labs(fill="Total Score") + # Label for coloring legend
  scale_size(range = c(2, 20), # Scaling of bubble sizes
             name="Nbr. Obs.") + # Title for bubble size legend
  xlim(0,16) + ylim(0,16) + # Axes ranges
  xlab("Physical Problem Score") + # Axis label
  ylab("Mental Problem Score") + # Axis label
  # Match the value label (e.g. <10) to its respective color
  scale_colour_manual(values = green_red2,  # Color scale
                      aesthetics = "fill") + # Fill color
  theme_minimal()   # Minimal background layout

###################################
### Jittered bubble chart

library(ggBubbles)
ggplot(# Data to plot
  data = Smpl_who,
  aes(x = as.factor(energy),
      y = as.factor(getting_out),
      col = sex)) +
  # Draw multiple points - calculations by position_surround function
  geom_point(position = position_surround())+
  # Colors to use
  scale_colour_manual(values = c(Coral, "cornflowerblue"))+
  # Add grid formatting
  theme_bw(base_size = 18) + # Similar to cex-parameter in base R
  # Nicer axes Labels
  xlab("energy") + ylab("getting_out") 


#################################
## ggpredict

library(ggeffects)
library(ggplot2)

# An additive model with interaction effect and polynom
LM_Health=lm(health ~ sex*poly(age,2)+getting_out+energy+relating+stress+anxiety, 
             data=Smpl_who, na.action=na.omit)

# Calculating adjusted mean health problems scores for age by gender
Age_sex=ggpredict(LM_Health, terms=c("age [all]",  "sex"))
plot(Age_sex, colors="quadro")

# Look at the Age_sex output
Age_sex

# To save the output, get the names of the object to see how it is stored and how it 
#  can be saved
names(Age_sex)

# The values of the ggplot
Graph_values=as.data.frame(cbind(age=Age_sex$x, 
                                 sex=Age_sex$group, 
                                 health=Age_sex$predicted, 
                                 health_se=Age_sex$std.error, 
                                 health_ci_low=Age_sex$conf.low, 
                                 health_ci_up=Age_sex$conf.high))    

# Recode sex here a factor with label as in the Smpl_who data
Graph_values[,"sex"]=factor(Graph_values[,"sex"], 
                            levels=c(1,2), 
                            labels=c("male", "female"))

# Let's add a column with the information on the number of persons for each value row
for(i in 1:nrow(Graph_values)){
  Graph_values[i,"N"]=nrow(Smpl_who[which(Smpl_who[,"age"]==Graph_values[i,"age"] 
                                          & 
                                            Smpl_who[,"sex"]==Graph_values[i,"sex"]),])
}

########################################3
### ggplot-Faking with base R

# Two panes 1 for the line plot of predicted health and 2 for the age distributions
layout(matrix(c(1, 1,  1,  2), ncol=1, byrow=FALSE))

# Quick look at the fields in the plotting window
layout.show(n=2)

# Also, instead of the colors, for example because it is a black and white publication, 
#  the line type is varied.

Lines=c("solid", "dashed") # Check ?par and lty for all different line types

# And we will create a palette of grey colors for the confidence intervals,
#  gray.colors() is found in the package grDevices
ColLine=rep("black", 2)
GraysCI=rep(gray.colors(4, start = 0.3, end = 0.9, gamma = 2, alpha = 0.3)[2],2)



# Start with an empty plot of some kind
# The x-axis width is the range of ages
# The y-axis height chosen here (10,50) is not the actual possible data range, but
#   rather serves as an example for illustration
# We do not draw the axes yet xaxt="n", yaxt="n"


# Putting graphics:: before the plot function tells the engine that we want 
#   the plot function from the package graphics (the generic function) 
#    and not from package ggplot 
# The nested notation 'packagename::function()' is good to remember when things 
#   are not working as expected and many package libraries have been called

# Empty plot
par(mar=c(0.5,5,1,5))  # Control the amount of space around the figure
graphics::plot(1,1, col="white", 
               xlim=c(min(Smpl_who$age)-1, max(Smpl_who$age)+1), xlab="", xaxt="n",
               ylim=c(10,50),  ylab="Health Problems Score", yaxt="n", 
               cex.lab=1.2, 
               bty="n", 
               col.lab="black")

# Drawing the y-axis only
axis(2, at=seq(10,50,5), labels=seq(10,50,5), 
     cex=0.5, 
     col="slategrey", 
     col.axis="slategrey", 
     col.ticks="slategrey")

# Add grid lines to the plot just as in ggplot
# There is a function grid()... but it is finally handier to put segment lines on its own
# Draw the segments before the plot so that they are in the background 
# The function segments() draws straight lines

HL=c(10,20,30,40,50) # The location of the horizontal lines
for(i in 1:length(HL)){
  segments(min(Smpl_who$age)-1, HL[i], max(Smpl_who$age)+1, HL[i], 
           col="lightgrey", lty="solid")
}

VL=c(25, 35, 45, 55, 65, 75, 85, 95) # The location of the vertical lines
for(i in 1:length(VL)){
  segments(VL[i], 10, VL[i], 50, 
           col="lightgrey", lty="solid")
}


S=c("male", "female")
# Adding a legend
legend("bottomleft",legend=c("female", "male"), 
       col=rep("slategrey",2), 
       bty="n", 
       lty=Lines)


# Run a loop over the values that sex takes
X=list()  # Naming the list objects in the loop where the information will be stored
Y=list()
XYouter=list()   


for(i in c(1:2)){
  
  # [[i]] means that the values are stored in a list type object, this is working 
  #   the best in loops to avoid overwriting for example
  
  X[[i]]=Graph_values[which(Graph_values[,"sex"]==S[i]),"age"] # x-axis age in subroup
  Y[[i]]=Graph_values[which(Graph_values[,"sex"]==S[i]),"health"] # y-axis health in subgroup
  XYouter[[i]]=Graph_values[which(Graph_values[,"sex"]==S[i]),
                            c("health_ci_low","health_ci_up") ]
  
  
  lines(X[[i]], Y[[i]], lty=Lines[i], col=ColLine[i])
  polygon(c(X[[i]], rev(X[[i]])), c(XYouter[[i]][,2], rev(XYouter[[i]][,1])),
          col = GraysCI[[i]], border = NA)
}

# The next empty plot to fill the lower field
par(mar=c(3.5,5,0,5)) # Determine the space around 
# Remark: par(oma=c(,,,) does the same job on another metric)

graphics::plot(1,1, col="white", xlim=c(min(Smpl_who$age)-1, max(Smpl_who$age)+1), 
               ylim=c(0,60), bty="n", yaxt="n",xaxt="n", xlab="", ylab="")


# Make an x-axis which fits the two plots
axis(1, at=seq(15,100,10), labels=seq(15,100,10), cex=0.5, line=-0.7, col="slategrey", 
     col.axis="slategrey", col.ticks="slategrey")


# mtext allows to add whatever text or labels in the margins

mtext("Age", side=1, line=2, col="black", cex=0.85) 
mtext(S, 2, at=c(20,40), las=1, col="slategrey", cex=0.7)


for(i in c(1:2)){  # Open i loop for sex
  
  segments(15, i*20, 100, i*20, lty=Lines[i], col="slategrey")
  
  for(j in 1:length(which(Graph_values[,"sex"]==S[i]))){#j-loop for ages in i-subgroup
    
    segments(Graph_values[which(Graph_values[,"sex"]==S[i])[j],"age"], i*20, 
             Graph_values[which(Graph_values[,"sex"]==S[i])[j],"age"],
             (i*20)+Graph_values[which(Graph_values[,"sex"]==S[i])[j],"N"], 
             col="slategrey", pch=19)
  } # Close j
} # Close i









