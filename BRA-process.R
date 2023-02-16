# Process BRA data -----------------------------------------
# Run BRA-download.R first

library(tidyverse)

lf <- list.files("data/bra", full.names = TRUE)

get_hidra_sub <- function(filename) {
  df <- readxl::read_excel(
    path = filename,
    sheet = "03-Geração Hidráulica Usina",
    range = "A4:B10"
  ) |>
    set_names(c("area", "GWh")) |>
    mutate(
      date = parse_date(str_sub(basename(filename), 1, -6), "%d-%m-%Y")
    )
  return(df)
}

d <- lapply(lf, get_hidra_sub) |>
  bind_rows()

hh <- bind_rows(d)

tosave <- hh |>
  mutate(area = str_c("BRA-", area))

write_rds(tosave, "BRA-gen.rds")
