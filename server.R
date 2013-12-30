
library(shiny)
library(zoo)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
  
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
	  
	g <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
	
		
	date <- strptime(g[,1], format= "%m/%d/%Y")
	g[,1] <-as.Date( format(date, format="%Y-%m-%d") )
	
	plot(zoo( g[,2],g[,1]), lwd=2 ,lty=1,main ="Spred" ,ylab="",xlab="Date")
	abline( h= mean(g[,2]),lty=5,col="green")
		
    })
	
	
	
	 formulaText1 <- reactive({
	 
	 inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
	  
	g <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
	 
	rt <- adf.test(g[,2], alternative="stationary") 
  
    paste("P-value of ADF test is",round(rt$p.value , digits = 5))
   
	
  })
  
    output$L1 <- renderText({
    formulaText1()
  })
  
  	 formulaText2 <- reactive({
	 
	 inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
	  
	g <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
	
	rt <- adf.test(g[,2], alternative="stationary") 
  
    if (rt$p.value < 0.05) {
    paste("The spread is likely mean-reverting")
    } else {
    paste("The spread is not mean-reverting")
    }
	
  })
  
	 output$L2 <- renderText({
    formulaText2()
  })
	
	
		
  output$contents <- renderTable({
  

    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)

	g <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
    date <- strptime(g[,1], format= "%m/%d/%Y")
	g[,1] <-as.Date( format(date, format="%Y-%m-%d") )
	zoo(g)
	
    })
})
