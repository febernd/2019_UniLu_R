
########################
## Saving & Basic plot options

######
# Saving Plots
# 1) path_output has been set earlier, 
# 2) name of the figure: Plot_to_save
# 3) and file type .pdf

pdf(paste(path_output, "Plot_to_save.pdf", sep=""), paper="a4") 

# Copy paste an entire plot code here

dev.off() # Closes the last pdf window


###################################################
## Basic plotting options

# Starting with the R-output of an x against y plot 
#  where no further specifications are provided.

plot(x=Smpl_who$age, y=Smpl_who$health) # Zero adjustments plot


##################
# Setting the ranges of the axes with xlim and ylim

range(Smpl_who$age)

range(Smpl_who$health)


#redraw the plot with modified axis ranges

plot(x=Smpl_who$age, y=Smpl_who$health, # x and y coordinates
     xlim=c(15, 100),  # Age ranges from 18 to 100
     ylim=c(0, 80)) # True range of the measure is 0 to 100


############
### Title, subtitles, labels
#redraw the plot by adding titles, subtitles and labels

plot(x=Smpl_who$age, y=Smpl_who$health,
     xlim=c(15,100), ylim=c(0,80), # Axes range
     xlab="Age", # Axis label
     ylab="Health Problems Score", # Axis label
     main="Chile", # Main title
     sub="WHO-MDS") # Subtitle


##############
### Character size expansion 
# cex=1 does not change the size, < 1 downsizes, > 1 enlarges

plot(x=Smpl_who$age, y=Smpl_who$health,
     xlim=c(15,100), ylim=c(0,80),
     xlab="Age", 
     ylab="Health Problems Score",
     main="Chile", 
     sub="WHO-MDS",
     cex.lab=0.9, # Downsizing axis labels
     cex.main=1.5, # Enlarging main title
     cex.sub=0.6, # Downsizing the subtitle
     cex.axis=0.8,  # Downsizing axis numbering
     cex=0.8, # Downsizing the points in the plot
     pch=19) # Change point type makes it look already a little bit better ?points


####################################
### Coloring
# For the coloring, same command strategy col. + axis, lab, main, sub

plot(x=Smpl_who$age, y=Smpl_who$health,
     xlim=c(15,100), ylim=c(0,80),
     xlab="Age", 
     ylab="Health Problems Score",
     main="Chile", 
     sub="WHO-MDS",
     cex.lab=0.9, col.lab="seagreen4", # Downsizing & coloring axis labels
     cex.main=1.5, col.main="palevioletred3", # Enlarging & coloring main title
     cex.sub=0.6, col.sub="maroon1", # Downsizing & coloring the subtitle
     cex.axis=0.8, col.axis="gray29",  # Downsizing & coloring axis numbering
     cex=0.8, col="darkslategrey", # Downsizing & coloring the points
     pch=19) # Putting bullets


##########################
### Font
# For the font, same command strategy font. + axis, lab, main, sub

plot(x=Smpl_who$age, y=Smpl_who$health,
     xlim=c(15,100), ylim=c(0,80),
     xlab="Age", 
     ylab="Health Problems Score",
     main="Chile", 
     sub="WHO-MDS",
     cex.lab=0.9, col.lab="seagreen4", font.lab=2, # Bold
     cex.main=1.5, col.main="palevioletred3", font.main=3, # Italic
     cex.sub=0.6, col.sub="maroon1", font.sub=4, # Bold and italic
     cex.axis=0.8, col.axis="gray29", font.axis=1,  # Standard font
     cex=0.8, col="darkslategrey",
     pch=19) 

#####################
### Points & symbols with pch
# plot with different symbols for male and females

#create data subsets - ?subset
Smpl_who_male=subset(Smpl_who, sex=="male")
Smpl_who_female=subset(Smpl_who, sex=="female") # Could also be written sex!="male"


# First: make a plot for the male subsample
plot(x=Smpl_who_male$age, y=Smpl_who_male$health,
     xlim=c(15,100), ylim=c(0,80),
     cex.axis=0.85,
     xlab="Age", cex.lab=0.9,
     ylab="Health Problems Score", 
     main="Chile", cex.main=1.25, font.main=2,
     sub="WHO-MDS", cex.sub=0.75, font.sub=3,
     pch=17, col="cornflowerblue", # Blue triangles
     cex=1)

# Second: add to the plot the points of the female subsample
points(x=Smpl_who_female$age, y=Smpl_who_female$health,
       pch=19, col=Coral,  # Living coral circles
       cex=1)

###########################################
#Increase transparence of points
# First: make a plot for the male subsample

plot(x=Smpl_who_male$age, y=Smpl_who_male$health, 
     xlim=c(15,100), ylim=c(0,80),
     cex.axis=0.85, 
     xlab="Age", cex.lab=0.9,
     ylab="Health Problems Score",
     main="Chile", cex.main=1.25, font.main=2,
     sub="WHO-MDS", cex.sub=0.75, font.sub=3,
     pch=17, cex=1, 
     col=transparent(orig.col="cornflowerblue", trans.val=0.3)) # Transparency 30%

# Second: add to the plot the points of the female subsample
points(x=Smpl_who_female$age, y=Smpl_who_female$health,
       pch=19, cex=1,
       col=transparent(orig.col=Coral, trans.val=0.5)) # Transparency 50%


# Exercise

# Try out the different point types by using pch 
# Check ?points to see the pch options displayed  
# Vary the size, color and transparency of the plotting symbols



#########################################################################
### Axes
# Draw same plot than previously but supressing the axes and frame

plot(x=Smpl_who_male$age, y=Smpl_who_male$health, 
     xlim=c(15,100), ylim=c(0,80),
     cex.axis=0.85, 
     xlab="Age", cex.lab=0.9, col.lab="dimgrey",
     ylab="Health Problems Score",
     main="Chile", cex.main=1.5, font.main=2, col.main="dimgrey",
     sub="WHO-MDS", cex.sub=0.75, font.sub=3, col.sub="dimgrey",
     pch=17, 
     col=transparent(orig.col="cornflowerblue", trans.val=0.5),
     bty="n", # Suppresses the box around the plot
     xaxt="n", yaxt="n")  # Suppresses the axes

# Add to the plot the points of the female subsample
points(x=Smpl_who_female$age, y=Smpl_who_female$health,
       pch=19, 
       col=transparent(orig.col=Coral, trans.val=0.5))

# Now let's put some axes
# The number coming after the command indicates the side, it always starts 
#  below and goes clockwise 1=bottom, 2=left, 3=top, 4=right

#  x axis below with ticks for every 10 years
# Start by checking the range of ages

axis(1, at=seq(15,100,10), labels=TRUE,
     cex.axis=0.85,
     col="dimgrey", 
     col.ticks="dimgrey", # Color of tick marks
     col.axis="dimgrey") # Color of the axis

# y axis on the left  with ticks for every 10 years
# Start by checking the range of health

axis(2, at=seq(0, 80, 10),
     labels=TRUE, # Add labels to each tick (default: TRUE)
     cex.axis=0.75,
     las="1", # Orientation of the labels 1=horizontal
     col="dimgrey", 
     col.ticks="dimgrey",
     col.axis="dimgrey")

# By varying the size of the ticks a metric type of ruler could be done, why not.
# Refining y-axis with intermediate, smaller ticks - option tck

axis(2, at=seq(0, 80, 1), labels=FALSE, # Plot 80 ticks each 1 unit apart
     tck=-0.02, # shorter tick mark length
     cex.axis=0.85,
     col="dimgrey",
     col.ticks="dimgrey")


#####################################
### Legend
# Adding the legend


legend("topright", c("Male", "Female"), 
       pch=c(17,19),  # Plotting symbols 
       col=c("cornflowerblue", Coral)) # Colors of the plotting symbols


# Exercise

# The legend looks still terrible let's remove the box 
# Reformat the legend in an appropriate size
# Reposition the legend using the coordinate system if required
# Add transparency to the legend points


graphics.off() #Reset default window state
