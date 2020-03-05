



###################
# LIBRARIES
###################
library (ggraph)
library(widyr)
library(textreadr)
library(tidyr)
library(scales)
library(tm)
library(dplyr)
library(tidyverse)
library(tidytext)
library(ggplot2)
library(textshape)
library(stringr)
library(readr)
library(ggplot2)
library(reshape2)
library(wordcloud)
###########################
#IMPORTING FILES
###########################

# Importing files 
SG_1 <- read_document(file="C:/Users/Carolina Duque/Documents/Hult Modules/MsBA/Text Analyst/Assignment/SG1_18-01-2019-16-09-2019.txt")
#View(SG_1)

SG_2 <- read_document(file="C:/Users/Carolina Duque/Documents/Hult Modules/MsBA/Text Analyst/Assignment/SG_07-02-2020 -17-09-2019.txt")

# Converting into data frame
SG1_df <- tibble(line=1:4256, text=SG_1) # tibble instead of DF


SG2_df <- tibble(line=1:3285, text=SG_2) # tibble instead of DF


# customizing stop words
cust_stop <- data_frame(word=c("chair","professor", "tijjani","muhammad", "bande",  "ladies", "gentlemen","dear","ms","maría","fernanda", "espinosa", "garcés",  "Excellencies", "united", "nations", "colleagues", "honour"),
                        lexicon = rep("cust", each=18))  

# added more words that were useless in the quad


#########################
# TOKENIZING
#########################

# Tokennizing data 
SG1_tidy <- SG1_df  %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>% 
  anti_join(cust_stop) 

SG2_tidy <- SG2_df  %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>% 
  anti_join(cust_stop)

View(SG2_tidy)
###############################
# TOKEN FREQUENCY
################################

#plotting the token frequencies for SG 1:

freq_hist <-SG1_tidy%>%
  count(word, sort=TRUE) %>%
  filter(n > 150) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n))+
  geom_col()+
  xlab(NULL)+
  coord_flip()
print(freq_hist)

ggsave('frequency_SG1.png')

# plotting the token frequencies for SG 2:
freq_hist_2 <-SG2_tidy%>%
  count(word, sort=TRUE) %>%
  filter(n > 150) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n))+
  geom_col()+
  xlab(NULL)+
  coord_flip()
print(freq_hist_2)

ggsave('frequency_SG2.png')


###########################
# CORRELOGRAMS
##########################

frequency <- bind_rows(mutate(SG1_tidy, author="SG1"),
                       mutate(SG2_tidy, author= "SG2")) %>% #closing bind_rows
  mutate(word=str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(author) %>%
  mutate(proportion = n/sum(n))%>%
  select(-n) %>%
  spread(author, proportion) %>%
  gather(author, proportion, `SG1`)

ggplot(frequency, aes(x=proportion, y=`SG2`, 
                      color = abs(`SG2`- proportion)))+
  geom_abline(color="grey40", lty=2)+
  geom_jitter(alpha=.1, size=2.5, width=0.3, height=0.3)+
  geom_text(aes(label=word), check_overlap = TRUE, vjust=1.5) +
  scale_x_log10(labels = percent_format())+
  scale_y_log10(labels= percent_format())+
  scale_color_gradient(limits = c(0,0.001), low = "darkslategray4", high = "gray75")+
  facet_wrap(~author, ncol=2)+
  theme(legend.position = "none")+
  labs(y= "SG2", x=NULL)

ggsave("corrologram.png")

#############################
#CORRELATION
##########################
cor.test(data=frequency[frequency$author == "SG1",],
         ~proportion + `SG2`)

##########################
#BIGRAMS
##########################

#Looking for units words (n grams) SG 1:
SG1_ng <- SG1_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
  count(bigram, sort = TRUE)

# removing stop words from ngrams 
SG1_ng <- SG1_ng %>%
  separate(bigram, c("word1", "word2"), sep = " ")

SG1_ng <- SG1_ng %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word1 %in% cust_stop$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(!word2 %in% cust_stop$word) %>%
  filter (n > 10)

View(SG1_ng)

#Looking for units words (n grams) SG 1:
SG2_ng <- SG2_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
  count(bigram, sort = TRUE)

# removing stop words from ngrams 
SG2_ng <- SG2_ng %>%
  separate(bigram, c("word1", "word2"), sep = " ")

SG2_ng <- SG2_ng %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word1 %in% cust_stop$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(!word2 %in% cust_stop$word) %>%
  filter (n > 10)

View(SG2_ng)
##########################
#QUADROGRAM
##########################

# quadrogram for SG 1


quadrogram_SG1 <- SG1_df %>%
  unnest_tokens(quadrogram, text, token = "ngrams", n=4) %>%
  separate(quadrogram, c("word1", "word2", "word3", "word4"), sep=" ") %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(!word3 %in% stop_words$word) %>%
  filter(!word4 %in% stop_words$word) %>%
  filter(!word1 %in%cust_stop$word) %>% 
  filter(!word2 %in%cust_stop$word) %>% 
  filter(!word3 %in%cust_stop$word) %>% 
  filter(!word4 %in%cust_stop$word) %>%
  count (word1, word2, word3, word4, sort=TRUE)

View(quadrogram_SG1)



quadrogram_SG2 <- SG2_df %>%
  unnest_tokens(quadrogram, text, token = "ngrams", n=4) %>%
  separate(quadrogram, c("word1", "word2", "word3", "word4"), sep=" ") %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(!word3 %in% stop_words$word) %>%
  filter(!word4 %in% stop_words$word) %>%
  filter(!word1 %in%cust_stop$word) %>% 
  filter(!word2 %in%cust_stop$word) %>% 
  filter(!word3 %in%cust_stop$word) %>% 
  filter(!word4 %in%cust_stop$word) # ask if i need to do this for all

View(quadrogram_SG2)


#########################
#CORROLOGRAMS FOR BIGRAM
#########################
frequency_ng <- bind_rows(mutate(SG1_ng, speech="SG1"),
                       mutate(SG2_ng, speech= "SG2")) %>% #closing bind_rows
  mutate(word=str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(speech) %>%
  mutate(proportion = n/sum(n))%>%
  select(-n) %>%
  spread(speech, proportion) %>%
  gather(speech, proportion, `SG1`)

ggplot(frequency, aes(x=proportion, y=`SG2`, 
                      color = abs(`SG2`- proportion)))+
  geom_abline(color="grey40", lty=2)+
  geom_jitter(alpha=.1, size=2.5, width=0.3, height=0.3)+
  geom_text(aes(label=word), check_overlap = TRUE, vjust=1.5) +
  scale_x_log10(labels = percent_format())+
  scale_y_log10(labels= percent_format())+
  scale_color_gradient(limits = c(0,0.001), low = "darkslategray4", high = "gray75")+
  facet_wrap(~author, ncol=2)+
  theme(legend.position = "none")+
  labs(y= "SG2", x=NULL)

######################
#Sentiment Analysis
######################

# sentiment analysis SG 1: 

get_sentiments('afinn') 

affin_SG1<- SG1_tidy %>%
  inner_join(get_sentiments("afinn"))%>%
  group_by(line) %>% 
  summarise(sentiment=sum(value)) %>%
  mutate(method="AFINN")


SG1_bing_and_nrc <- bind_rows(
  SG1_tidy%>%
    inner_join(get_sentiments("bing"))%>%
    mutate(method = "Bing et al."),
  SG1_tidy %>%
    inner_join(get_sentiments("nrc") %>%
                 filter(sentiment %in% c("positive", "negative"))) %>%
    mutate(method = "NRC")) %>%
  count(method, index=line %/% 80, sentiment) %>%
  spread(sentiment, n, fill=0) %>%
  mutate(sentiment = positive-negative)

bind_rows(affin_SG1, SG1_bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill=method))+
  geom_col(show.legend=FALSE)+
  facet_wrap(~method, ncol =1, scales= "free_y")

#Most common positive and negative words for SG 1: 

bing_counts <- SG1_tidy %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort=T) %>%
  ungroup()

bing_counts %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word=reorder(word, n)) %>%
  ggplot(aes(word, n, fill=sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y")+
  labs(y="Contribution to sentiment", x=NULL)+
  coord_flip()

ggsave("negative_SG1.png")



#Most common positive and negative words for SG 2: 

bing_counts_2 <- SG2_tidy %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort=T) %>%
  ungroup()

bing_counts_2 %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word=reorder(word, n)) %>%
  ggplot(aes(word, n, fill=sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y")+
  labs(y="Contribution to sentiment", x=NULL)+
  coord_flip()

ggsave("negative_SG2.png")

############################
# WORD CLOUD FOR SENTIMENTS
############################

# world cloud for SG 1:

# with NRC 
SG1_tidy %>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~sentiment, value.var="n", fill=0) %>%
  comparison.cloud(colors = c("grey20", "gray80"),
                   max.words=100, 
                   scale = c(0.5, 0.5),
                   fixed.asp=TRUE,
                   title.size=1
  )



#bing 
SG1_tidy %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~sentiment, value.var="n", fill=0) %>%
  comparison.cloud(colors = c("grey20", "red"),
                   max.words=100, 
                   scale = c(0.70, 0.70),
                   fixed.asp=TRUE,
                   title.size=1
  )

# world cloud SG 2

SG2_tidy %>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~sentiment, value.var="n", fill=0) %>%
  comparison.cloud(colors = c("grey20", "gray80"),
                   max.words=100, 
                   scale = c(0.55, 0.55),
                   fixed.asp=TRUE,
                   title.size=1
  )

#bing 
SG2_tidy %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~sentiment, value.var="n", fill=0) %>%
  comparison.cloud(colors = c("grey20", "red"),
                   max.words=50, 
                   scale = c(0.70, 0.70),
                   fixed.asp=TRUE,
                   title.size=1
  )

###########################
# BIGRAM NETWORK
##########################

# bigram network for SG 1

library(igraph)
bigram_graph_SG1 <- SG1_ng %>%
  filter(n > 17) %>%
  graph_from_data_frame()


ggraph(bigram_graph_SG1, layout = "fr") +
  geom_edge_link()+
  geom_node_point()+
  geom_node_text(aes(label=name), vjust =1, hjust=1)

# bigram network for SG 2


bigram_graph_SG2 <- SG2_ng %>%
  filter(n > 17) %>%
  graph_from_data_frame()

ggraph(bigram_graph_SG2, layout = "fr") +
  geom_edge_link()+
  geom_node_point()+
  geom_node_text(aes(label=name), vjust =1, hjust=1)

###########################
# TF- IDF for FOR UNIGRAMS
##########################
# TF-IDF for SG1
combined_speech <- bind_rows(mutate(SG1_df, make="SG1"),
                           mutate(SG2_df, make= "SG2"))

SG1_modif <- combined_speech %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>% 
  anti_join(cust_stop) %>%
  count(make, word, sort=TRUE) %>%
  ungroup()

SG1_modif2 <- SG1_modif %>%
  group_by(make) %>%
  summarize(total=sum(n))

SG1_leftjoined <- left_join(SG1_modif, SG1_modif2)

tidy_SG1_tfidf <- SG1_leftjoined %>%
  bind_tf_idf(word, make, n)

tidy_SG1_tfidf # we get all the zeors because we are looking at stop words ... too common

tidy_SG1_tfidf %>%
  arrange(desc(tf_idf))

# looking at the graphical apprach:
tidy_SG1_tfidf %>%
  arrange(desc(tf_idf)) %>%
  mutate(word=factor(word, levels=rev(unique(word)))) %>%
  group_by(make) %>%
  top_n(15) %>%
  ungroup %>%
  ggplot(aes(word, tf_idf, fill=make))+
  geom_col(show.legend=FALSE)+
  labs(x=NULL, y="tf-idf")+
  facet_wrap(~make, ncol=2, scales="free")+
  coord_flip()

