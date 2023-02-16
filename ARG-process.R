# Process ARG Data
# Instructions:
# 1. Download the latest ``BASE INFORME MENSUAL`` from https://cammesaweb.cammesa.com/informe-sintesis-mensual/
# 2. Change the line 15 setting the right path

library(tidyverse)
# 2018
d_h01 = readxl::read_excel('data/arg/BASE_INFORME_MENSUAL_2018-12.xlsx',
                           sheet = 'GENERACION',
                           range = 'A22:N36504') |>
  filter(
    `FUENTE GENERACION` == 'Hidráulica'
  )

d_h02 = readxl::read_excel('data/arg/BASE_INFORME_MENSUAL_2022-12/Bases_Oferta_INFORME_MENSUAL/Generaci�n Local Mensual.xlsx' ,
                           range = 'A22:O24612') |>
  filter(
    `FUENTE GENERACION` == 'Hidráulica'
  ) 


tosave = bind_rows(d_h01, d_h02) |>
  select(
    date = MES,
    area = MAQUINA, 
    GWh = `GENERACION NETA`
  ) |>
  mutate(
    GWh = GWh / 1e3,
    area = str_c('ARG-', area)
  )

write_rds(tosave, 'ARG-gen.rds')
