## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval = FALSE-------------------------------------------------------
#  devtools::install_github("perezp44/LAU2boundaries4spain", force = TRUE)
#  library(LAU2boundaries4spain)

## ---- eval = FALSE-------------------------------------------------------
#  library(tidyverse)
#  library(sf)
#  library(LAU2boundaries4spain)
#  Provincias <- Provincias
#  plot(Provincias, max.plot = 1)

## ---- eval = FALSE-------------------------------------------------------
#  library(tidyverse)
#  library(sf)
#  Provincias <- Provincias
#  #provincias_df <- Provincias %>% st_set_geometry(NULL) #- le quitas la geometria
#  canarias <- Provincias %>% filter(INECodProv %in% c(35,38))
#  peninsula <- Provincias %>% filter( !(INECodProv %in% c(35, 38)) )
#  my_shift <- st_bbox(peninsula)[c(1,2)]- (st_bbox(canarias)[c(1,2)]) + c(9.5,0.5)
#  canarias$geometry <- canarias$geometry + my_shift
#  st_crs(canarias)  <- st_crs(peninsula)
#  provincias_a <- rbind(peninsula, canarias)
#  plot(provincias_a, max.plot = 1)

## ---- eval = FALSE-------------------------------------------------------
#  library(tidyverse)
#  library(sf)
#  library(LAU2boundaries4spain)
#  municipios_2018 <- municipios_2018
#  plot(municipios_2018, max.plot = 1)

## ---- eval = FALSE-------------------------------------------------------
#  library(tidyverse)
#  library(sf)
#  library(LAU2boundaries4spain)
#  Provincias_2016 <- municipios_2016 %>%  group_by(INECodProv) %>% summarise()
#  plot(Provincias_2016)

## ---- eval = FALSE-------------------------------------------------------
#  library(tidyverse)
#  library(sf)
#  library(LAU2boundaries4spain)
#  library(spanishRpoblacion)
#  pob <- INE_padron_muni_96_17  #- datos de poblacion del Padron
#  pob_2016 <- pob %>% filter(anyo == 2016) %>% # en 2016 habían 8.125 municipios
#              select(INECodMuni, Pob_T, Pob_H, Pob_M)
#  lindes_2016 <- municipios_2016 #- 8.125 municipios + 84 condominios
#  fusion_2016 <- full_join(lindes_2016, pob_2016)
#  fusion_2016_df <- fusion_2016 %>% st_set_geometry(NULL) #- le quitas la geometria para verlo mejor

## ---- evla = FALSE-------------------------------------------------------
# EPSG Projection 3035 - ETRS89 / ETRS-LAEA 
# Proj4js.defs["EPSG:3035"] = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs"
library(tidyverse)
library(sf)
library(LAU2boundaries4spain)
Provincias_proj <- st_transform(Provincias, crs = 3035) 
plot(Provincias_proj, max.plot = 1)

