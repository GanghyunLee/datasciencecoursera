best <- function(state, outcome)
{
        result <- c()
        outcomeIdx <- 0
        
        ## Read outcome data
        mainData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        validOutcome <- c("heart attack", "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if(!state %in% mainData$State)
        {
                stop('invalid state')
        }
        
        if(!outcome %in% validOutcome)
        {
                stop('invalid outcome')
        }
        
        ## Return hospital name in that state with lowest 30-day death
        if(outcome == "heart attack")           outcomeIdx <- 13
        else if(outcome == "heart failure")     outcomeIdx <- 19
        else                                    outcomeIdx <- 25
        ## rate
        mainData[,outcomeIdx] <- suppressWarnings(as.numeric(mainData[,outcomeIdx]))
        
        subData <- mainData[mainData[,"State"] == state, ]
        
        idx <- which(subData[,outcomeIdx] == min(subData[,outcomeIdx], na.rm = TRUE))
        
        # the hospital names should be sorted in alphabetical order and the ???rst hospital in that set should be chosen
        result <- subData[idx,"Hospital.Name"]
        resultIdx <- order(result)
        result[resultIdx[1]]
}


#best("NY", "pneumonia")
