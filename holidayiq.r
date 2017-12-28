library(rvest)
library(RSelenium)
library(stringi)
tableout <- data.frame()
urlnew<-"http://www.holidayiq.com/Aahana-Resort-Corbett-hotel-424553.html"
rd<-rsDriver(verbose = TRUE, browser = 'firefox', version = 'latest')
remDr<-rd$client
remDr$navigate(urlnew)

  page <- remDr$getPageSource()
  url<-page[[1]]

quote<-url%>%
  read_html()%>%
  html_nodes(".deatil-hotel-comment a")%>%
  html_text()
name<-url%>%
  read_html()%>%
  html_nodes(".traveller_name")%>%
  html_text()
place<-url%>%
  read_html()%>%
  html_nodes(".detail-video-city")%>%
  html_text()
review<-url%>%
  read_html()%>%
  html_nodes(".detail-posted-txt p")%>%
html_text()

date<-url%>%
  read_html()%>%
  html_nodes(".detail-posted")%>%
  html_text()

library(xlsx) #load the package
write.xlsx(sample,"tt.xlsx")
