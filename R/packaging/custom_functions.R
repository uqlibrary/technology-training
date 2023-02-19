human_age <- function(dog_age) {
  dog_age * 7
}

human_age(12)

source("get_acorn.R")
get_acorn(dest = "acorn_sat_v2_daily_tmax")


library(tidyverse)
read_csv("acorn_sat_v2_daily_tmax/tmax.001019.daily.csv") %>%
  slice(-1) %>% 
  select(date, max.temp = 2) # only keep two variables

source("read_station.R") # source another R script
read_station("acorn_sat_v2_daily_tmax/tmax.002012.daily.csv")

files <- list.files(path = "acorn_sat_v2_daily_tmax", # where to look
                    pattern = "tmax*",                         # what to look for
                    full.names = TRUE)                         # store full path

all_tmax <- map_dfr(files, read_station)

source("merge_acorn.R") # source the R script

merge_acorn("blah")

library(lubridate)
mean_max <- all_tmax %>% 
  filter(!is.na(max.temp)) %>%               # remove NAs
  group_by(filename) %>% 
  filter(any(year(date) == 1910)) %>%        # only keep stations that have data since 1910
  group_by(filename, year = year(date)) %>% 
  filter(n() > 250) %>%                      # remove samples with too much missing data
  summarise(max.temp = mean(max.temp)) %>%   # yearly mean max temperatures for each station
  group_by(year) %>% 
  summarise(max.temp = mean(max.temp))       # one yearly mean max temperature for all stations

ggplot(mean_max, aes(x = year, y = max.temp)) +
  geom_point() +
  geom_smooth() +
  labs(y = "Yearly max temp average (°C)")
