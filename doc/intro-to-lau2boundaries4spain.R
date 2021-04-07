## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- echo = FALSE, message = FALSE, warning =FALSE---------------------------
#- ok Granada se lleva la palma con 6 alteraciones municipales 
library(LAU2boundaries4spain)
library(knitr)
library(here)
library(tidyverse)
library(ggrepel)
library(sf)
#----------------------------------------
granada_2020 <- LAU2boundaries4spain::municipios_2020 %>% filter(INECodProv == "18")
granada_2002 <- LAU2boundaries4spain::municipios_2002 %>% filter(INECodProv == "18")
granada_2002_df <- LAU2boundaries4spain::municipios_2002 %>% filter(INECodProv == "18")  %>% st_set_geometry(NULL)
dif_granada <- anti_join(granada_2020, granada_2002_df, by = c("INECodMuni" = "INECodMuni"))  #- los 6 municipios que han cambiado
Provincias <- Provincias
Prov_granada <- Provincias %>% filter(INECodProv == "18")
Prov_limitrofes <- Provincias [st_touches(Provincias, Prov_granada, sparse = FALSE ), ]
centroides_prov <- st_centroid(Prov_limitrofes)    #- sustituye la geometry por el centroide
centroides_prov <- cbind(Prov_limitrofes, st_coordinates(st_centroid(Prov_limitrofes$geometry))) #- ahora e
#- centroides de los municipios q han cambiado en Granada
centroides_dif <- st_centroid(dif_granada)    #- sustituye la geometry por el centroide
centroides_dif <- cbind(dif_granada, st_coordinates(st_centroid(dif_granada$geometry))) #- ahora e
dif_granada_names <- dif_granada %>% st_drop_geometry()

p <- ggplot() +
     geom_sf(data = Provincias, fill = "antiquewhite", color = "grey", size = 0.2) +
     geom_sf(data = granada_2002, fill = "antiquewhite", color = "black", size = 0.14) +
     geom_sf(data = dif_granada, fill = "#E41A1C", color = "black", size = 0.14) +
     geom_sf(data = Prov_granada, fill = NA, color = "black", size = 0.6) +
     geom_text(data = centroides_prov, aes(x = X, y = Y, label = NombreProv), color = "grey", check_overlap = TRUE, size = 3) +
     coord_sf(xlim = c(-4.50, -2.15), ylim = c(36.4, 38.10), expand = FALSE)  +
     theme(panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.15), panel.background = element_rect(fill = "azure")) +
     theme(text = element_text(size = 10), axis.text.x = element_text(size = 5)) +
     theme(axis.text.y = element_text(size = 5)) +
     geom_text_repel(data = centroides_dif, aes(x = X, y = Y, label = NombreMuni), force = 18.5, color = "black", size = 2.4, fontface = "bold") +
     labs(title = "Municipios creados en el periodo 2002-2020", subtitle = "(Provincia de Granada)", x = NULL, y = NULL)
p

## -----------------------------------------------------------------------------
library(LAU2boundaries4spain)
CCAA <- CCAA                         #- geometrías de CC.AA
Provincias <- Provincias             #- geometrías provinciales
municipios_2017 <- municipios_2017   #- geometrías municipales año 2017 (años posibles: 2002 - 2021)

## ---- fig.height= 2.8---------------------------------------------------------
library(sf)
Provincias <- Provincias
plot(Provincias, max.plot = 1)

## ---- message = FALSE---------------------------------------------------------
library(LAU2boundaries4spain)
library(tidyverse)
library(sf)
library(patchwork)
  
CCAA_peninsular <- CCAA %>% filter(!NombreCCAA %in% c("Canarias", "Illes Balears", "Ciudades Autónomas de Ceuta y Melilla"))
Prov_aragon <- Provincias %>% filter(NombreCCAA == "Aragón")
muni_teruel_2017 <- municipios_2017 %>% filter(NombreProv == "Teruel")
Pancrudo <- muni_teruel_2017 %>% filter(NombreMuni == "Pancrudo")

p1 <- ggplot(data = CCAA_peninsular) + geom_sf(fill = "antiquewhite") + 
            geom_sf(data = Prov_aragon, color = "red", size = 0.15) +
            geom_sf(data = muni_teruel_2017, color = "blue", size = 0.05) + theme(panel.background = element_rect(fill = "aliceblue")) +
            labs(title = "CC.AA. españolas", subtitle = "(Aragón en gris y rojo. Municipios de Teruel en azul)") 

p2 <- ggplot(data = Prov_aragon) + geom_sf() + 
      geom_sf(data = muni_teruel_2017, color = "black", size = 0.15, fill = "antiquewhite") + 
      geom_sf(data = Pancrudo, fill = "purple", size = 0.1) + theme_minimal() +
      labs(title = "Municipios de Teruel ... existe!!!", subtitle = "(Pancrudo en violeta)") +
      theme(axis.text = element_blank()) +
      theme(panel.grid.major = element_blank()) + 
      theme(plot.title = element_text(size = 11))

p1 + p2

## -----------------------------------------------------------------------------
library(LAU2boundaries4spain)
library(tidyverse)
library(sf)
library(patchwork)

canarias <- Provincias %>% filter(INECodProv %in% c(35,38))
peninsula <- Provincias %>% filter( !(INECodProv %in% c(35, 38)) )
my_shift <- st_bbox(peninsula)[c(1,2)]- (st_bbox(canarias)[c(1,2)]) + c(-2.4, -1.1)
canarias$geometry <- canarias$geometry + my_shift
st_crs(canarias)  <- st_crs(peninsula)
peninsula_y_canarias <- rbind(peninsula, canarias)

p1 <- ggplot() + geom_sf(data = Provincias)
p2 <- ggplot() + geom_sf(data = peninsula) + geom_sf(data = canarias, fill = "purple") 
p1 + p2 

