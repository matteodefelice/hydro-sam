# Process URU data -------------------------------------------
# You must first download the raw datamanually from https://portal.ute.com.uy/institucional/ute/utei/fuentes-de-generacion
# selecting each time a different time range (max 1 year)
library(tidyverse)
library(lubridate)

lf <- list.files("data/uru", full.names = TRUE)

read_htable <- function(filename) {
  x <- XML::readHTMLTable(filename, skip.rows = 7, as.data.frame = TRUE)[[4]] |>
    as_tibble() |>
    mutate(
      date = parse_date_time(Fecha, orders = "dmy"),
      hydro = as.character(Hidráulica) |>
        str_remove("\\.") |>
        as.numeric()
    ) |>
    select(date, hydro)
  return(x)
}
gen <- lapply(lf, read_htable) |>
  bind_rows()

tosave <- gen |>
  mutate(
    area = "URU",
    GWh = hydro / 1e3
  ) |>
  select(date, area, GWh)

write_rds(tosave, "URU-gen.rds")
