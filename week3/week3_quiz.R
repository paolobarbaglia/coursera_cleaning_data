packages <- c("data.table", "jpeg")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

setInternet2(TRUE)

# Week 3

# Problem 1
f <- file.path(getwd(), "getdata-data-ss06hid.csv")
dt <- data.table(read.csv(f))
agricultureLogical <- dt$ACR == 3 & dt$AGS == 6
which(agricultureLogical)[1:3]

# Problem 2
f <- file.path(getwd(), "getdata-jeff.jpg")
img <- readJPEG(f, native=TRUE)
quantile(img, probs=c(0.3, 0.8))

# Problem 3
f <- file.path(getwd(), "getdata-data-GDP.csv")
dtGDP <- data.table(read.csv(f, skip=4, nrows=215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

f <- file.path(getwd(), "getdata-data-EDSTATS_Country.csv")
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))

dt[order(rankingGDP, decreasing=TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]

# Problem 4
dt[, mean(rankingGDP, na.rm=TRUE), by=Income.Group]

# Problem 5
breaks <- quantile(dt$rankingGDP, probs=seq(0, 1, 0.2), na.rm=TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks=breaks)
dt[Income.Group == "Lower middle income", .N, by=c("Income.Group", "quantileGDP")]