library(shiny)
library(ggplot2)
# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)
run_event=read.table("run_event.csv")
run_event$year = rep("YYYY", length(run_event$date))
run_event[grep("2013", run_event$file_id),]$year = 2013
run_event[grep("2014", run_event$file_id),]$year = 2014 
metrics = c("distance", "speed", "time", "totalcal")

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Running App"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("year", "Year:", 
                    choices=unique(run_event$year)),
        selectInput("month", "Month:", 
                    choices=as.character(unique(run_event$month))),
        selectInput("metric", "Metric:", 
                    choices=metrics),
        hr(),
        p(em("Documentation:",a("Running App",href="index.html"))),
        helpText("This application will select display running data from a GPS file. The data set is composed of run data from multiple years and months. 
                 The Steps: \n
                 1. Choose Year \n
                 2. Choose Month \n
                 3. Choose Metric.\n
                 4. Run Run Run")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("runPlot"), 
        tableOutput("runTable")
      )
      
    )
  )
)
