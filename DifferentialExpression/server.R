#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$Volcano <- renderPlot({
    
    # Load DEG output from DESeq2
    data <- read.csv("DEGs_LNCaP-DHT_VS_LNCaP-EtOH.csv", row.names=1)

    
    # Generate Volcano Plot
    plot(data$log2FoldChange,
         -log10(data$padj),
         main = "Volcano Plot",
         ylab = "-Log10(adj.P-value)",
         xlab = "Log2(Fold Change)",
         cex.axis = 2,
         type = "n")
    points(data$log2FoldChange[abs(data$log2FoldChange) <= log2(input$Magnitude) | -log10(data$padj) <= input$Significance], -log10(data$padj[abs(data$log2FoldChange) <= log2(input$Magnitude) | -log10(data$padj) <= input$Significance]), col = rgb(0,0,0,0.5), pch = 1)
    points(data$log2FoldChange[abs(data$log2FoldChange) > log2(input$Magnitude) & -log10(data$padj) > input$Significance], -log10(data$padj[abs(data$log2FoldChange) > log2(input$Magnitude) & -log10(data$padj) > input$Significance]), col = rgb(0.7,0.3,0.0,0.3), pch = 16)
    
    abline(h = input$Significance, lty = 3)
    abline(v = log2(input$Magnitude), lty = 3)
    abline(v = -log2(input$Magnitude), lty = 3)
    
    })
  
  
  # Determine number of upregulated DEGs
  output$DEGsUP <- renderText({
      # Load DEG output from DESeq2
      data <- read.csv("DEGs_LNCaP-DHT_VS_LNCaP-EtOH.csv", row.names=1)
      
      dim(data[data$log2FoldChange > log2(input$Magnitude) & -log10(data$padj) > input$Significance ,])[1]
  })
  
  # Determine number of downregulated DEGs
  output$DEGsDOWN <- renderText({
      # Load DEG output from DESeq2
      data <- read.csv("DEGs_LNCaP-DHT_VS_LNCaP-EtOH.csv", row.names=1)
      
      dim(data[data$log2FoldChange < -log2(input$Magnitude) & -log10(data$padj) > input$Significance ,])[1]
  })
  
})
