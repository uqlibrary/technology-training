get_acorn <- function(dest) {
  # download the archive of station data from BOM
  download.file(url = "ftp://ftp.bom.gov.au/anon/home/ncc/www/change/ACORN_SAT_daily/acorn_sat_v2.5.0_daily_tmax.tar.gz",
                destfile = "acorn_sat_v2.5.0_daily_tmax.tar.gz")
  # extract it into a directory
  if (!dir.exists(dest)) {
    dir.create(dest)
  }
  untar(tarfile = "acorn_sat_v2.5.0_daily_tmax.tar.gz",
        exdir = dest)
}