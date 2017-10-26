# Heatmaps
# Description: Examples of different heatmaps
# Author: Paula Andrea Martinez
# Date: Oct 26, 2017


# A heatmap is a way of visualizing a table of numbers, 
# where you substitute the numbers with colored cells. 
# It’s useful for finding highs and lows, and see patterns more clearly.

# 1. Simple heatmaps
# URL: https://flowingdata.com/2010/01/21/how-to-make-a-heatmap-a-quick-and-easy-solution/

# Step 1 data 
?read.csv
nba <- read.csv(file = "http://datasets.flowingdata.com/ppg2008.csv")

# Step 2 - exercise explore the data (2 min)
dim(nba)
str(nba)
head(nba)
View(nba)
# PTS are points

# Step 3 - exercise - update the dataset (2 min)
# 1. assign the Name column to rownames(nba)
rownames(nba) <- nba$Name
rownames(nba)
# 2. delete the column Name
nba$Name <- NULL
head(nba)

# Step 4 - Prepare data, again
# Are you noticing something here? It’s important to note that a lot of visualization 
# involves gathering and preparing data. Rarely, do you get data exactly how you need it,
# so you should expect to do some data munging before the visuals. 

# The data was loaded into a data frame, but it has to be a data matrix to make your heatmap.
# The difference between a frame and a matrix is not important for this tutorial. 
# You need to know how to change it.

# - exercise convert the nba data into a matrix (1 min) - discuss
class(nba)
nba_matrix <- data.matrix(nba)# Convert a Data Frame to a Numeric Matrix
nba_matrix1 <- matrix(nba) 
nba_matrix2 <- as.matrix(nba) # attempts to turn its argument into a matrix.
class(nba_matrix2)
class(nba_matrix1)
class(nba_matrix)

identical(nba_matrix1, nba_matrix)

# Step 5 - Make a heatmap

# Exercise (2 min) look for the heatmap help
# read the scale atribute
?heatmap
nba_heatmap <- heatmap(nba_matrix)
dev.off()
# scale is important: the values should be centered and scaled in either the row 
# direction or the column direction
nba_heatmap <- heatmap(nba_matrix, scale="column")
dev.off()
# Colours 
# palette cm.colours(n), n is the number of colors (≥ 1) to be in the palette.
# margings 5 is bottom and 10 is left
nba_heatmap <- heatmap(nba_matrix, col = cm.colors(100), 
                       scale = "column", margins = c(5,10))
dev.off()
# remove dendrograms
# Rowv	the row dendrogram; only if input Rowv was not NA and keep.dendro is true.
# Colv	the column dendrogram; only if input Colv was not NA and keep.dendro is true.

nba_heatmap <- heatmap(nba_matrix, col = cm.colors(100), 
                       scale = "column", margins = c(5,10),
                       Rowv = NA, Colv = NA)
dev.off()

# Labels
nba_heatmap <- heatmap(nba_matrix, col = cm.colors(100), 
                       scale = "column", margins = c(5,10),
                       Colv = NA,
                       labCol =  "", ylab = "Names",
                       main = "Scores of nba players")
dev.off()

# Clean my environment
rm(list = ls())

#####################################################################################
# That is for understanding how heatmaps work and the basic parameters
# URL: https://rpubs.com/ab604/98032
## 2. gplots heatmap.2
# Exercise (2 min )
#install.packages("gplots")
library(gplots)
?heatmap.2
# This heatmap provides a number of extensions to the standard R heatmap function.
# also need a new palette of colours called RColorBrewer
#install.packages("RColorBrewer", dependencies = TRUE)
library(RColorBrewer)

# Step 1 data
# observations for 63 proteins for three control experiments and three experiments
# where cells are treated with a growth factor.
rawdata <- read.csv("https://raw.githubusercontent.com/ab604/heatmap/master/leanne_testdata.csv")

# Step 2 - exercise explore the data (2 min)
dim(rawdata)
str(rawdata)
head(rawdata)
View(rawdata)
data(rawdata)
str(rawdata)

# Step 3 munging
rawdata$Row_ID <- NULL
rawdata$T.test <- NULL
head(rawdata)
colnames(rawdata) <- c(paste(rep("Control_", 3), 1:3), 
                       paste(rep("Treatment_", 3), 1:3))
head(rawdata)

# Step 4 - exercise - convert the rawdata into a matrix
class(rawdata)
data_matrix <- data.matrix(rawdata) # Convert a Data Frame to a Numeric Matrix
head(data_matrix)
class(data_matrix)

# Step 5 - more munging - scaling 
?scale
# scale is generic function whose default method centers and/or scales the columns of a 
# numeric matrix.
# We normalise the data using scale, transposing using t to perform row-wise normalisation
# of the proteins, so that we normalise the proteins across each experiment and we can 
# compare experiments:
# z=x−μσ
# Additionally, transpose the data back to the original form, for use later on.

# Normalize data, transpose for row wise normalisation
data_scaled_t <- scale(t(rawdata))

# check the normalisation, here we calculate the means and standard deviation for each row
# (each protein):
  
# Check means are zero 
round(colMeans(data_scaled_t), 1)

# check std devs are 1
apply(data_scaled_t, 2, sd)

# Put data back in original form
data_scaled <- t(data_scaled_t)

# Step 5 - Make a heatmap
heatmap(data_scaled)
dev.off()
heatmap(data_scaled, col = topo.colors(25), 
        margins = c(8,10))
dev.off()

#Set colours for heatmap, 25 increments
my_palette <- colorRampPalette(c("blue", "white", "red"))(n = 25)

# Plot heatmap with heatmap.2
par(cex.main = 0.75)                    # Shrink title fonts on plot
heatmap.2(data_scaled,                  # normalised data
          density.info = "histogram",   # Plot histogram of data and colour key
          trace = "none",               # Turn of trace lines from heat map
          col = my_palette,             # Use my colour scheme
          cexRow = 0.5, cexCol = 0.75)  # Amend row and column label fonts

dev.off()


# Plot heatmap with heatmap.2

# Open a file for pdf
pdf(file = "plots/my_heatmap.pdf", paper = "a4") 
par(cex.main = 0.75)                    # Shrink title fonts on plot
heatmap.2(data_scaled,                  # normalised data
          density.info = "histogram",   # Plot histogram of data and colour key
          trace = "none",               # Turn of trace lines from heat map
          col = my_palette,             # Use my colour scheme
          cexRow = 0.5, cexCol = 0.75)  # Amend row and column label fonts

# Close file
dev.off()

# Open a file for a png 
png(file="plots/my_heatmap.png", width = 800, height = 800, units = "px", bg = "white") 
par(cex.main = 0.75)                    # Shrink title fonts on plot
heatmap.2(data_scaled,                  # normalised data
          density.info = "histogram",   # Plot histogram of data and colour key
          trace = "none",               # Turn of trace lines from heat map
          col = my_palette,             # Use my colour scheme
          cexRow = 0.5, cexCol = 0.75)  # Amend row and column label fonts

# Close file
dev.off()

# a few more extras

heatmap.2(data_scaled,                  # normalised data
          density.info = "histogram",   # Plot histogram of data and colour key
          dendrogram = "row", 
          Colv = NA,
          trace = "none",               # Turn of trace lines from heat map
          col = my_palette,             # Use my colour scheme
          colsep = c(1), 
          main = "Difference between proteins",
          margins = c(8, 5),
          offsetRow = 1,
          keysize = 2,
          cexRow = 0.5, cexCol = 0.75)  # Amend row and column label fonts

rm(list = ls())
############################################################
## genechip data examples

source("https://bioconductor.org/biocLite.R")
biocLite("affy") 
library(affy)
data(SpikeIn)
pms <- SpikeIn@pm
str(pms)
class(pms)
# just the data, scaled across rows
par(cex.main = 0.75)  
labs <- colnames(pms)
heatmap.2(pms, 
          col = rev(heat.colors(16)), 
          main = "SpikeIn@pm",
          xlab = "Relative Concentration", 
          ylab="Probeset",
          trace = "none",
          labCol = "",
          add.expr = text( x = seq_along(labs), y = -2, srt = 45,
                           labels = labs, xpd = TRUE),
          scale="row")

rm(list = ls())
##########################################################################
# extra ideas
# https://stackoverflow.com/questions/15505607/diagonal-labels-orientation-on-x-axis-in-heatmaps

library(grid)    
# pretty heatmaps
install.packages("pheatmap")
library(pheatmap)

## Your data
set.seed(100)
d <- matrix(rnorm(25), 5, 5)
colnames(d) <- paste("Treatment", 1:5, sep = "")
rownames(d) <- paste("Gene", 1:5, sep = "")

## Edit body of pheatmap:::draw_colnames, customizing it to your liking
## For pheatmap_1.0.8 and later:
draw_colnames_45 <- function (coln, gaps, ...) {
  coord <- pheatmap:::find_coordinates(length(coln), gaps)
  x <- coord$coord - 0.5 * coord$size
  res <- textGrob(coln, x = x, y = unit(1, "npc") - unit(3,"bigpts"), 
                  vjust = 0.5, hjust = 1, rot = 45, gp = gpar(...))
  return(res)
}

## 'Overwrite' default draw_colnames with your own version 
assignInNamespace(x = "draw_colnames", 
                  value = "draw_colnames_45",
                  ns = asNamespace("pheatmap"))

## Try it out
pheatmap(d, 
         main = "Pretty heatmap",
         cellwidth =  50,
         cellheight = 30,
         fontsize = 12)

rm(list = ls())
####################################################
# URL: https://www.bioconductor.org/packages/devel/bioc/vignettes/ComplexHeatmap/inst/doc/s2.single_heatmap.html

# Step 1 
#source("https://bioconductor.org/biocLite.R")
#biocLite("ComplexHeatmap") 
library(ComplexHeatmap)
#install.packages("circlize")
library(circlize)

set.seed(123)

mat <- cbind(rbind(matrix(rnorm(16, -1), 4), matrix(rnorm(32, 1), 8)),
            rbind(matrix(rnorm(24, 1), 4), matrix(rnorm(48, -1), 8)))

#Step 2 - munging
# permute the rows and columns
mat <- mat[sample(nrow(mat), nrow(mat)), sample(ncol(mat), ncol(mat))]

rownames(mat) <- paste0("R", 1:12)
colnames(mat) <- paste0("C", 1:10)

# Step 3- make a heatmap
?Heatmap
Heatmap(mat)
dev.off()

Heatmap(mat, 
        col = colorRamp2(c(-3, 0, 3), c("brown", "white", "yellow")), 
        cluster_rows = FALSE, 
        cluster_columns = FALSE,
        heatmap_legend_param = list(title = "Values"))
dev.off()

Heatmap(mat, 
        col = colorRamp2(c(-3, 0, 3), c("brown", "white", "yellow")), 
        heatmap_legend_param = list(title = "Values"))
dev.off()

mat_with_na <- mat
mat_with_na[sample(c(TRUE, FALSE), nrow(mat)*ncol(mat), replace = TRUE, prob = c(1, 9))] <- NA
Heatmap(mat_with_na, 
        col = topo.colors(100),
        na_col = "orange", 
        clustering_distance_rows = "pearson",
        heatmap_legend_param = list(title = "Values"))

dev.off()

Heatmap(mat, 
        name = "values", 
        row_names_side = "left", 
        row_dend_side = "right", 
        column_names_side = "top", 
        column_dend_side = "bottom")

dev.off()

Heatmap(mat, 
        name = "values", 
        row_names_side = "left", 
        row_dend_side = "right", 
        column_names_side = "top", 
        column_dend_side = "bottom",
        km = 2)

dev.off()

h1 <- Heatmap(mat, 
        name = "values", 
        #col = topo.colors(50),
        color_space = "sRGB",
        row_dend_width = unit(2, "cm"),
        column_dend_height = unit(2, "cm"),
        row_dend_reorder = TRUE,
        column_dend_reorder = TRUE,
        row_names_gp = gpar(fontsize = 8),
        column_names_gp = gpar(fontsize = 7),
        column_names_max_height = unit(2, "cm"),
        row_names_max_width = unit(9, "cm"),
        column_title = "This a complex heatmap")
draw(h1, heatmap_legend_side = "left")

dev.off()
