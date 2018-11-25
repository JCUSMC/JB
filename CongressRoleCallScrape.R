#Loading the XML package
install.packages('XML')
library('XML')

#Specifying the url for desired website to be scrapped
url <- "http://clerk.house.gov/evs/2017/roll198.xml"
xmldoc <- xmlParse(url)
rootNode <- xmlRoot(xmldoc)
rootNode[1]

xmlName(rootNode)
names(rootNode[[1]])

congress = xmlSApply(rootNode[[1]][["congress"]], xmlValue)
session = xmlSApply(rootNode[[1]][["session"]], xmlValue)
vote_desc = xmlSApply(rootNode[[1]][["vote-desc"]], xmlValue)
majority = xmlSApply(rootNode[[1]][["majority"]], xmlValue)
chamber = xmlSApply(rootNode[[1]][["chamber"]], xmlValue)
rollcall = xmlSApply(rootNode[[1]][["rollcall-num"]], xmlValue)



vote_data = xmlSApply(rootNode[[2]][["recorded-vote"]], xmlValue)
vote_data

# Read and transpose all of the "recorded-vote" child node values
all = t(xmlSApply(rootNode[[2]], function(x) xmlSApply(x,xmlValue)))
# Convert Columns to data frame
leg_vote1 = as.data.frame(all[,1], row.names = NULL)
leg_vote2 = as.data.frame(all[,2], row.names = NULL)
unique(leg_vote2)
# Aye = 1, No = 0, Not Voting = 0
leg_vote3 = ifelse(leg_vote2 == "Aye",1,0)


# create dataset and assign column names
leg_vote = cbind(congress,session,rollcall,legislator=leg_vote1,vote=leg_vote2)
colnames(leg_vote) = c('congress','session','rollcall','legislator','vote')
leg_vote
unique(leg_vote[,5])

