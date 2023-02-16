# PROCESS BOL DATA ------------------------------------------------------------------------
# Run BOL-download.R first

library(tidyverse)
library(lubridate)

# GENERACION
lf <- list.files("data/bol", pattern = glob2rx("gen_dia*"), full.names = TRUE)

read_gen_file <- function(filename) {
  this_year <- 2000 + as.numeric(str_sub(fs::path_ext_remove(basename(filename)), -2, -1))
  this_month <- as.numeric(str_sub(fs::path_ext_remove(basename(filename)), -4, -3))
  x <- bind_cols(
    readxl::read_excel(filename, range = "A7:A38", col_types = "date"),
    readxl::read_excel(filename, range = "B7:M38", col_types = "numeric")
  ) |>
    filter(!is.na(CENTRAL)) |>
    select(!where(is.character)) |>
    select(!where(is.logical))

  year(x$CENTRAL) <- this_year
  month(x$CENTRAL) <- this_month
  return(x)
}


gen <- lapply(lf, read_gen_file) |>
  bind_rows()
arrange(CENTRAL) |>
  filter(!is.na(CENTRAL))

tosave <- gen |>
  rename(date = CENTRAL) |>
  gather(area, GWh, -date) |>
  mutate(
    GWh = GWh / 1e3,
    area = str_c("BOL-", area)
  ) |>
  ungroup()

write_rds(tosave, "BOL-gen.rds")
