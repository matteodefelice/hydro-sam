# DOWNLOAD BRA DATA ------------------------------------------------------------------------
## Sources
# http://sdro.ons.org.br/SDRO/semanal/
## Instructions
# 1. Open the website https://sdro.ons.org.br/SDRO/semanal/ and check what is the latest date available (the beginning of the week, "semana")
# 2. Change the `current_date` to the value found in step 1.
# 3. Run the script
# 4. The script downloads the data since 2017


library(tidyverse)
library(lubridate)
library(glue)

OUTFOLDER <- "data/bra"
current_date <- make_date(2023, 2, 4)
while (year(current_date) > 2016) {
  end_period <- current_date + days(6)
  outfile <- format(current_date, "%d-%m-%Y")
  destfile <- str_c(OUTFOLDER, "/", outfile, ".xlsx")

  url <- glue("http://sdro.ons.org.br/SDRO/semanal/{format(current_date, '%Y_%m_%d')}_{format(end_period, '%Y_%m_%d')}/Html/SEMANAL_{outfile}.xlsx")
  if (!file.exists(destfile)) {
    download.file(url, destfile = destfile, mode = "wb")
  }
  current_date <- current_date - days(7)
}
