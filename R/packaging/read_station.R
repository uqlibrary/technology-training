read_station <- function(file) {
  read_csv(file) %>% 
    slice(-1) %>% 
    select(date, max.temp = 2) %>% 
    mutate(filename = file)
}