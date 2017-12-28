library(stringi)
library(rvest)
p<-5
x<-1:115
for ( i in 2:115)
{
  y<-toString(p)
  x[i]=paste("or",y)
  p<-p+5
}
x[1]=""
x<-stri_replace_all_fixed(x, " ", "")

n<-length(x)
tableout <- data.frame()

for(i in x){
  
  #Change URL address here depending on attraction for review
  url <- paste ("https://www.tripadvisor.in/Hotel_Review-g1152784-d3667315-Reviews-",i,"-Aahana_the_Corbett_Wilderness-Jim_Corbett_National_Park_Nainital_District_Uttarakhand.html#REVIEWS",sep="")
  
  user<-url%>%
    read_html()%>%
    html_nodes("#REVIEWS .username")
  
  username <- user %>%
    html_node("span") %>%
    html_text()
  
  reviews <- url %>%
    read_html() %>%
    html_nodes("#REVIEWS .innerBubble")
  
  id <- reviews %>%
    html_node(".quote a") %>%
    html_attr("id")
  
  quote <- reviews %>%
    html_node(".quote span") %>%
    html_text()
  review <- reviews %>%
    html_node(".entry .partial_entry") %>%
    html_text()
  date <- reviews %>%
    html_node(".rating .ratingDate") %>%
    html_attr("title") 
  
  #get rid of \n in reviews as this stands for 'enter' and is confusing dataframe layout
  reviewnospace <- gsub("\n", "", review)
  
  temp.tableout <- data.frame(username, id, date, quote,reviewnospace) 
  
  tableout <- rbind(tableout,temp.tableout)
  
}
write.csv(tableout,"TripReview.csv")
