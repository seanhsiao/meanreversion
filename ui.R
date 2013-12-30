

library(shiny)
library(tseries)

shinyUI(pageWithSidebar(
  headerPanel("Mean Reversion Analysis"),
  sidebarPanel(
    fileInput('file1', 'Choose CSV File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
    tags$hr(),
    checkboxInput('header', 'Header', TRUE),
    radioButtons('sep', 'Separator',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 'Comma'),
    radioButtons('quote', 'Quote',
                 c(None='',
                   'Double Quote'='"',
                   'Single Quote'="'"),
                 'Double Quote')
  ),
  mainPanel(
  
    plotOutput('distPlot'),
	h3(textOutput("L1")),
	h3(textOutput("L2")),
    tableOutput('contents')
  )
))
