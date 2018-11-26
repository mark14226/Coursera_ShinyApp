#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Differential Expression Tools"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        numericInput("Magnitude", "What Fold Change is considered Relevant?",
                     value=1.2, 
                     min=1, 
                     max=100, 
                     step=0.01),
        sliderInput("Significance",
                "-log10(adjusted p-value)",
                min = -log10(1),
                max = -log10(1e-300),
                value = -log10(0.05))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h3("Volcano Plot: Differential Expression Upon Androgen Exposure"),
        plotOutput("Volcano"),
        h2("Number of upregulated genes"),
        textOutput("DEGsUP"),
        h2("Number of downregulated genes"),
        textOutput("DEGsDOWN")
    )
  )
))
