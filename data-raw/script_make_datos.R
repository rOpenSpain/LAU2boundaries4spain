# Sat Mar 10 18:29:33 2018 ------------------------------

library(tidyverse)
library(sf)
# devtools::install_github("perezp44/personal.pjp")
library(personal.pjp)   #- personal packages
# devtools::install_github("perezp44/spanishRpoblacion")
library(spanishRpoblacion)
pob <- INE_padron_muni_96_17  #- datos de poblacion del Padron para chequear

# voy a leer las geometrias con el pkg sf
# an sf object is essentially just a data.frame with an extra column for the spatial information
# sf_a <- sf %>% st_set_geometry( NULL) #- le quitas la geometria


# resulta que las variables son factores y las quiero pasar a character, PERO:
# sf <- sf %>% map_if(is.factor, as.character) %>% as_tibble() #- no chuta, asi que:
# asi que me toco definir una funcion para pasar de factores a character
convertir_factores <- function(df, vv){
  for(ii in seq_along(vv)) {
    if (is.factor(df[[ii]])) {
      df[[ii]] <- as.character(df[[ii]])
    }
  }
  df
}


# CCAA ---------------------------------------------------------------------------------------------------
df <- st_read("./data-raw/Base2016/CCAA.shp") #- 18 x 3
df <- df %>% convertir_factores(1:(length(.)-1))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)  #- eran factores
# ------------- grabando
CCAA <- df
usethis::use_data(CCAA)


# Provincias ----------------------------------------------------------------------------------------------
df <- st_read("./data-raw/Base2016/Provincias.shp") #- 52 x 5
df <- df %>% convertir_factores(1:(length(.)-1))
# resulta que la CC.AA 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- grabando
Provincias <- df
usethis::use_data(Provincias)


# Municipios -----------------------------------------------------------------------------------------------
# Municipios -----------------------------------------------------------------------------------------------

# ----------------------------------- municipios 2018
q_anyo <- "2017" #- si pone 2017 pero es 2018, es que no hay fichero de poblacion de 2018
df <- st_read("./data-raw/Base2016/Municipios2018.shp") #- 8208 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #- aun no hay datos de 2018 pero tampoco han habido alteraciones municipales
                    select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8124 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.208
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.124 municipios
# ------------- grabando
# ------------- grabando
municipios_2018 <- df
usethis::use_data(municipios_2018, overwrite = TRUE)


# ----------------------------------- municipios 2017
q_anyo <- "2017" #-
df <- st_read("./data-raw/Base2016/Municipios2017.shp") #- 8208 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #- aun no hay datos de 2018 pero tampoco han habido alteraciones municipales
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8124 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.208
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.124 municipios
# ------------- grabando
# ------------- grabando
municipios_2017 <- df
usethis::use_data(municipios_2017)




# ----------------------------------- municipios 2016
q_anyo <- "2016" #-
df <- st_read("./data-raw/Base2016/Municipios2016.shp") #- 8209 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #- aun no hay datos de 2018 pero tampoco han habido alteraciones municipales
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8.125 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.209
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.125 municipios
# ------------- grabando
# ------------- grabando
municipios_2016 <- df
usethis::use_data(municipios_2016)


# ----------------------------------- municipios 2015
q_anyo <- "2015" #-
df <- st_read("./data-raw/Base2016/Municipios2015.shp") #- 8203 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #- aun no hay datos de 2018 pero tampoco han habido alteraciones municipales
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8.119 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.203
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.119 municipios
# ------------- grabando
# ------------- grabando
municipios_2015 <- df
usethis::use_data(municipios_2015)




# ----------------------------------- municipios 2014
q_anyo <- "2014" #-
df <- st_read("./data-raw/Base2016/Municipios2014.shp") #- 8.201 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #- aun no hay datos de 2018 pero tampoco han habido alteraciones municipales
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8.117 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.201
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.117 municipios
# ------------- grabando
# ------------- grabando
municipios_2014 <- df
usethis::use_data(municipios_2014)


# Thu Mar 15 11:23:14 2018 ------------------------------
# Thu Mar 15 11:23:07 2018 ------------------------------

library(tidyverse)
library(sf)
# devtools::install_github("perezp44/personal.pjp")
library(personal.pjp)   #- personal packages
# devtools::install_github("perezp44/spanishRpoblacion")
library(spanishRpoblacion)
pob <- INE_padron_muni_96_17  #- datos de poblacion

# resulta que las variables son factores y las quiero pasar a character, PERO:
# sf <- sf %>% map_if(is.factor, as.character) %>% as_tibble() #- no chuta, asi que:
# asi que me toco definir una funcion para pasar de factores a character
convertir_factores <- function(df, vv){
  for(ii in seq_along(vv)) {
    if (is.factor(df[[ii]])) {
      df[[ii]] <- as.character(df[[ii]])
    }
  }
  df
}


# ----------------------------------- municipios 2013
q_anyo <- "2013" #-
df <- st_read("./data-raw/Base2013/Municipios2013.shp") #- 8.201 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #-
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8.117 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.201
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.117 municipios
# ------------- grabando
# ------------- grabando
municipios_2013 <- df
usethis::use_data(municipios_2013, overwrite = TRUE)


# ----------------------------------- municipios 2012
q_anyo <- "2012" #-
df <- st_read("./data-raw/Base2013/Municipios2012.shp") #- 8.200 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #-
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8.116 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.200
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.116 municipios
# ------------- grabando
# ------------- grabando
municipios_2012 <- df
usethis::use_data(municipios_2012)



# ----------------------------------- municipios 2011
q_anyo <- "2011" #-
df <- st_read("./data-raw/Base2011/Municipios2011.shp") #- 8.200 x 7
df <- df %>% convertir_factores(1:(length(.)-1))
# -------------resulta que la CC.AA  nº 18 tiene dos labels, asi que tocarlo
df <- df %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
# ------------- comprobaciones
aa <- df %>% st_set_geometry(NULL) #- le quitas la geometria (para ver mejor las varibales q hay)
bb <- names_v_df_pjp(aa)
# ------------- poblacion
pob_anyo <- pob %>% filter(anyo == q_anyo) %>% #-
  select(INECodMuni, Pob_T, Pob_H, Pob_M)  #- 8.116 municipios
# ------------- comprobaciones poblacion
cc <- full_join(aa, pob_anyo)             #- 8.200
cc1_condo<- cc %>% filter(is.na(Pob_T))   #- 84 condominios
cc1_muni <- cc %>% filter(!is.na(Pob_T))  #- 8.116 municipios
# ------------- grabando
# ------------- grabando
municipios_2011 <- df
usethis::use_data(municipios_2011)



#- de 2010 a 2002 lo voy a (casi) automatizar

anyos <- c(2002:2010)
rutas <- paste0("./data-raw/Base2011/Municipios", anyos, ".shp")
list_df <- map(rutas, st_read)
list_df2 <- map(list_df, convertir_factores, 1:(7-1))  #- no sabido como hacerlo con .x asi que puse(7-1)
seq_ff <- . %>% mutate(NombreCCAA = if_else(INECodCCAA == 18, "Ciudades Autónomas de Ceuta y Melilla", NombreCCAA))
list_df3 <- map(list_df2, seq_ff) #- parece que ha funcionado
#aa <- list_df3[[5]] %>% st_set_geometry(NULL) #- si, ha funcionado
list_df4 <- list_df3
names_grabar <- paste0("municipios_", anyos)
names(list_df4) <- names_grabar
#--- contar rows, municipios y condominios
cuantas_row <- . %>%  nrow()
cuantos_muni <- . %>% filter(!str_detect(INECodMuni, "^53")) %>% nrow()
cuantos_condo <- . %>%  filter(str_detect(INECodMuni, "^53")) %>% nrow()
a1 <- map(list_df4,  cuantas_row) %>% as.data.frame()
a2 <- map(list_df4,  cuantos_muni) %>% as.data.frame()
a3 <- map(list_df4,  cuantos_condo) %>% as.data.frame()
a4 <- rbind(a1,a2,a3)
# municipios_2002 municipios_2003 municipios_2004 municipios_2005 municipios_2006 municipios_2007 municipios_2008
# 1            8192            8192            8193            8193            8194            8195            8196
# 2            8108            8108            8109            8109            8110            8111            8112
# 3              84              84              84              84              84              84              84
# municipios_2009 municipios_2010
# 1            8196            8198
# 2            8112            8114
# 3              84              84

#-- guardando
#-- guardando (no me sale con map)
#- https://timmastny.rbind.io/blog/nse-tidy-eval-dplyr-leadr/
library(rlang)
for (ii in seq_along(1:length(list_df4))) {
  print(ii)
  aa <- list_df4[[ii]]
  nombrecito <- names_grabar[[ii]]
 assign(nombrecito, aa) #- me gustaria haberlo hecho con rlang pero ....
 bb <- sym(nombrecito)
# usethis::use_data(sym(bb)) #- si q uso sym() de rlang pero este ultimo trozo no sale
}
usethis::use_data(municipios_2010)
usethis::use_data(municipios_2009)
usethis::use_data(municipios_2008)
usethis::use_data(municipios_2007)
usethis::use_data(municipios_2006)
usethis::use_data(municipios_2005)
usethis::use_data(municipios_2004)
usethis::use_data(municipios_2003)
usethis::use_data(municipios_2002)



#- estuvimos a punto de hacer esto xq el pkg excedia de 1GB pero era por la carpeta oculta de GIT
#- Como cabian una layer de municipios de cada anyo, lo q hago es que quitamos
# 2003 (igual a 2002)
# 2005 (igual a 2004)
# 2009  (igual a 2008)
# 2018 (igual a 2017)

