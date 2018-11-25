#Loading the rvest package
install.packages('XML')
library('XML')

#Specifying the url for desired website to be scrapped
url <- "http://clerk.house.gov/evs/2017/roll198.xml"
xmldoc <- xmlParse(url)
rootNode <- xmlRoot(xmldoc)
rootNode[1]

xmlName(rootNode)
names(rootNode[[2]])

congress = xmlSApply(rootNode[[1]][["congress"]], xmlValue)
congress
session = xmlSApply(rootNode[[1]][["session"]], xmlValue)
session
vote_desc = xmlSApply(rootNode[[1]][["vote-desc"]], xmlValue)
vote_desc
vote_totals = xmlSApply(rootNode[[1]][["vote-totals"]], xmlValue)
vote_totals
vote_result = xmlSApply(rootNode[[1]][["vote-result"]], xmlValue)
vote_result

vote_data = xmlSApply(rootNode[[2]][["recorded-vote"]], xmlValue)
vote_data

# Read and transpose all of the "recorded-vote" child node
all = t(xmlSApply(rootNode[[2]], function(x) xmlSApply(x,xmlValue)))
leg_vote = all[,2:3]
leg_vote

x = xmlSApply(rootNode[[2]], xmlValue)
x
