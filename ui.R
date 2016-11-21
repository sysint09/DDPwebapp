#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that plots
shinyUI(fluidPage(

  # Application title
  titlePanel("Highlight different Chick Weight model by Diet"),

  # Sidebar with a slider input for diet type
  sidebarLayout(
    sidebarPanel(
       h4("Main goal"),
       p("Here you can see the scatter plot of ChickWeight data related to an
          experiment to analyze the growth of chicks along the time according to different diets.
          Main goal of this simple webapp is to highlight the different prediction function
          including or not Diet covariable.
          "),
       p("You can set the Diet type and see in first plot the prediction function and the
          related data."),
       sliderInput("IDiet",
                   "Select type of Diet",
                   min = 1,
                   max = 4,
                   value = 1),
       p("In the second plot you can see all the data and the prediction function that
          doesn't take into cosideration Diet covariable. "),
       br(),
       h4("Source code"),
       h5("Source code is available in my github repository:",
        a("https://github.com/sysint09/DDPwebapp",href="
        https://github.com/sysint09/DDPwebapp"))

    ),

    # Show a plot of the generated model
    mainPanel(
      h4("First Plot: weight vs Time + Diet"),
      h5("Selected Diet"),
      textOutput("ODiet"),
      plotOutput("DietPlot"),
      h4("Second Plot: weight vs Time"),
      plotOutput("basePlot")
    )
  )
))
