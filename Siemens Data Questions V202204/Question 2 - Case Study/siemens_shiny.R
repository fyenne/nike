require(rCharts)
require(shiny)
require(data.table)
runApp(list(
  ui = mainPanel(fluidPage(
    fluidRow(
      column(width=12, 
             showOutput("chart2", "Highcharts"),
             showOutput("chart3", "Highcharts")
      ),
      fluidRow(
        column(width=6, 
               showOutput("chart4", "Highcharts") 
        )
      )
    )
  )),
  server = function(input, output){
    output$chart3 <- renderChart({
      a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", title = "Zoom demo", subtitle = "bubble chart", size = "Age", group = "Exer")
      a$chart(zoomType = "xy")
      a$chart(backgroundColor = NULL)
      a$set(dom = 'chart3')
      return(a)
    })
    output$chart2 <- renderChart({
      survey <- as.data.table(MASS::survey)
      freq <- survey[ , .N, by = c('Sex', 'Smoke')]
      a <- hPlot(x = 'Smoke', y = 'N', data = freq, type = 'column', group = 'Sex')
      a$chart(backgroundColor = NULL)
      a$set(dom = 'chart2')
      return(a)
    })
    output$chart4 <- renderChart({
      survey <- as.data.table(MASS::survey)
      freq <- survey[ , .N, by = c('Smoke')]
      a <- hPlot(x = "Smoke", y = "N", data = freq, type = "pie")
      a$plotOptions(pie = list(size = 150))
      a$chart(backgroundColor = NULL)
      a$set(dom = 'chart4')
      return(a)
    })
  }
))