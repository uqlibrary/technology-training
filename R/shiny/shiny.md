# R advanced: webapps with Shiny
UQ Library
2024-09-17

- [Shiny webapps](#shiny-webapps)
  - [Setting up](#setting-up)
  - [Create a new app](#create-a-new-app)
  - [Creating a minimal skeleton](#creating-a-minimal-skeleton)
  - [Prepare the data](#prepare-the-data)
  - [Interactive tables](#interactive-tables)
  - [Challenge 1: restore an “all months”
    option?](#challenge-1-restore-an-all-months-option)
  - [Theming](#theming)
  - [Challenge 2: make the plot
    interactive](#challenge-2-make-the-plot-interactive)
- [Publishing a Shiny app](#publishing-a-shiny-app)
- [Useful links](#useful-links)

## Shiny webapps

Shiny is a package that allows to create a web application with R code.

A Shiny app requires two main elements:

- a user interface (UI)
- a server

Let’s build an app from scratch, using our ACORN data and functions.

What we want to create is a small webapp that visualises Australian
temperature data and gives the user a bit of control over the
visualisation.

### Setting up

#### Base project

We will first download our base project that contains custom functions
to get our data ready.

- Download the [project
  archive](https://gitlab.com/stragu/DSH/-/archive/master/DSH-master.zip?path=R/packaging),
  and extract it wherever you’d like to store your project.
- Open the .Rproj file
- Create a new script: “New File \> R Script”

#### Get the data

We can source our custom functions that make it easier for us to
download the ACORN data and merge all the datasets into one big file:

``` r
source("get_acorn.R")
source("read_station.R")
source("merge_acorn.R")
get_acorn("acorn_data")
library(tidyverse)
all_stations <- merge_acorn("acorn_data")
```

We now have a single object that contains data from 112 weather stations
around Australia.

### Create a new app

In our project, let’s create a new app with “File \> New File \> Shiny
Web App…”. We will stick to “single file”, and the current project
directory as the location.

In our files, we can now see a “myApp” directory that contains an
“app.R” script.

The app is currently an example app. We can run it with the “Run App”
button, and you can see what kind of interaction a basic Shiny app can
offer: a slider to change the number of bins in a histogram, for
example.

### Creating a minimal skeleton

For our app to work, we need three sections:

- define a UI: what users see
- define a server: what happens in the background
- define how the app is run

Back in the app.R file, we can start with this empty skeleton:

``` r
# UI
ui <- fluidPage()

# Server
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
```

Running it will show a blank page. Let’s add a title:

``` r
# UI
ui <- fluidPage(
  titlePanel("ACORN data explorer")
)

# Server
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
```

### Prepare the data

Now, let’s make sure we have the data ready to be used in our app. We
don’t want to do the summarising of our data every time we run the app,
so let’s save the finished product into an RDS file. Back in our first
script, let’s write:

``` r
# process for monthly average
library(lubridate)
monthly <- all_stations %>% 
    group_by(month = month(date),
             year = year(date)) %>% 
    summarise(mean.max = mean(max.temp, na.rm = TRUE))
```

Let’s save that object our app directory, so the app can find it:

``` r
saveRDS(monthly, "myApp/monthly.rds")
```

This dataset will be the base of our Shiny app.

### Interactive tables

We can now read that data file into our app, process it, and present it
in an interactive table:

``` r
# Import data
monthly <- readRDS("monthly.rds")

# Define UI
ui <- fluidPage(
    titlePanel("ACORN data explorer"),
    dataTableOutput("dt")
)

# Define server logic
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

Notice that we had to define an output in the server section (with a
“render” function), and use that output in a UI function (with an
“output” function).

#### Plots

Now, for a different kind of output, let’s add a plot:

``` r
# Import data
monthly <- readRDS("monthly.rds")

# Load necessary packages
library(ggplot2)

# Define UI
ui <- fluidPage(
    titlePanel("ACORN data explorer"),
    plotOutput("plot"),
    dataTableOutput("dt")
)

# Define server logic
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
    
    output$plot <- renderPlot({
            ggplot(monthly,
               aes(x = year, y = month, fill = mean.max)) +
            geom_tile() +
            scale_fill_distiller(palette = "RdYlBu")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

Again, we have to:

- Define how the plot is generated on the server
- Save the plot as an output, using the right `render*` function
- Show the plot in the UI with the right `*Output` function

#### User input

How can we add some interaction? We could give the user control over
which month they want to visualise by adding a slider:

``` r
# Import data
monthly <- readRDS("monthly.rds")

# Load necessary packages
library(ggplot2)
library(dplyr)

# Define UI
ui <- fluidPage(
    titlePanel("ACORN data explorer"),
    # input slider for months
    sliderInput("month",
                "Pick a month:",
                min = 1,
                max = 12,
                value = 1),
    plotOutput("plot"),
    dataTableOutput("dt")
)

# Define server logic
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
    
    output$plot <- renderPlot({
        monthly %>% 
            filter(month == input$month) %>% 
            ggplot(aes(x = year, y = month, fill = mean.max)) +
            geom_tile() +
            scale_fill_distiller(palette = "RdYlBu")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

### Challenge 1: restore an “all months” option?

How could we give the option to go back to the full-year view?

Hint: have a look at `?selectInput`, or find other ideas on this list:
https://shiny.rstudio.com/tutorial/written-tutorial/lesson3/

One solution could be:

``` r
# import data
monthly <- readRDS("monthly.rds")

# load necessary packages
library(ggplot2)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("ACORN data explorer"),
    # input slider for months
    selectInput("month",
                "Pick one or more months:",
                1:12,
                multiple = TRUE),
    plotOutput("plot"),
    dataTableOutput("dt")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
    
    output$plot <- renderPlot({
        monthly %>% 
            filter(month %in% input$month) %>% 
            ggplot(aes(x = year, y = month, fill = mean.max)) +
            geom_tile() +
            scale_fill_distiller(palette = "RdYlBu")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

### Theming

To change the theme of the app, we can use the bslib package, and change
the `theme` argument in `fluidPage()`:

``` r
# import data
monthly <- readRDS("monthly.rds")

# load necessary packages
library(ggplot2)
library(dplyr)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = bs_theme(bootswatch = "solar"),
    titlePanel("ACORN data explorer"),
    # input slider for months
    selectInput("month",
                "Pick one or more months:",
                1:12,
                multiple = TRUE),
    plotOutput("plot"),
    dataTableOutput("dt")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
    
    output$plot <- renderPlot({
        monthly %>% 
            filter(month %in% input$month) %>%
            ggplot(aes(x = year, y = month, fill = mean.max)) +
            geom_tile() +
            scale_fill_distiller(palette = "RdYlBu")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

You can see the different themes available with the
`bootswatch_themes()` function.

This is great to quickly change the general look of our app, but our
visualisation looks out of place: how can we also change the theme for
ggplot2? Let’s use the convenient thematic package:

``` r
# import data
monthly <- readRDS("monthly.rds")

# load necessary packages
library(ggplot2)
library(dplyr)
library(bslib)
library(thematic)
thematic_shiny()

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = bs_theme(bootswatch = "solar"),
    titlePanel("ACORN data explorer"),
    # input slider for months
    selectInput("month",
                "Pick one or more months:",
                1:12,
                multiple = TRUE),
    plotOutput("plot"),
    dataTableOutput("dt")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
    
    output$plot <- renderPlot({
        monthly %>% 
            filter(month %in% input$month) %>%
            ggplot(aes(x = year, y = month, fill = mean.max)) +
            geom_tile() +
            scale_fill_distiller(palette = "RdYlBu")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

Now, the theme propagates to ggplot2 visualisations.

### Challenge 2: make the plot interactive

Using the plotly package, how could you make the plot interactive?

Remember to change the code that generates the plot *as well as* the
render and output functions.

``` r
# import data
monthly <- readRDS("monthly.rds")

# load necessary packages
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(thematic)
thematic_shiny()

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = bs_theme(bootswatch = "solar"),
    titlePanel("ACORN data explorer"),
    # input slider for months
    selectInput("month",
                "Pick one or more months:",
                1:12,
                multiple = TRUE),
    plotlyOutput("plot"),
    dataTableOutput("dt")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$dt <- renderDataTable({
        monthly
    })
    
    output$plot <- renderPlotly({
        p <- monthly %>% 
            filter(month %in% input$month) %>%
            ggplot(aes(x = year, y = month, fill = mean.max)) +
            geom_tile() +
            scale_fill_distiller(palette = "RdYlBu")
        ggplotly(p)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
```

The user can now hover over parts of the plot to see the corresponding
data.

## Publishing a Shiny app

You can use ShinyApps.io, which offers free or paid accounts.

We also have access to Nectar (National eResearch Collaboration Tools
and Resources project), in which we can request a virtual machine and
deploy a Shiny server: https://nectar.org.au/

## Useful links

- Official Shiny tutorial: https://shiny.rstudio.com/tutorial/
- Shiny examples:
  - https://shiny.rstudio.com/gallery/
  - https://www.showmeshiny.com/
- Shiny cheatsheet:
  https://github.com/rstudio/cheatsheets/raw/master/shiny.pdf
