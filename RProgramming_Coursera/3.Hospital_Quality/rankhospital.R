rankhospital <- function(state, outcome, num = "best") ## Read outcome data
{ 
        result <- c()
        outcomeIdx <- 0
        
        ## Check that state and outcome are valid
        mainData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        validOutcome <- c("heart attack", "heart failure", "pneumonia")
        
        if(!state %in% mainData$State)
        {
                stop('invalid state')                
        }
        if(!outcome %in% validOutcome)
        {
                stop('invalid outcome')               
        }

        ## Return hospital name in that state with the given rank ## 30-day death rate
        mainData <- mainData[mainData$State == state,]
        
        if(outcome == "heart attack")           outcomeIdx <- 11
        else if(outcome == "heart failure")     outcomeIdx <- 17
        else                                    outcomeIdx <- 23
        
        mainData[,outcomeIdx] <- suppressWarnings(as.numeric(mainData[,outcomeIdx]))
        mainDataOrder <- order(mainData[[outcomeIdx]], mainData$Hospital.Name, na.last = NA)
        mainData <- mainData[mainDataOrder,]
        
        
        if(num == "best")               result <- (mainData$Hospital.Name)[1]
        else if(num == "worst")         result <- (mainData$Hospital.Name)[length(mainData$Hospital.Name)]
        else                            result <- (mainData$Hospital.Name)[num]
        
        result
}
