library(rvest)
library(RSelenium)
library(stringi)
#tableout <- data.frame()
travel1 <- data.frame()
username1 <- data.frame()
id1 <- data.frame()
quote1 <- data.frame()
review1 <- data.frame()
date1<-data.frame()
url<-"https://www.tripadvisor.in/Hotel_Review-g1152784-d3667315-Reviews-Aahana_the_Corbett_Wilderness-Jim_Corbett_National_Park_Nainital_District_Uttarakhand.html"
rd<-rsDriver(verbose = TRUE, browser = 'firefox', version = 'latest')
remDr<-rd$client
p<-5
x<-1:115
for ( i in 2:115)
{
  y<-toString(p)
  x[i]=paste("-or",y)
  p<-p+5
}
x[1]=""
x<-stri_replace_all_fixed(x, " ", "")

n<-length(x)
tableout <- data.frame()
k<-1
for(i in x){
  #url<-"https://www.tripadvisor.in/Hotel_Review-g1152784-d3667315-Reviews-Aahana_the_Corbett_Wilderness-Jim_Corbett_National_Park_Nainital_District_Uttarakhand.html#REVIEWS"
  url <- paste ("https://www.tripadvisor.in/Hotel_Review-g1152784-d3667315-Reviews",i,"-Aahana_the_Corbett_Wilderness-Jim_Corbett_National_Park_Nainital_District_Uttarakhand.html#REVIEWS",sep="")
  remDr$navigate(url)
  Sys.sleep(10)
  print("started scraping")
  print(i)
  #webElem<-remDr$findElement(using = "xpath","//span[contains(text(),'More')]")
  #webclick<-webElem$clickElement()
  page <- remDr$getPageSource()
  review<-page[[1]] %>% read_html() %>% html_nodes('.partial_entry') %>% html_text()
  travel<-page[[1]]%>%read_html()%>%
    html_nodes(".recommend-titleInline")%>%
    html_text()  
  
  user<-page[[1]]%>%read_html()%>%html_nodes("#REVIEWS .username")
  
  username <- user %>%
    html_node("span") %>%
    html_text()
  
  reviews<- page[[1]] %>%read_html()%>%
    html_nodes("#REVIEWS .innerBubble")
  
  id <- reviews %>%
    html_node(".quote a") %>%
    html_attr("id")
  
  quote <- reviews %>%
    html_node(".quote span") %>%
    html_text()
  
  date <- reviews %>%
    html_node(".rating .ratingDate") %>%
    html_attr("title") 
  
  #get rid of \n in reviews as this stands for 'enter' and is confusing dataframe layout
  reviewnospace <- gsub("\n", "", review)
  usernametemp<- data.frame(username) 
  username1 <- rbind(username1,usernametemp)
  
  datetemp<- data.frame(date) 
  date1 <- rbind(date1,datetemp)
  
  idtemp<- data.frame(id) 
  id1 <- rbind(id1,idtemp)
  
  quotetemp<- data.frame(quote) 
  quote1 <- rbind(quote1,quotetemp)
  
  reviewtemp<- data.frame(review) 
  review1 <- rbind(review1,reviewtemp)
  
  traveltemp<- data.frame(travel) 
  travel1 <- rbind(travel1,traveltemp)
  
  print("page loaded")
}

