# Exercise 
# In this exercise you will plot a boxplot of the health problems score 
#   across the two gender groups
# Refer to the reference https://ggplot2.tidyverse.org/reference and
# # https://ggplot2.tidyverse.org/reference/geom_boxplot.html for details

# Build the graph step by step using Smpl_who
# First, tell R which data set to use (ggplot), establish the basic aesthetics (aes) of
#        what to draw on the x and y axis and which variable to use to color the
#        two box plots, and define the geometry (geom_boxplot)
p <- ggplot(Smpl_who) + # Data set
  aes(x=sex, y=health, fill=sex) + # Re-order
  geom_boxplot() # Standard point chart
p

# Next, color (use fill-argument) females in "Coral" and males in "cornflower" blue
#     tip: define a help vector analogue to green_red called coral_blue and
#          assign names() for the vector to establish the mapping to the gender groups
#     tip: use scale_color_manual with the "fill" aesthetics property
coral_blue <- c("Coral", "cornflowerblue")
names(coral_blue) <- c("female", "male")

p2 <- p +
  scale_colour_manual(values = coral_blue, aesthetics = "fill")
p2

# Next, assign nicer x and y axis labels
#   Also, extend the y-axis range
p3 <- p2 +
  xlab("Gender") + ylab("Health Problems Score") +
  ylim(0,100) # Extend y-axis range
p3

# Next, change the plot template to theme_minimal
p4 <-  p3 + 
  theme_minimal()
p4

# Next, add a main title and center it
p5 <- p4 +
  ggtitle("Health Problems vs. Gender Groups") +  # Add title
  # Format title
  theme(plot.title = element_text(hjust = 0.5, size = 12, face="bold"))
p5

# Remove the plot's legend
# Tip: this is a theme option
p6 <- p5 +
  theme(legend.position = "none") 
p6

# Final Task (...tricky): Add a horizontal line to the end of your whiskers
#   as is often the case in standard boxplots
#   Tip: Modify stat_boplot() and add to plot
p7 <- p6 +
  stat_boxplot(geom = "errorbar", aes(ymin = ..ymax..)) +
  stat_boxplot(geom = "errorbar", aes(ymax = ..ymin..)) 
p7
