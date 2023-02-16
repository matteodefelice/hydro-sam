# DOWNLOAD BOL DATA ------------------------------------------------------------------------
## Sources
# https://www.cndc.bo/media/archivos/estadistica_mensual/gen_dia_0116.htm
## Instructions
# 1. Run the script
# 2. The script downloads the data for the months in `MONTH` for the years 2000+`YEAR`
library(stringr)
OUTFOLDER <- "data/bol"
for (YEAR in seq(10, 22)) {
  for (MONTH in seq(1, 12)) {
    url <- sprintf("https://www.cndc.bo/media/archivos/estadistica_mensual/gen_dia_%02d%02d.zip", MONTH, YEAR)
    destfile <- str_c(OUTFOLDER, "/", sprintf("gen_dia_%02d%02d.zip", MONTH, YEAR))
    if (!(
      file.exists(destfile) ||
        file.exists(str_replace(destfile, ".zip", ".xls")) ||
        file.exists(str_replace(destfile, ".zip", ".xlsx"))
    )) {
      download.file(url, destfile = destfile)
      unzip(destfile, exdir = dirname(destfile))
    }
  }
}
