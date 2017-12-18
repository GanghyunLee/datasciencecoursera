problem <- 5

if(problem == 1)
{
        #install.packages("httpuv")
        library(httpuv)
        library(httr)
        
        # 1. Find OAuth settings for github:
        #    http://developer.github.com/v3/oauth/
        oauth_endpoints("github")
        
        # 2. To make your own application, register at 
        #    https://github.com/settings/developers. Use any URL for the homepage URL
        #    (http://github.com is fine) and  http://localhost:1410 as the callback url
        #    Replace your key and secret below.
        myapp <- oauth_app("lee308812_Test", "1b92e85a813c64794ec8", secret="f72d30eb74ccb1df16c024df78e8095c99c3ac0e")
        
        
        # 3. Get OAuth credentials
        github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
        
        # 4. Use API
        gtoken <- config(token = github_token)
        req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
        stop_for_status(req)

        # Problem : Find the time that the datasharing repo was created
        data <- content(req)
        result <- c()
        for(i in 1:length(data))
        {
                if(data[[i]]$name == "datasharing")
                {
                        result = (data[[i]])$created_at
                }
        }
        
        print(result)        
} else if(problem == 2) {
        # install.packages("sqldf")
        library(sqldf)
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "acs.csv")
        acs <- read.csv("acs.csv")
        
        sqldf("select pwgtp1 from acs where AGEP < 50")
} else if(problem == 3) {
        # install.packages("sqldf")
        library(sqldf)
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "acs.csv")
        acs <- read.csv("acs.csv")
        
        sqldf("select distinct AGEP from acs")
} else if(problem == 4) {
        con = url("http://biostat.jhsph.edu/~jleek/contact.html")
        htmlCode = readLines(con)
        close(con)
        
        targetLine <- c(10,20,30,100)
        print(nchar(htmlCode[targetLine]))
        
} else if(problem == 5) {
        # Fixed width file
        x <- read.fwf(
                file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
                skip=4,
                widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4)
        )
        
        print(sum(x$V4))
}

