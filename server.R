library(shiny)
library(ggplot2)

run_event=read.table("run_event.csv")
run_event$year = rep("YYYY", length(run_event$date))
run_event[grep("2013", run_event$file_id),]$year = 2013
run_event[grep("2014", run_event$file_id),]$year = 2014 
metrics = c("Distance", "Speed", "Time", "Cal")

# Define a server for the Shiny app
shinyServer(function(input, output) {
   
  # Fill in the spot we created for a plot
  output$runPlot <- renderPlot({
    plot_data = run_event[as.numeric(run_event$year) == as.numeric(input$year) & as.character(run_event$month) == as.character(input$month), c("date", input$metric, "weekdays")]
    colnames(plot_data) = c("date", "chosen_metric", "weekdays")
    # Render a barplot
    ggplot(data=plot_data, 
           aes(x=as.factor(date), y=chosen_metric, fill=weekdays)) + 
      geom_bar(width=.7, stat="identity") + 
      xlab("Date") + ylab(input$metric) +
      ggtitle("A Punny Run App Running App") +
      theme(title = element_text(size=14), axis.text.x = element_text(angle=90, size=14),
            axis.text.y = element_text(size=14), legend.text = element_text(size=14))
  })
  
  output$runTable <- renderTable({
    table_names = c("date","starttime", "year", "month","weekdays", "time", "distance", "speed", "calperhr", "totalcal")
    run_event[as.numeric(run_event$year) == as.numeric(input$year) & as.character(run_event$month) == as.character(input$month),table_names]
  })
  
})
