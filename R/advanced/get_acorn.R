get_acorn <- function(dest) {
  download.file(url = "ftp://ftp.bom.gov.au/anon/home/ncc/www/change/ACORN_SAT_daily/acorn_sat_v2_daily_tmax.tar.gz",
                destfile = "acorn_sat_v2_daily_tmax.tar.gz")
  if (!dir.exists(dest)) {
    dir.create(dest)
  }
  untar(tarfile = "acorn_sat_v2_daily_tmax.tar.gz",
        exdir = dest)
}