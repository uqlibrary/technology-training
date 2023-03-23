#%% Setting up

import seaborn as sns

tips = sns.load_dataset("tips")

tips

sns.set_theme(context = "talk", style = "ticks")

#%% Histograms

# Three types of plotting functions:
# - sns.relplot
# - sns.catplot
# - sns.displot

# Let's start with sns.displot()

sns.displot(data = tips,
            x = "total_bill",
            kind = "hist")

#%% Changing statistic

# - "count"
# - "frequency"
# - "probability"
# - "density"

sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability")

#%% Changing bin properties

sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability",
            bins = 50)

#%% Cumulative histogram

sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            stat = "probability",
            cumulative = True)

#%% Introducing another variable using hue

sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "hist",
            stat = "probability")

#%% Using multiple to change the overlay

sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "hist",
            stat = "probability",
            multiple = "stack")

#%% Using element to change the bin visualisation

sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "hist",
            stat = "probability",
            multiple = "stack",
            element = "poly")

#%% Overlaying a KDE

sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "hist",
            stat = "probability",
            multiple = "stack",
            element = "poly",
            kde = True)

#%% Creating KDE plots - Kernel Density Estimate

sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "kde") 

#%% Creating ECDF - Empirical Cumulative Distribution Functions

sns.displot(data = tips,
            x = "total_bill",
            hue = "time",
            kind = "ecdf") 


#%% Bivariate plots

sns.displot(data = tips,
            x = "total_bill",
            y = "tip",
            kind = "kde")

#%% Challenge 1: produce a histogram which examines the variable *tip* with 13 bins and introduces the variable *size* with hue. In addition, use the "stack" option for multiple variables *and* superimpose a kde distribution.

# Solution

sns.displot(data = tips,
            x = "tip",
            hue = "size",
            bins = 13,
            multiple = "stack",
            kde = True)

#%% Facets

# Here, we want to use the attributes
# - row =
# - col =

# First, let's make a scatter plot

sns.relplot(data = tips,
            x = "total_bill",
            y = "tip",
            kind = "scatter")

#%% Creating a column for each day

sns.relplot(data = tips,
            x = "total_bill",
            y = "tip",
            kind = "scatter",
            col = "day")

#%% Introducing smoker with hue

sns.relplot(data = tips,
            x = "total_bill",
            y = "tip",
            hue = "smoker",
            kind = "scatter",
            col = "day")

#%% Creating a row for each sex

sns.relplot(data = tips,
            x = "total_bill",
            y = "tip",
            hue = "smoker",
            kind = "scatter",
            col = "day",
            row = "sex")

#%% Pair plots

sns.pairplot(data = tips,
             hue = "time", # Two variables
             diag_kind = "hist") # Make histograms

#%% Joint plots

sns.jointplot(data = tips,
              x = "total_bill",
              y = "tip",
              hue = "smoker",
              kind = "hist")

#%% Challenge 2: Produce a group of histograms which examine the distribution of *total bill*. The group should separate the responses to *smoker* into columns and *time* into rows.

# Solution

sns.displot(data = tips,
            x = "total_bill",
            kind = "hist",
            col = "smoker",
            row = "time")

#%% Regressions

sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip")

#%% Include hue, col and row

sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           hue = "smoker",
           col = "day",
           row = "time")

#%% Change regression type

sns.lmplot(data = tips,
           x = "total_bill",
           y = "tip",
           logx = True)

#%% Plot the residuals

sns.residplot(data = tips,
              x = "total_bill",
              y = "tip")


#%% Categorical plot

sns.catplot(data = tips,
            x = "total_bill",
            kind = "box")

#%% Multiple plots for different variables

sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            kind = "box")

#%% Introduce hue

sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            hue = "smoker",
            kind = "box")

#%% Violin plots

sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            hue = "smoker",
            kind = "violin")

#%% Change the interior visualisation

sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            hue = "smoker",
            kind = "violin",
            inner = None)

#%% Swarm plots

sns.catplot(data = tips,
            x = "total_bill",
            y = "day",
            kind = "swarm")

#%% Challenge 3: Produce the shown plot

# Solution

sns.catplot(data = tips,
            x = "size",
            y = "total_bill",
            palette = "crest",
            kind = "violin")

#%% Extension to challenge 3: swapping the axes

sns.catplot(data = tips,
            y = "size",
            x = "total_bill", # Swap axes
            palette = "crest",
            kind = "violin", 
            orient = "h",
            order = [6,5,4,3,2,1]) # Make y categorical

#%% Use pandas to automatically find the correct order

import pandas as pd

myOrder = sorted(pd.unique(tips["size"]), reverse = True)

sns.catplot(data = tips,
            y = "size",
            x = "total_bill", # Swap axes
            palette = "crest",
            kind = "violin", 
            orient = "h",
            order = myOrder) # Make y categorical

#%% Conclusion

# Today we looked at
# - Cells (#%%)
# - Distributive plots (sns.displot())
# - Facetting (col = and row = )
# - Regressions (sns.lmplot())
# - Categorical plots (sns.catplot())


