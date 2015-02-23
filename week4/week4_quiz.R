install.packages("quantmod")
packages <- c("data.table", "quantmod")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

setInternet2(TRUE)

# Week 3

# Problem 1
f <- file.path(getwd(), "getdata-data-ss06hid.csv")
dt <- data.table(read.csv(f))
varNames <- names(dt)
varNamesSplit <- strsplit(varNames, "wgtp")
varNamesSplit[[123]]

# Problem 2
f <- file.path(getwd(), "getdata-data-GDP.csv")
dt <- data.table(read.csv(f))
dtGDP <- data.table(read.csv(f, skip=4, nrows=215, stringsAsFactors=FALSE))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))
mean(gdp, na.rm=TRUE)

# Problem 3
isUnited <- grepl("^United", dtGDP$Long.Name)
summary(isUnited)

# Problem 4
f <- file.path(getwd(), "getdata-data-EDSTATS_Country.csv")
dt <- data.table(read.csv(f))
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
dt[isFiscalYearEnd & isJune, Special.Notes]

# Problem 5
library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn) 
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))