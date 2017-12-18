problem <- "API"

if(problem == "MySQL") {
        ########### (1) MySQL
        
        library(RMySQL)
        
        hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
        
        allTables <- dbListTables(hg19)
        
        query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
        affMis <- fetch(query, n=10)
        
        print(quantile(affMis$misMatches))
        
        dbClearResult(query)
        
        dbDisconnect(hg19)   
        
} else if(problem == "HDF5") {
        ########### (2) HDF5
        
        source("http://bioconductor.org/biocLite.R") # To Install the package
        biocLite("rhdf5")
        
        ######################################################################
        ## Create File
        ######################################################################
        library(rhdf5)
        created = h5createFile("example.h5")
        created = h5createGroup("example.h5", "foo")
        created = h5createGroup("example.h5", "baa")
        created = h5createGroup("example.h5", "foo/foobaa")
        #print(h5ls("example.h5"))
        #  group   name     otype dclass dim
        #0     /    baa H5I_GROUP           
        #1     /    foo H5I_GROUP           
        #2  /foo foobaa H5I_GROUP
        
        ######################################################################
        ## Write to groups
        ######################################################################
        A = matrix(1:10, nr=5, nc=2)
        h5write(A, "example.h5", "foo/A")
        B = array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2))
        attr(B, "scale") <- "liter" # set attribute(sort of about the units)
        h5write(B, "example.h5", "foo/foobaa/B")
        #print(h5ls("example.h5"))
        #        group   name       otype  dclass       dim
        #0           /    baa   H5I_GROUP                  
        #1           /    foo   H5I_GROUP                  
        #2        /foo      A H5I_DATASET INTEGER     5 x 2
        #3        /foo foobaa   H5I_GROUP                  
        #4 /foo/foobaa      B H5I_DATASET   FLOAT 5 x 2 x 2
        
        ######################################################################
        ## Write data.frame to groups
        ######################################################################
        df = data.frame(1L:5L, seq(0,1,length.out=5), c("ab", "cde", "fghi", "a", "s"), stringAsFactors=FALSE)
        h5write(df, "example.h5", "df")
        print(h5ls("example.h5"))
        #        group   name       otype   dclass       dim
        #0           /    baa   H5I_GROUP                   
        #1           /     df H5I_DATASET COMPOUND         5
        #2           /    foo   H5I_GROUP                   
        #3        /foo      A H5I_DATASET  INTEGER     5 x 2
        #4        /foo foobaa   H5I_GROUP                   
        #5 /foo/foobaa      B H5I_DATASET    FLOAT 5 x 2 x 2

        ######################################################################
        ## Read H5 Data
        ######################################################################
        readA = h5read("example.h5", "foo/A")
        readB = h5read("example.h5", "foo/foobaa/B")
        readdf = h5read("example.h5", "df")
        print(readdf)
        #X1L.5L seq.0..1..length.out...5. c..ab....cde....fghi....a....s..
        #1      1                      0.00                                2
        #2      2                      0.25                                3
        #3      3                      0.50                                4
        #4      4                      0.75                                1
        #5      5                      1.00                                5
        
        ######################################################################
        ## Writing and reading chunks
        ######################################################################
        h5write(c(12,13,14), "example.h5", "foo/A", index=list(1:3,1))
        print(h5read("example.h5", "foo/A"))
        #     [,1] [,2]
        #[1,]   12    6
        #[2,]   13    7
        #[3,]   14    8
        #[4,]    4    9
        #[5,]    5   10

        # H5close()
} else if(problem == "Web") {
        ########### (3) Web - Programatically extracting data from the HTML Code
        
        con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
        htmlCode = readLines(con)
        close(con)
        #print(htmlCode) # very long html code...
        
        ######################################################################
        ## Parsing with XML
        ######################################################################   
        library(XML)
        url <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
        html <- htmlTreeParse(url, useInternalNodes=TRUE)
        
        print(xpathSApply(html, "//title", xmlValue))
        print(xpathSApply(html, "//td[@id='col-citedby']", xmlValue))
        
        ######################################################################
        ## GET from the httr package
        ######################################################################  
        library(httr)
        html2 = GET(url)
        content2 = content(html2, as="text")
        parsedHtml = htmlParse(content2, asText=TRUE)
        xpathSApply(parsedHtml, "//title", xmlValue)

        ######################################################################
        ## Accessing websites with password
        ######################################################################                  
        pg2 = GET("http://httpbin.org/basic-auth/user/passwd")
        #print(pg2)
        #Response [http://httpbin.org/basic-auth/user/passwd]
        #Date: 2017-12-13 12:54
        #Status: 401
        #Content-Type: <unknown>
        #        <EMPTY BODY>
        pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
        #print(pg2)
        #Response [http://httpbin.org/basic-auth/user/passwd]
        #Date: 2017-12-13 12:55
        #Status: 200
        #Content-Type: application/json
        #Size: 47 B
        #{
        #        "authenticated": true, 
        #        "user": "user"
        #}
        
        print(names(pg2))
        #[1] "url"         "status_code" "headers"     "all_headers" "cookies"     "content"    
        #[7] "date"        "times"       "request"     "handle"   
        
        ######################################################################
        ## Using handles to multiple access
        ######################################################################          
        google = handle("http://google.com")
        pg1 = GET(handle=google, path="/")
        pg2 = GET(handle=google, path="search")
} else if(problem == "API") {
        ########### (4) API (ex. Twitter)
}
