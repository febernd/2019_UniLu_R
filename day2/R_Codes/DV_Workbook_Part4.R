

###############################
# Plots from scratch

#####
## Layout


par(oma=c(.25,.25,.25,.25)) # Add margins to print entire plot

# 4 plotting fields from top left to bottom right
mat1=matrix(c(1,2,3,4), byrow=TRUE, ncol=2)
layout(mat1)
layout.show(n=4)


# 4 plotting fields from bottom left to top left
mat2=matrix(c(4,3,1,2), byrow=TRUE, ncol=2)
layout(mat2)
layout.show(n=4)


# 4 plotting fields from bottom left to top left, top plots being twice as large
mat3=matrix(c(4,3,4,3, 1,2), byrow=TRUE, ncol=2)
layout(mat3)
layout.show(n=4)


# 6 plotting fields 3 equal size on the left, two on the right 
#   separated by a text field
mat4=matrix(c(1,4,
              1,4,
              1,4,
              2,4,
              2,5,
              2,6,
              3,6,
              3,6,
              3,6), byrow=TRUE, ncol=2)

layout(mat4)
layout.show(n=6)



##############
# Plot 4 barplots into the layout:
mat=matrix(c(1,2,3,4), byrow=TRUE, ncol=2)
layout(mat)

# In fields 1,2, 3 and 4: barplots for energy, stress, relax and getting_out
Labels=c("No Problem", "Mild", "Moderate", "Severe","Extreme")
Variable=c("energy", "stress", "relax", "getting_out")

for(i in 1:length(Variable)){ 
  par(mar=c(1,6,1,2))
  
  barplot(table(Smpl_who[,Variable[i]]),
          col=transparent(orig.col=Coral, trans.val=0.44), # Coral color
          border=FALSE, # No border around the colummns
          axes=FALSE, # No axes
          horiz=TRUE, # Displaying the bars horizontally
          names.arg="", # Removing the labels
          main=Variable[i], # Putting a title
          cex.main=1.25) # Resizing title
  
  # Adding text in the margins
  mtext(text=Labels, side=2, at=c(0.75, 1.95, 3.15, 4.35, 5.55), 
        cex=.75, # Label size
        las=1) # Text shown horizontally 
  
  # Adding frequency of obeservation in and next to columns
  N=table(Smpl_who[,Variable[i]])
  # y-coordinate set to the highest frequency 
  text(x=rep(max(N)-20, 5), y=c(0.75, 1.95, 3.15, 4.35, 5.55), 
       labels=N, cex=1, col="black") 
  } 


####################
## Empty plots

# The 'drawing an empty plot' approach
plot(1,1, col="white", # White point on white background
          xlim=c(15,100), ylim=c(0,80), # Specify require axes ranges
          bty="n", # No frame
          yaxt="n",xaxt="n",   # No axes
          xlab="", ylab="")   # No default labels


# Exercise

# Draw only a frame
# Draw only an x-axis



######################
## Drawing a plot


#layout with text on top, mirrored histograms and an arrow on the left
layout(mat = matrix(c(1,1,1,1,1,
                4,2,2,3,3), 
                byrow=TRUE, nrow=2),
       height = c(0.2, 0.8))

layout.show(n=4)

par(mar=c(0,0,0,0)) #set the margins to zero
# The 'drawing an empty plot' approach
plot(1,1, col="white", 
           xlim=c(0,10), ylim=c(0,1), # Random size (only ratio imports)
           bty="n", # No frame
           yaxt="n",xaxt="n", # No axes
           xlab="", ylab="") # No default labels

text(6,.5, "Problems with stress", # Some title for the example 
        font=2,
        col="black",
        cex=2.5)


# Computing the frequencies per gender
Freq=table(Smpl_who[,c("stress", "sex")])
Freq_male=Freq[,2]
Freq_female=Freq[,1]

# Histogram for male subgroup

par(mar=c(0.5,0,1.25,0)) # Margin size adjustment

# Starting with an empty but sized plotting field
 plot(1,1, col="white", 
           xlim=c(max(Freq)+25,0), ylim=c(0,nrow(Freq)), # Give it the size needed
           main="Male", # Title instead of legend,
           cex.main = 2,
           bty="n", # No frame
           yaxt="n",xaxt="n", # No axes
           xlab="", ylab="") # No default labels

 # Drawing rectangles of the size of the frequencies for the male subgroup 
for(i in 1:length(Freq_male)){
rect(xleft=0, ybottom=i-1, xright=Freq_male[i], ytop=i-0.15, 
     col="cornflowerblue", border=NULL)
text(x=max(Freq)+15, y=i-0.5, labels=Freq_male[i], cex=1.8)
}
 

# Histogram for female subgroup 
par(mar=c(0.5,0,1.25,0)) #margin size adjustment

# A second empty but sized plotting field
  plot(1,1, col="white", 
           xlim=c(0, max(Freq)+25), ylim=c(0,nrow(Freq)), # Give it the size needed
           main="Female", # Title instead of legend,
           cex.main = 2,
           bty="n", # No frame
           yaxt="n",xaxt="n", # No axes
           xlab="", ylab="") # No default labels
  
# Drawing rectangles of the size of the frequencies for the female subgroup
for(j in 1:length(Freq_female)){
rect(xleft=0, ybottom=j-1, xright=Freq_female[j], ytop=j-0.15, 
     col=Coral, border=NULL)
text(x=max(Freq)+15, y=j-0.5, labels=Freq_female[j], cex=1.8)
}
 
  # Empty plot
   plot(1,1, col="white", 
           xlim=c(0, 4), ylim=c(0,10), # Give it the size needed
           bty="n", # No frame
           yaxt="n",xaxt="n", # No axes
           xlab="", ylab="") # No default labels
   
   # Putting an arrow
   arrows(x0=3, y0=0.5, x1=3, y1=9.5, 
                    length=0.15, # Size of arrow head 
                    angle=25, # Angle 'from shaft to edge' of the arrow
                    code=3) # Type of arrow
   
   # Add some text left to the arrow
   text(2,1.5, "no problem", cex=1.8, srt=90) # srt=string rotation in degree
   text(2,8.2, "extreme problem", cex=1.8, srt=90)
   
graphics.off() # Reset default window state
