library(rvest)
library(tidyverse)

# Set the working directory to the current folder - won't happen automatically
setwd("file_dir")

NYT_page <- read_html("https://www.nytimes.com")
title_css <- NYT_page %>%
  html_elements(css = ".indicate-hover")

titles <- html_text(title_css)

titles <- data_frame(titles)
titles <- titles %>% 
  rename(.dots = setNames("titles", sprintf("`%s`", format(Sys.time(), format = "%d-%m-%Y %H:%M"))))

df <- read_csv("NYT articles.csv")
df <- merge(df,titles,by=0, all.y=TRUE)
df <- select(df,-1)

write_csv(df,"NYT articles.csv")