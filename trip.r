library(RSelenium)
library(rvest)
library(stringi)
rd <-rsDriver(verbose =TRUE, browser = 'firefox', version = "latest")
p<-5
x<-1:3
for ( i in 2:3)
{
  y<-toString(p)
  x[i]=paste("-or",y)
  p<-p+5
}
x[1]=""
x<-stri_replace_all_fixed(x, " ", "")

n<-length(x)
tableout <- data.frame()
URL<-1:3
k<-1
for(i in x){
  #url<-"https://www.tripadvisor.in/Hotel_Review-g1152784-d3667315-Reviews-Aahana_the_Corbett_Wilderness-Jim_Corbett_National_Park_Nainital_District_Uttarakhand.html#REVIEWS"
  url <- paste ("https://www.tripadvisor.in/Hotel_Review-g1152784-d3667315-Reviews",i,"-Aahana_the_Corbett_Wilderness-Jim_Corbett_National_Park_Nainital_District_Uttarakhand.html#REVIEWS",sep="")
  
  remDr <- rd$client
  remDr$navigate(url)
  webElem<-remDr$findElement(using = "xpath","//span[contains(text(),'More')]")
  webclick<-webElem$clickElement()
  test.html <- read_html(remDr$getPageSource()[[1]])
  review_sel<-test.html %>%
    html_nodes(".partial_entry") %>%
    html_text(trim=TRUE)
  #travel<-test.html%>%
   # html_nodes(".recommend-titleInline")%>%
    #html_text()
  
    user<-test.html%>%
    html_nodes("#REVIEWS .username")
  
    username <- user %>%
    html_node("span") %>%
    html_text()
  
    reviews <- test.html %>%
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
  reviewnospace <- gsub("\n", "", review_sel)
  
  temp.tableout <- data.frame(username, id, date, quote,reviewnospace) 
  
  tableout <- rbind(tableout,temp.tableout)
  
}
write.csv(tableout,"TripReview.csv")
