#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)



#####Import Data

## url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"


## setwd("C://Users/JamesK//OneDrive//Documents//Data//Shinyapp//Shinyapp")

dat<-read_csv("cces_sample_coursera.csv")
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)






ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput("my_party",
                  
                  "Select Five Point Ideology (1 = Very liberal, 5 = Very conservative", 
                  
                  value = 1, 
                  
                  min = 1, 
                  
                  max = 5)), 
    
    
    
    mainPanel(
      
      plotOutput("partyPlot") 
      
    )
    
  )
  
)

server <- function(input, output) {
  
  
  
  output$partyPlot <- renderPlot({
    
    
    dat %>% filter(ideo5==input$my_party) %>%
      ggplot(dat, mapping = aes(x = pid7, 
                                
                                group = ideo5)) + 
      
      geom_bar() + 
      
      xlab("7 Point Party ID, 1 = Very D, 7 = Very R")  + 
      ylab ("Count") +
      xlim(0,8)
    
  })
  
}


shinyApp(ui = ui, server = server)

