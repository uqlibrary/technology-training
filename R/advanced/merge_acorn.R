merge_acorn <- function(dir) {
  if (!dir.exists(dir)) {
    stop("the directory does not exist. Please provide a valid path as a string.")
  }
  files <- list.files(path = dir,
                      pattern = "tmax*",
                      full.names = TRUE)
  map_dfr(files, read_station)
}