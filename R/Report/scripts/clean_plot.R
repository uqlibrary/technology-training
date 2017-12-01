#! /usr/bin/env Rscript

#
#   Description: report feedback 2017
#   Date: 2017, September- November
#   Copyright (C) 2017 Paula Andrea Martinez
#   ORCID iD 0000-0002-8990-1985

library(readxl)
mydir <- getwd()
setwd("/Users/uqpmart6/Documents/Paula/R/feedback/")

file_list <- list.files(pattern='*.xlsx')
file_list
df_list <- lapply(file_list, read_excel)
setwd(mydir)

for (f in 1:length(df_list)){
      print(dim(df_list[[f]]))
}

library(dplyr)
mydata <- bind_rows(df_list)
dim(mydata)
str(mydata)
colnames(mydata)
head(mydata)

# cleaning data
mydata <- mydata[,-9]
colnames(mydata)
colnames(mydata) <- c("date","useful","good","toImprove1","hear","group","school","toImprove2","toImprove3")
colnames(mydata)

toImprove <- mydata %>%
                select(toImprove1, toImprove2, toImprove3) 
dim(toImprove)
head(toImprove)
tail(toImprove)
?cbind
toImprove1 <- cbind(mycol = na.omit(unlist(toImprove)), deparse.level = 0)
dim(toImprove1)
head(toImprove1)
tail(toImprove1)

colnames(mydata)

mydata <- mydata[, c("date","useful","good","hear", "group","school" )]
colnames(mydata)
dim(mydata)
dim(toImprove1)
mydata$toImprove <- toImprove1
colnames(mydata)
dim(mydata)

copymydata <- mydata
myWordCloud(mydata$good, "_Good_")
myWordCloud(mydata$hear, "_Hear_")
myWordCloud(mydata$school, "_School_")
myWordCloud(mydata$toImprove, "_toImprove_")

library(ggplot2)

ggplot(data = mydata, mapping = aes(x = useful, fill = as.factor(useful))) +
  geom_bar() +
  scale_fill_manual(values = c("yellow","red","indianred4","chocolate","chocolate4")) +
  theme(legend.position = "none") +
  labs(title = "Was the session useful?",
       subtitle = "5 is most useful")
ggsave("plots/_useful_.png")

ggplot(data = mydata, mapping = aes(x = group, fill = as.factor(group))) +
  geom_bar() +
  scale_fill_manual(values = c("red","indianred4","chocolate","chocolate4")) +
  theme(legend.position = "none") +
  labs(title = "Group of attendees?")
ggsave("plots/_group_.png")
