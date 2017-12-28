library(rvest)
library(RSelenium)
library(stringi)
tableout <- data.frame()
url<-"https://www.makemytrip.com/hotels/aahana_the_corbett_wilderness-details-corbett.html"
rd<-rsDriver(verbose = TRUE, browser = 'firefox', version = 'latest')
remDr<-rd$client
remDr$navigate(url)
while(1){
Sys.sleep(20)
page <- remDr$getPageSource()
review<-page[[1]] %>% read_html() %>% html_nodes('.user_comment') %>% html_text()

t<-page[[1]]%>%
  read_html()%>%
  html_nodes(".reviewer_dels")

t1<-t%>%
html_nodes(".clearfix span")%>%
html_text()
rate<-1:5
profile<-1:5
p<-1
k<-1
for ( i in 1:10){
   if((i %% 2) == 0) {
    profile[k]=t1[i]
    k<-k+1
  } else {
    rate[p]=t1[i]
    p<-p+1
  }
  
  }
user<-page[[1]]%>%
  read_html()%>%
  html_nodes(".rev_name")%>%
  html_text()

revdate<-page[[1]]%>%
  read_html()%>%
  html_nodes(".rev_date")%>%
  html_text()

quote<-page[[1]]%>%
  read_html()%>%
  html_nodes(".loctn_txt")%>%
  html_text()

temp.tableout <- data.frame(user,revdate,quote,review,rate,profile) 

tableout <- rbind(tableout,temp.tableout)

print("page loaded")
}
#webElem <- remDr$findElement(using = 'class', 'morelink')
#webclick<-webElem$clickElement()
#Sys.sleep(1) 

test.html <- read_html(remDr$getPageSource()[[1]])
review<-test.html %>%
  html_nodes(".user_comment")%>%
  html_text()
i<-1
webElem <- remDr$findElement(value = '//a[@href = ",i,"]"')
webclick<-webElem$clickElement()
