#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to fit models and plot data and functions
shinyServer(function(input, output) {

  # one time part - NO reactive
  # load package and data,
  # fit model1 weight vs Time
  # fit model2 weight vs Time + Diet
  library(ggplot2)
  library(caret)
  data(ChickWeight)
  set.seed(3232)
  xmin<-min(ChickWeight$Time)
  xmax<-max(ChickWeight$Time)
  ymin<-min(ChickWeight$weight)
  ymax<-max(ChickWeight$weight)
  #qplot(Time,weight,data=ChickWeight,colour=Diet)
  gbase<-ggplot(ChickWeight,aes(x=Time,y=weight,colour=Diet))+geom_point()+coord_cartesian(xlim=c(xmin,xmax),ylim=c(ymin,ymax))
  plotobj<-gbase
  indextrain<-createDataPartition(y=ChickWeight$weight,p=0.75,list=FALSE)
  training<-ChickWeight[indextrain,]
  testing<-ChickWeight[-indextrain,]
  # fit model 1 weight vs Time
  model1<-train(weight ~ Time,data=training,method="lm")
  pred1<-predict(model1,ChickWeight)
  line1<-geom_line(aes(x=ChickWeight$Time,y=pred1,color="red"),size=1)
  plotobj<-plotobj+line1
  # fit model 2 weight vs Time + Diet
  model2<-train(weight ~ Time+Diet,data=training,method="glm")


  # reactive part
  output$basePlot <- renderPlot({

  plotobj

  })


  output$ODiet<-renderText(input$IDiet)

  output$DietPlot <- renderPlot({
    trainingD<-training[training$Diet==input$IDiet,]
    plotD<-ggplot(trainingD,aes(x=Time,y=weight,colour=Diet))+geom_point()+coord_cartesian(xlim=c(xmin,xmax),ylim=c(ymin,ymax))
    #pred2<-predict(model2,newdata=data.frame(Time=ChickWeight$Time,Diet=as.factor(1)))
    pred2<-predict(model2,trainingD)
    line2<-geom_line(aes(x=trainingD$Time,y=pred2,color="black"),size=1)
    plotD<-plotD+line2
    plotD

  })

})
