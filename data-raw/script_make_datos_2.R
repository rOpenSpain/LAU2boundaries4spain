# Sat Mar 10 18:29:33 2018 ------------------------------

library(tidyverse)
library(sf)

#- Paco me envió las geometrias de 2019, 2020 y Provincias y CCAA en un fichero .rda
load("./data-raw/Base2019/LAU2boundaries4spain_2019.rda")
# str(CCAA)             #- son character
# str(Provincias)       #- son character
# str(municipios_2019)  #- son character
# str(municipios_2020)  #- son character



# voy a leer las geometrias con el pkg sf
# an sf object is essentially just a data.frame with an extra column for the spatial information
# sf_a <- sf %>% st_set_geometry( NULL) #- le quitas la geometria


usethis::use_data(CCAA, overwrite = TRUE)
usethis::use_data(Provincias, overwrite = TRUE)
usethis::use_data(municipios_2019)
usethis::use_data(municipios_2020)

#- COMPROBACIONES --------------------------------------------------------------------------------
#remotes::install_github("perezp44/pjpv2020.01")
library(pjpv2020.01)   #- personal packages
pob <- pjpv2020.01::pjp_data_pob_mun_1996_2019

#- año 2019 ----------------------------------------
q_anyo <- 2019
nombre_df <- paste0("municipios_", q_anyo)
df_anyo <- eval(parse(text = nombre_df) )
pob_anyo <- pob %>% filter(year == q_anyo) %>% #- si hay datos de poblacion de 2019
                    filter(poblacion == "Total") %>%
                    select(INECodMuni, poblacion, pob_values)  #- 8131 municipios + 81 condominios
str(df_anyo)
# ------------- comprobaciones poblacion
cc <- full_join(df_anyo, pob_anyo)                  #- 8.212
cc1_condo<- cc %>% filter(is.na(pob_values))   #- 81 condominios
cc1_muni <- cc %>% filter(!is.na(pob_values))  #- 8.131 municipios


#- año 2020 ----------------------------------------
q_anyo <- 2020
nombre_df <- paste0("municipios_", q_anyo)
df_anyo <- eval(parse(text = nombre_df) )
pob_anyo <- pob %>% filter(year == 2019) %>% #- aun no hay datos de 2020 pero tampoco han habido alteraciones municipales en 2020
  filter(poblacion == "Total") %>%
  select(INECodMuni, poblacion, pob_values)  #- 8131 municipios + 81 condominios
str(df_anyo)
# ------------- comprobaciones poblacion
cc <- full_join(df_anyo, pob_anyo)                  #- 8.212
cc1_condo<- cc %>% filter(is.na(pob_values))   #- 81 condominios
cc1_muni <- cc %>% filter(!is.na(pob_values))  #- 8.131 municipios




