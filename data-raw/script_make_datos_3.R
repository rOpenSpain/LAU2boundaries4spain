#- 7 de abril 2021
#- incorporando el fichero de municipios de 2021 ( es el mismo que el de 2019)

library(tidyverse)
library(sf)

#- Paco me envió las geometrias de 2019, 2020 y Provincias y CCAA en un fichero .rda (tiene 4 df's)
load("./data-raw/Base2019/LAU2boundaries4spain_2019.rda")
# str(CCAA)             #- son character
# str(Provincias)       #- son character
# str(municipios_2019)  #- son character
# str(municipios_2020)  #- son character

#- solo tengo que crear un nuevo fichero de geometrias para 2021
municipios_2021 <- municipios_2020

usethis::use_data(municipios_2021)

