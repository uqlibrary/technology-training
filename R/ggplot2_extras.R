## notes

# How to centre the title https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2
# From the release news of ggplot 2.2.0: "The main plot title is now left-aligned to better 
# work better with a subtitle". See also the plot.title argument in ?theme: "left-aligned by 
# default". 

theme(plot.title = element_text(hjust = 0.5))

# If you always want to have the title in the middle

theme_update(plot.title = element_text(hjust = 0.5))

## vertical labels
# https://stackoverflow.com/questions/1330989/rotating-and-spacing-axis-labels-in-ggplot2

theme(axis.text.x = element_text(angle = 90, hjust = 1))
