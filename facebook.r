library(rvest)
library(RSelenium)
library(stringi)
tableout <- data.frame()
url<-"https://www.facebook.com/pg/AahanaresortCorbett/reviews/"
rd<-rsDriver(verbose = TRUE, browser = 'firefox', version = 'latest')
remDr<-rd$client
remDr$navigate(url)
while(1){
  Sys.sleep(20)
  page <- remDr$getPageSource()
  username<-page[[1]] %>% 
    read_html()%>%
    html_nodes(".fwb")%>%
  html_text()
  rate<-url%>%
    read_html()%>%
    html_nodes("._51mq")%>%
    html_text()
  rev<-page[[1]] %>% 
    read_html()%>%
    html_nodes("._5pbx")%>%
    html_text()
  date<-page[[1]] %>% 
    read_html()%>%
    html_nodes(".timestampContent")%>%
    html_text()
  temp.tableout <- data.frame(username,date,rev,rate) 
  
  tableout <- rbind(tableout,temp.tableout)
}