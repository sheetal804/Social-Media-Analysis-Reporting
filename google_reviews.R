library(rvest)
library(RSelenium)
library(stringi)
url<-"https://www.google.co.in/search?q=aahana+resort+jim+corbett+park&oq=aahana+resort+jim+corbett+park&aqs=chrome..69i57j0.5108j0j7&sourceid=chrome&ie=UTF-8"
tableout <- data.frame()
rd<-rsDriver(verbose = TRUE, browser = 'firefox', version = 'latest')
remDr<-rd$client
x<-remDr$navigate(url)
webElem<-remDr$findElement(using = "xpath","//span[contains(text(),'View Google reviews')]")
webclick<-webElem$clickElement()
page <- remDr$getPageSource()
review<-page[[1]] %>% read_html() %>% html_nodes("._ucl span")%>%html_text()
username<-page[[1]] %>% read_html() %>% html_nodes("._e8k")%>%html_text()
rate<-page[[1]] %>% read_html() %>% html_nodes("._pxg")%>%
  html_attr("aria-label")%>%
  html_text()
More<-remDr$findElement(using = "xpath","//span[contains(text(),'More')]")
webclick<-webElem$clickElement()

