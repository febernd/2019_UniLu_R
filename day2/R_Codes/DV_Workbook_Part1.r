
###################
# Colors


#The following link displays the standard colors in R with their labels:
#http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# List of all colors in R. 
colors()


################################################
## Palettes
library(RColorBrewer)

par(mar=c(0,2.3,0,0)) #modify default margin size to better see
                        #all the palette. 
                          #it reads clockwise starting from the bottom
                          #number c(0,2.3,0,0) indicates no margin
                            #at bottom, top, and right side and
                              #some margin on the left to be able to read the labels.
display.brewer.all()


#a color blind friendly palette
display.brewer.all(colorblindFriendly = TRUE)


##Running a palette example in a loop
# Example

par(mfrow=c(3,3))

for(i in 1:9){ # Loop (9 plots total)
# No figure margins (bottom, left, top, right), see ?par for details
par(mar=c(0,0,0,0)) 
plot(0.5, 0.5, # x and y coordinates
     pch=20, # Plotting character nbr. 20 (filled circle)
     cex=25, # Magnify point by a factor of 25 
     xlim=c(0,1), ylim=c(0,1), # Range of x and y axes
     xlab="", ylab="", # No labels for axes
     xaxt="n", yaxt="n", # Axes type - "n" for no axes
     bty="n", # Type of box around plot - "n" for no box
     col=brewer.pal(n = 9, name = "YlOrRd")[i])  # Loop over RColorBrewer palette
  }



## Transparence
library(yarrr)

# A sequence of 9 degrees of transparency

T=seq(0,1,1/8) # 9 step sequence from 0 to 1

par(mfrow=c(3,3))

for(i in 1:length(T)){
par(mar=c(0,0,0,0))
plot(0.5, 0.5, 
     pch=20, cex=25, 
     xlim=c(0,1), ylim=c(0,1), 
     xlab="", ylab="",
     xaxt="n", yaxt="n",
     bty="n",
     # Transparency gradient for black
     col=transparent(orig.col="black", trans.val=T[i]))
  # Add text (the % of transparency) to the graphic
  text(0.5,0.5, labels=round(T[i],2), cex=2.5)
}


#########################################################
## Mixing own colors

# Programming one's own color or after having found its RGB composition

# Red green and blue composition of the color 2019
Coral=rgb(255, 111, 97, maxColorValue = 255)

T=seq(0,1,1/8)

par(mfrow=c(3,3))

for(i in 1:length(T)){
par(mar=c(0,0,0,0))
plot(0.5, 0.5, 
     pch=20, cex=25, 
     xlim=c(0,1), ylim=c(0,1), 
     xlab="", ylab="",
     xaxt="n", yaxt="n",
     bty="n",
     # Replace black by Coral
     col=transparent(orig.col=Coral, trans.val=T[i]))
  text(0.5,0.5, labels=round(T[i],2), cex=2.5)
}


graphics.off() # Reset default plotting window to continue

# Exercise

# How does the color of the year 2020 look like in R?
# See RGB / HEX here: https://www.pantone.com/color-finder/19-4052-TCX

