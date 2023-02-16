# Collection of scripts to download & process hydropower generation data in Argentina, Bolivia, Brazil, Uruguay

This repository contains a set of R scripts that can be used to scrape and/or process hydropower generation data from the websites of the following system operators:

  - CNDC, Comité Nacional de Despacho de Carga (Bolivia): https://www.cndc.bo/home/index.php
  - ONS, Operador Nacional do Sistema Elétrico (Brazil): https://www.ons.org.br/
  - UTE, Usinas y Trasmisiones Eléctricas (Uruguay): https://www.ute.com.uy/
  - CAMMESA, Compañía Administradora del Mercado Mayorista Eléctrico Sociedad Anónima (Argentina): https://cammesaweb.cammesa.com
  
The data obtained from this code has been used in the report of the Joint Research Centre of the European Commission: "Extreme and long-term drought in the La Plata Basin: event evolution and impact assessment until September 2022" [available here](https://publications.jrc.ec.europa.eu/repository/handle/JRC132245).

The code is very simple and not polished, however I think it might be useful to obtain fundamental data from four south American power systems.

A snapshot of the raw & processed data is archived on Zenodo and available here: [https://doi.org/10.5281/zenodo.7644349](https://doi.org/10.5281/zenodo.7644349)

## Data

The entire dataset contains more than 50 000 rows for the four countries. This is a summary for the data based on the latest snapshot (February 2023).

| Country | time range | time resolution | number of variables (area) per country |
| --- | --- | --- | --- |
| ARG     | 2015 - 2022 | daily | 24 |
| BOL     | 2010 - 2022 | daily | 10 |
| BRA     | 2017 - 2023 | weekly  | 6 | 
| URU     | 2010 - 2022 | daily | 1 | 

### Argentina (ARG)

The data must be downloaded from the [Descargar Informes Históricos](https://cammesaweb.cammesa.com/informe-sintesis-mensual/) section of the website. Two files must be downloaded:
  1. The latest ``BASE INFORME MENSUAL`` that is named according to the latest month available (currently is ``BASE_INFORME_MENSUAL_2022-12.zip``)
  2. The file ``Base Informe Mensual 2018 12`` containing all the data until 2018
  
The script `ARG-process.R` extract the data saving this table in RDS format:
```
# A tibble: 2,030 × 3
   date                area            GWh
   <dttm>              <chr>         <dbl>
 1 2015-01-01 00:00:00 ARG-ADTOHI    29.2 
 2 2015-01-01 00:00:00 ARG-ALICHI   114.  
 3 2015-01-01 00:00:00 ARG-ARROHI    37.6 
 4 2015-01-01 00:00:00 ARG-ARROHINU   2.83
 5 2015-01-01 00:00:00 ARG-CACHHI    41.9 
 6 2015-01-01 00:00:00 ARG-CCOLHI     0   
 7 2015-01-01 00:00:00 ARG-CCORHI     6.56
 8 2015-01-01 00:00:00 ARG-CHOCHI   164.  
 9 2015-01-01 00:00:00 ARG-CONDHI    22.2 
10 2015-01-01 00:00:00 ARG-CPIEHI    22.2 
# … with 2,020 more rows
```

### Bolivia (BOL)

The script `BOL-download.R` download the files and the script `BOL-process.R` extract the time-series. The second script will save in RDS format a table in the following format:
```
# A tibble: 94,794 × 3
   date                area        GWh
   <dttm>              <chr>     <dbl>
 1 2010-01-01 00:00:00 BOL-ZONGO  3.80
 2 2010-01-02 00:00:00 BOL-ZONGO  3.80
 3 2010-01-03 00:00:00 BOL-ZONGO  3.82
 4 2010-01-04 00:00:00 BOL-ZONGO  3.80
 5 2010-01-05 00:00:00 BOL-ZONGO  3.44
 6 2010-01-06 00:00:00 BOL-ZONGO  3.31
 7 2010-01-07 00:00:00 BOL-ZONGO  3.31
 8 2010-01-08 00:00:00 BOL-ZONGO  3.28
 9 2010-01-09 00:00:00 BOL-ZONGO  3.24
10 2010-01-10 00:00:00 BOL-ZONGO  3.26
# … with 94,784 more rows
```

### Brazil (BRA)

The script `BRA-download.R` download the files and the script `BRA-process.R` extract the time-series. The second script will save in RDS format a table in the following format:
```
# A tibble: 1,908 × 3
   area                               GWh date      
   <chr>                            <dbl> <date>    
 1 BRA-Norte                        2590. 2022-01-01
 2 BRA-Nordeste                      559. 2022-01-01
 3 BRA-Sul                           506. 2022-01-01
 4 BRA-Sudeste/Centro-Oeste         4026. 2022-01-01
 5 BRA-Itaipu                        648. 2022-01-01
 6 BRA-Sistema Interligado Nacional 8329. 2022-01-01
 7 BRA-Norte                        1881. 2020-02-01
 8 BRA-Nordeste                      517. 2020-02-01
 9 BRA-Sul                           646. 2020-02-01
10 BRA-Sudeste/Centro-Oeste         4964. 2020-02-01
# … with 1,898 more rows
```

### Uruguay (URY)
Unfortunately, the raw data must be exported manually from [this webpage](https://portal.ute.com.uy/institucional/ute/utei/fuentes-de-generacion) selecting each time a different time range (max 1 year). The data table is the one under the tab "Energia"> "Histórico Composición Energética", you must select the time range, then click "Aplicar" on the right and "Exportar" on the bottom. The website is sometimes slow in providing the data. 

The script `URU-process.R` extract the time-series from the raw data saving this table in RDS format:
```
# A tibble: 4,407 × 3
   date                area    GWh
   <dttm>              <chr> <dbl>
 1 2011-07-24 00:00:00 URU    24.3
 2 2011-07-23 00:00:00 URU    28.0
 3 2011-07-22 00:00:00 URU    29.0
 4 2011-07-21 00:00:00 URU    29.4
 5 2011-07-20 00:00:00 URU    28.6
 6 2011-07-19 00:00:00 URU    28.4
 7 2011-07-17 00:00:00 URU    23.9
 8 2011-07-16 00:00:00 URU    22.5
 9 2011-07-15 00:00:00 URU    23.7
10 2011-07-14 00:00:00 URU    24.6
# … with 4,397 more rows
```
