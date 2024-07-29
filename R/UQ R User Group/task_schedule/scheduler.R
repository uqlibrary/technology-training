library(taskscheduleR)

# Modify this to have the absolute path of the script to automate
scraper <- file.path("file_path")

# Run script hourly, starting in 62 seconds
taskscheduler_create(taskname = "scrape_NYT", rscript = scraper,
                     schedule = "HOUR",
                     starttime = format(Sys.time() + 62, "%H:%M"))