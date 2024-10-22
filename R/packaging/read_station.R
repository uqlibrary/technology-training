read_station <- function(file) {
  read_csv(file, # read the CSV
           show_col_types = FALSE) %>% # be more quiet
    fill(3) %>% # fill down station ID
    slice(-1) %>%  # remove first row
    select(date, station = 3, max.temp = 2) # keep interesting columns
}
