read_station <- function(file) {
  read_csv(file) %>% 
    slice(-1) %>% 
    select(date, max.temp = `maximum temperature (degC)`) %>% 
    mutate(filename = file)
}