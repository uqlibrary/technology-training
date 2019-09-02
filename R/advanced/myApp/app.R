# import data
monthly <- readRDS("monthly.RDS")

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
