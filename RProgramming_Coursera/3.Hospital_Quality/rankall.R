rankall <- function(outcome, num = "best")
{
        result <- data.frame(hospital=character(), state=character(), stringsAsFactors=FALSE)
        outcomeIdx <- 0
        
        ## Read outcome data
        mainData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

        ## Check that state and outcome are valid
        ## Check that state and outcome are valid
        validOutcome <- c("heart attack", "heart failure", "pneumonia")
        
        if(!outcome %in% validOutcome)
        {
                stop('invalid outcome')               
        }

        ## For each state, find the hospital of the given rank
        if(outcome == "heart attack")           outcomeIdx <- 11
        else if(outcome == "heart failure")     outcomeIdx <- 17
        else                                    outcomeIdx <- 23        
        
        stateList <- unique(mainData$State)
        stateList <- stateList[order(stateList)]

        mainData[,outcomeIdx] <- suppressWarnings(as.numeric(mainData[,outcomeIdx]))
        
        # Split data
        mainData <- split(mainData, mainData$State)
        
        for (state in stateList)
        {
                subData <- mainData[[state]]
        
                subDataOrder <- order(subData[outcomeIdx], subData$Hospital.Name, na.last = NA)
                mainData[[state]] <- subData[subDataOrder,]      
        }
        
        ## Return a data frame with the hospital names and the ## (abbreviated) state name
        if(num == "best")
        {
                idx <- 1
                for (state in stateList)
                {
                        result[idx,] <- list( ((mainData[[state]])$Hospital.Name)[1], state )
                        idx <- idx + 1
                }
        }
        else if(num == "worst")
        {
                idx <- 1
                for (state in stateList)
                {
                        colIdx <- length((mainData[[state]])$Hospital.Name)
                        result[idx,] <- list( ((mainData[[state]])$Hospital.Name)[colIdx], state )
                        idx <- idx + 1
                }                
        }
        else
        {
                idx <- 1
                for (state in stateList)
                {
                        result[idx,] <- list( ((mainData[[state]])$Hospital.Name)[num], state )
                        idx <- idx + 1
                }                    
        }
        
        result
}
