

########################
# ggplot

### Barcharts with ggplot2

library(ggplot2)
library(dplyr)

# Calculate average health problems score per level of getting_out
data <- Smpl_who %>% 
  group_by(energy) %>% 
  summarize(count = n())

# Recode numbers to text labels
data$energy_labels <- recode(data$energy, "1" = "no problem", 
                             "2" = "mild", "
                                           3" = "moderate",
                             "4" = "severe", 
                             "5" = "extreme")

# Define an ordered factor for energy labels
data$category <- factor(data$energy_labels, ordered = TRUE,
                        levels = c("no problem", "mild", "moderate", 
                                   "severe", "extreme"))

# Define a color scale from green to red and a mapping to
#   the levels of the energy variable
green_red <- rev(brewer.pal(5, "RdYlGn"))
names(green_red) <- c("no problem", "mild", "moderate", "severe", "extreme")

# Store basic plot in variable p
p <- ggplot(data) + # Data set
  aes(x=energy_labels, y = count)  # Base aesthetics

p2 = p +
  # stat = "identity" tells ggplot to plot the formerly calculated 
  #   frequency values "as is", i.e. no further aggregation needs 
  #   to be performed
  geom_bar(stat = "identity") # Standard bar chart
p2

p3 = ggplot(data) + # Data
  aes(x=reorder(energy_labels, energy), y = count) + # Reorder
  geom_bar(stat = "identity") # Standard barchart
p3

# Alternatively, an ordered factor can be used
p3 = ggplot(data) + # Data
  aes(x=category, y = count) + # Reorder
  geom_bar(stat = "identity") # Standard barchart
p3

p4 = p3 +
  # Modify fill color and add black box around each bar 
  geom_bar(stat = "identity", fill=green_red, color="black") 
p4

p5 = p4 +
  xlab("Problems with Energy") + # Modify x-axis label
  ylab("Frequency") + # Modify y-axis label
  ggtitle("ggplot Bar Chart") + # Add title
  theme(plot.title = element_text(hjust = 0.5)) # Center the title
p5

p6 = p5 +
  theme_light() # Theme with light background grid
p6

p7 = p6 +
  geom_text(aes(label=count), # Values to plot
            vjust=-1, # Position
            color="black", size=4, # Color and size
            fontface="bold") + # Bold font
  ylim(0,250) + # Extend y-axis to fit the data label
  theme(plot.title = element_text(hjust = 0.5)) # Center the title
p7



# Pie Chart
# Compute percentages
data$fraction <- data$count / sum(data$count)

# Compute the cumulative percentages (top of each rectangle)
data$ymax <- cumsum(data$fraction)

# Compute the bottom of each rectangle
data$ymin <- c(0, head(data$ymax, n=-1))

# Compute label position
data$labelPosition <- (data$ymax + data$ymin) / 2

# The above transformations allow to draw a stacked bar chart with
#   hight from 0 to 1 and with width from 2 to 4
stacked_bar <- ggplot(data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=2, fill=category)) +
  geom_rect(color="black") + 
  scale_colour_manual(values = green_red, aesthetics = "fill") # Color schema
stacked_bar

# The axis around the circle rangs from 0 to 1 (clockwise)
#   The axis from the center to the edge of the pie chart goes from 2 to 4
#   Note, that this corresponds to the stacked barchart dimensions defined above
pie <- stacked_bar + # Start from stacked barchart
  # Define position and size of the text
  coord_polar(theta="y")  #  # Transformation into  
pie

# Add data values around the chart and format the legend
pie2 <- pie +
  xlim(c(2, 4.4)) + # Slightly extend x-axis to have space for data values
  # 4.7 is outside of the pie's position.
  geom_text( x=4.7, aes(y=labelPosition, label=count), size=6) +
  theme_void() + # No background
  theme(legend.position = "bottom") + # Legend at bottom
  labs(fill="") + # Legend without title
  ggtitle("ggplot Pie Chart") +  # Add title
  # Format title
  theme(plot.title = element_text(hjust = 0.5, size = 20, face="bold"))
pie2

# Donut chart

# Basic aesthetics
# Donut chart is basically the same plot, just with a hole in the middle,
# Cut the hole into the donut chart by extending the x-axis 
# from 2 (center of the pie) to -1, hence "moving" the
# pie along the axis and adding some free space into the middle   
donut <- pie2 +
  xlim(c(-1, 4)) + # -1 is the new center of the plot, 4 remains the outer edge
  ggtitle("ggplot Donut Chart")  # Add title
donut

graphics.off() # Reset default window state


# Exercise 
# In this exercise you will plot a boxplot of the health problems score 
#   across the two gender groups
# Refer to the reference https://ggplot2.tidyverse.org/reference and
#         https://ggplot2.tidyverse.org/reference/geom_boxplot.html for details

# Build the graph step by step using Smpl_who
# First, tell R which data set to use (ggplot), establish the basic aesthetics (aes) of
#        what to draw on the x and y axis and which variable to use to color the
#        two box plots, and define the geometry (geom_boxplot)

# Next, color (use fill-argument) females in "Coral" and males in "cornflower" blue
#     tip: define a help vector analogue to green_red called coral_blue and
#          assign names() for the vector to establish the mapping to the gender groups
#     tip: use scale_color_manual with the "fill" aesthetics property

# Next, assign nicer x and y axis labels
#   Also, extend the y-axis range

# Next, change the plot template to theme_minimal

# Next, add a main title and center it

# Remove the plot's legend
# Tip: this is a theme option

# Final Task (...tricky): Add a horizontal line to the end of your whiskers
#   as is often the case in standard boxplots
#   Tip: Modify stat_boplot() and add to plot


