
#################
# Boxplots, Histograms, Barcharts


# Boxplot of age
boxplot(Smpl_who[,"age"])


# Boxplot of age and sex
boxplot(Smpl_who[,"age"]~Smpl_who[,"sex"])


# Remark: the same function could also be written as: 
boxplot(Smpl_who$age~Smpl_who$sex)
boxplot(age~sex, data=Smpl_who)


# Exercice
# Add a title for the second plot "Age Quantiles by Gender"
# Add colors to the plot, for example in lightpink1 for the females and 
#  cornflowerblue for the males,

# Do a similar plot to display the health problem scores

###########################
# Histograms and barplots

# Frequency distribution for numeric/continuous variables
hist(Smpl_who[,"health"], main="Health Problems Score Distribution")


# Probability distribution for numeric/continuous variables
hist(Smpl_who[,"health"], main="Probability Distribution", 
       probability=TRUE, # Probability distribution
       ylim=c(0,0.03), # Adjusting the height of the y-axis
       xlab="Health Problems Score", # Putting an x-axis label
       ylab="",
       las=1, # Setting the y-axis labels to be horizontal
       breaks=15, # Specifiying the number of columns in the histogram
       col=transparent(orig.col=Coral, trans.val=0.4), # Color the columns
       border=NULL) # Remove the borders 

# Density line (solid)
lines(density(Smpl_who[,"health"]), col = "black")  # Adding a density line


# Adding a normal distribution curve (dashed)
# To visualize the departure from the normal distribution
xfit=seq(min(Smpl_who[,"health"]),max(Smpl_who[,"health"]),length=nrow(Smpl_who))
yfit=dnorm(xfit,mean=mean(Smpl_who[,"health"]),sd=sd(Smpl_who[,"health"]))

lines(xfit, yfit, col="black", lwd=2, lty="dashed")


#####################
# Barplot
# Plot of heights, i.e. frequencies for factor variables with barplot

barplot(table(Smpl_who[,"stress"]))


######################
### Text 

# Same plot as previously with some modified options
barplot(table(Smpl_who[,"stress"]),
        col=transparent(orig.col=Coral, trans.val=0.44),# Coral color
        border=FALSE, # No border around the colummns
        axes=FALSE, # No axes
        horiz=TRUE, # Displaying the bars horizontally
        names.arg="", # Removing the labels
        main="Stress") # Putting a title

# Adding text in and next to the columns
Labels=c("No Problem", "Mild", "Moderate", "Severe","Extreme")

# Adding text in the margins
mtext(text="Extent of Problem", side=1) # Adding a subtitle, side=1)

mtext(text=Labels, side=2, at=c(0.75, 1.95, 3.15, 4.35, 5.55), # Finding at= positions 
      # is trial & error
      cex=0.8, # Label size
      las=1) # Text shown horizontally 

# Adding frequency of obeservation in and next to columns
N=table(Smpl_who[,"stress"])

# x-coordinate set a little below the highest frequency
text(x=rep(max(N)-20, 5), y=c(0.75, 1.95, 3.15, 4.35, 5.55), labels=N, cex=0.8, 
     col="black") 

graphics.off() # Reset default window state
