# Load the necessary packages
library(boilrdata)
library(shiny)
library(dplyr)
library(forcats)
library(plotly)

#### UI ####
ui <- fluidPage(
  # Title
  titlePanel("Top families"),
  # Sidebar with a variable selector
  sidebarLayout(
    sidebarPanel(
      sliderInput("n_fam",
                  label = "Number of families",
                  min = 1, max = 12, value = 5)
    ),
    # Show the plot
    mainPanel(
      plotlyOutput("top_bars")
    )
  )
)

#### Server ####
server <- function(input, output) {
  
  output$top_bars <- renderPlotly({
    # get counts of 5 most common families
    top_5_fams <- bunyas$trees %>% 
      count(family, sort = TRUE) %>% 
      slice(1:input$n_fam)
    
    p_fams <- top_5_fams %>% 
      ggplot(aes(x = n,
                 y = fct_inorder(family), # order bars by frequency
                 fill = family)) + 
      geom_col() +
      guides(fill = "none") +
      labs(x ="count", y = "family") +
      theme_minimal()
    # see it
    p_fams
  })
}

#### Run the app ####
shinyApp(ui = ui, server = server, options = list(display.mode = "showcase"))