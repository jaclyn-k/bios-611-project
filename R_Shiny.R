
# Setup -------------------------------------------------------------------

install.packages("shiny");
rawdata <- read.csv("./NYC_Housing_Data.csv")

# RShiny Visualization ----------------------------------------------------

#UI
library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  titlePanel("NYC Housing Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 20,
                  value = 100)
    ),
    
    mainPanel(
      plotOutput(outputId = "distPlot")
      
    )
  )
)

#Server
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- rawdata$median_rent
    bins <- seq(min(x), max(x), length.out = input$bins)
    
    hist(x, breaks = bins, col = "blue", border = "white",
         xlab = "Median Rent Price",
         ylab = "Number of boros",
         main = "Histogram of Median Rent Prices in NYC Boros")
    
  })
}
# Start the Server
shinyApp(ui=ui, server=server, options=list(port=8080, host="0.0.0.0"))
