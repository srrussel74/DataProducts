library(shiny) 

RandomDataXY<- function(N){
      X<- rnorm( N, runif(1,-20,20), runif(1,5,40) )
      Y<-X*runif(N, 0, 1) + rnorm(N,-runif(1,-20,20),runif(1,1,20))
      XY<-cbind(X,Y)
     return(XY)
      }

Answer<-function(S,D){
  if(S) return(abline(lm(D[,2]~D[,1]), col="green",lwd=1))
}

SD<-function(P,sl,int){
      return(sum((P[,2]-sl*P[,1]-int ) *(P[,2]-sl*P[,1]-int)))
}

UpdateMinimumLine<-function(Last, Now, InterceptLast, InterceptNow, SlopeLast, SlopeNow){
      min<<-format(ifelse(Last<=Now,Last,Now),nsmall=2)
      intc<<-ifelse(Last<=Now,InterceptLast,InterceptNow)
      sl<<-ifelse(Last<=Now,SlopeLast,SlopeNow)
     return(c(min,intc,sl))
}

min<-NULL
sl<-NULL
intc<-NULL

shinyServer(
  function(input, output) {       
        Data<-reactive({
                        input$goUpdate
                        isolate(return(RandomDataXY(input$number)))
        })

        SetMinimumLine<-reactive({
                          input$goUpdate
                          isolate(min<<-SD(Data(), input$slope, input$intercept))
                          isolate(sl<<-input$slope)
                          isolate(intc<<-input$intercept)
        })
    
       Minimum<-reactive({
          UpdateMinimumLine(min, SD(Data(), input$slope, input$intercept)
                            ,intc, input$intercept
                            ,sl,input$slope
                            )
        })
             
       output$setRandomDataXY<-renderPlot({
                                SetMinimumLine()
                                
                                plot(Data(), xlab="X",ylab="Y" )
                                
                                 abline(input$intercept,input$slope, col="red",lwd=5)
                                abline(Minimum()[2], Minimum()[3],col="grey",lwd=2)
                                Answer(input$answer,Data())
        })

       output$deviation<-renderText({
                              SD(Data(), input$slope, input$intercept)
       })
       
       output$min<-renderText({ Minimum()[1]  })
       output$line<-renderText({ 
            str<-paste0("coefficient: ", Minimum()[3], " and intercept: ", Minimum()[2])
            return(str)
            })
    }
  )