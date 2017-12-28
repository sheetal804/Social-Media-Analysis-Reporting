library(ggplot2)
library(tm)
library(wordcloud)
library(syuzhet)
#review<-read.csv("TripReview.csv",header=T)
#t<-review$reviewnospac
t<-read.csv("TripReview.csv")
y<-t$reviewnospace
y2<-as.character(y)
docs<-Corpus(VectorSource(y2))

#trans<-content_transformer(function(x,pattern) gsub(pattern," ",x))
docs<-tm_map(docs,content_transformer(tolower))
docs<-tm_map(docs,removeNumbers)
docs<-tm_map(docs,removeWords,stopwords("english"))
docs<-tm_map(docs,removePunctuation)
docs<-tm_map(docs,stripWhitespace)
docs<-tm_map(docs,stemDocument)
dtm<-TermDocumentMatrix(docs)
mat<-as.matrix(dtm)
v<-sort(rowSums(mat),decreasing = TRUE)
d<-data.frame(word=names(v),freq=v)
head(d,10)
set.seed(1056)
wordcloud(words = d$word,freq = d$freq,min.freq = 1,max.words = 200,random.order=FALSE,rot.per = 0.35,colors = brewer.pal(8,"Dark2"))
sentiment<-get_nrc_sentiment(y2)

text<-cbind(y2,sentiment)
TotalSentiment<-data.frame(colSums(text[,c(2:11)]))
names(TotalSentiment)<-"count"
TotalSentiment<-cbind("sentiment"=rownames(TotalSentiment),TotalSentiment)
rownames(TotalSentiment)<-NULL
ggplot(data=TotalSentiment,aes(x=sentiment,y=count))+
geom_bar(aes(fill=sentiment),stat="identity")+
theme(legend.position = "none")+
xlab("sentiment")+ylab("Total count")+ggtitle("Total Sentiment Score")

