getMaint <- function(x){
  return(packageDescription(x)$Maintainer)
}

getAuth <- function(x){
  return(packageDescription(x)$Author)
}

nicePrint   <- function(x, N = 10){
  tmpTable    <- head(sort(table(x), decreasing = TRUE), N)
  tmpTable    <- as.data.frame(tmpTable)
  colnames(tmpTable) = "count"
  return(tmpTable)
}

vPkgs <- installed.packages()[,"Package"]
install.packages("sportsdataverse", repos = c("https://sportsdataverse.r-universe.dev", getOption("repos")))
listA   <- mapply(getAuth, vPkgs)
listM   <- mapply(getMaint, vPkgs)

nicePrint(listA)
nicePrint(listM)
