#Loading the rvest package
install.packages('XML')
library('XML')

#Specifying the url for desired website to be scrapped
url <- "http://clerk.house.gov/evs/2017/roll198.xml"
xmldoc <- xmlParse(url)
rootNode <- xmlRoot(xmldoc)
rootNode[1]

data <- xmlSApply(rootNode,function(x) xmlSApply(x, xmlValue))

cd.catalog <- data.frame(t(data),row.names=NULL)

cd.catalog[1:2,]