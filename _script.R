# 1) En RStudio: File >> New Project >>New Directory >> R pkg (sin poner git)
# 2) Borro ./R/hello.R y ./man/hello.Rd
# 3) creas un repo en Github con el mismo nombre
# 4) corriges el DESCRIPTION
#----------------------- DESCRIPTION
#- Modifico las siguientes lineas:
# Title: Provides some Spanish Boundary data (shapes) as 'sf'-Ready Data Frames
# Description:  Provides Spanish Boundary data (shapes) as 'sf'-Ready Data Frames. Boundary Data comes from
# Authors@R: person("Pedro J.", "Perez", , "pedro.j.perez@uv.es", c("aut", "cre"))
# Maintainer: Pedro J. Perez <pjperez@uv.es>




library(usethis)
#---------------- has de poner el nombre q le has puesto al pkg
name_of_the_pkg <- "LAU2boundaries4spain"
#path <- paste0("C:/Users/perezp/Desktop/a_GIT_2016a/", name_of_the_pkg)
#create_package(path, rstudio = TRUE)

#------------------------
use_roxygen_md()  #- sets up roxygen2 and enables markdown mode so you can use markdown in your roxygen2 comment blocks.
use_package_doc() #- creates un archivo en ./R/  es a skeleton documentation file for the complete package, taking the advantage of the latest roxygen2 features to minimise duplication between the DESCRIPTION and the documentation
use_readme_rmd()  #- creates a README.Rmd: use this to describe what your package does and why people should care about it.
use_news_md()     #- creates a basic NEWS.md for you to record changes
#use_mit_license(name = "Pedro J. Pérez")



#----------------  Vignette
my_name_vignette <- paste0("intro-to-", name_of_the_pkg)
use_vignette(my_name_vignette) #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/

my_name_vignette2 <- paste0("detailed-info-", name_of_the_pkg)
use_vignette(my_name_vignette2) #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/


#- Has de poner en el yaml de la vignette
# title: "Intro to spanishRshapes package"
# author: "Pedro J. Pérez"
# %\VignetteIndexEntry{Intro to spanishRshapes package}





#----------------------
devtools::use_data_raw()  #- crea directorio de raw-data
# haces el curro con los datos o las funciones
# tanto en data_raw como en la documentacion en ./R/


#----------------------
use_build_ignore("_script.R")



#--------------------------- GIT
use_git(message = "Primer commit")           #- activa GIT. se reinicia RStudio, asi q has de volver a hacer library(usethis)

#--------------------------- se reabrira RStudio
#- te vas a la Terminal de RStudio y haces: git remote add origin https://github.com/perezp44/spanishLAU2rboundaries.git

# git remote add origin https://github.com/perezp44/LAU2boundaries4spain.git
# git push -u origin master
#----------------------------------
library(usethis)
use_github()  #- crea el Github repositori pero da error,
#Error in 'git2r_push': failed to start SSH session: Unable to exchange encryption keys


#--------------------- te vas a TERMINAL y haces esto para subir cambios (en realidad solo hace falta el git push)
# git add -A
# git commit --all --message "todo a Github"
# git push -u origin master
#
#--------------------------- Ahora ya toca meter datos y arreglar documentación
#--------------------------- Ahora ya toca meter datos y arreglar documentación


#--------------------  README
#------ has de knittear README.Rmd para que aparezca README.md q es la que se muestra en Github por defecto


#--------------------- LA VIGNETTE
use_build_ignore("./vignettes/info_vignettes.txt")


#---------------------------- GITHUB
library(usethis)
use_github_labels()  #- labelling issues
use_github_links()   #- añade links en la file DESCRIPTION



#--------------------- te vas a TERMINAL y haces
# git add -A
# git commit --all --message "todo a Github"
# git push -u origin master
#git remote add origin https://github.com/perezp44/spanishLAU2rboundaries.git


#--------------------------- Ahora ya toca meter datos y arreglar documentación
#--------------------------- Ahora ya toca meter datos y arreglar documentación


#--------------------  README
#------ has de knittear README.Rmd para que aparezca README.md q es la que se muestra en Github por defecto

devtools::build_vignettes()  #- viñetas

devtools::document()         #- procesa los roxygen comments y las vignettes

#------------------------------------------------------
#------------------------------------------------------ PARA DESPUES CORRERLO
#------------------------------------------------------



devtools::check(cran = FALSE)            #- chequea
devtools::check()           #- chequea


devtools::build()



#------------------------------ USAR el pkg



# devtools::install_github("perezp44/LAU2boundaries4spain", force = TRUE)
library(LAU2boundaries4spain)
library(tidyverse)

aa <- ls("package:LAU2boundaries4spain", all = TRUE) %>% as.data.frame()#- ves lo que hay en mypkgDataforblog
help(package = LAU2boundaries4spain)
bb <- IGN_mun_17s
names(bb)
cc <- bb %>% filter(NombreMuni  == "Pancrudo")
bb[bb$NombreCCAA=="Galicia",]

#--------------------   Github
# git remote add origin https://github.com/perezp44/mypkgfordata.git
# cd c:/Users/perezp/Desktop/a_GIT_2016a/mypkgDataforblog
# git add -A    # stages all files
# git commit --all --message "Creando el REPO"
# git push -u origin master


#----------------- Licencia
# En esta pagina pone esto de licencia
# http://opendata.esri.es/datasets/d8854f26fd5c4baab08337ca0f3aff6f_0#
#Licencia (compatible con CC-BY 4.0) ampara el uso libre y gratuito para cualquier propósito legítimo,
#siendo la única estricta obligación la de reconocer y mencionar el origen y propiedad de los productos
#y servicios de información geográfica licenciados como del IGN según se indica en la licencia.
#Créditos: © Instituto Geográfico Nacional



#------- BADGES
install.packages("badgecreatr")
badgecreatr::badgeplacer( githubaccount = "perezp44",githubrepo = "spanishRshapes", branch = "master")
badgecreatr::badgeplacer(location = ".", status = "wip" , githubaccount = "perezp44",githubrepo = "spanishRshapes", branch = "master")




#------- PKGDOWN
devtools::install_github("hadley/pkgdown")
pkgdown::build_site()




#- segunda viñeta
library(usethis)

use_vignette("Info-detallada-LAU2boundaries4spain") #- sets you up for success by configuring DESCRIPTION and creating a .Rmd template in vignettes/
#- Has de poner en el yaml de la vignette
# title: "Intro to spanishRshapes package"
# author: "Pedro J. Pérez"
# %\VignetteIndexEntry{Intro to spanishRshapes package}

browseVignettes("LAU2boundaries4spain")

#--- comprimir datos
#Whenever you need to save a lot of R data,
# add `compress = "xz"` to the `save()` call.
#In my case it reduced the out-file size from 72MB to 3MB! No kidding =)


#- proyecciones
http://www.juntadeandalucia.es/medioambiente/site/rediam/menuitem.04dc44281e5d53cf8ca78ca731525ea0/?vgnextoid=2a412abcb86a2210VgnVCM1000001325e50aRCRD&lr=lang_es
http://spatialreference.org/ref/epsg/ed50-utm-zone-30n/   (y es el ultimo formato)

http://www.mapama.gob.es/es/cartografia-y-sig/ide/directorio_datos_servicios/caracteristicas_wms.aspx
Dices que hay que pasar de  sistema de referencia geodésico ETRS89 sin proyección ... a, por ejemplo UTM-30N o LAEA. Mi unica experiencia con esto es que conseguí poner a Canarias en el mismo sistema de referencia que la península, lo hice con la linea de abajo.
library(sf)
prov_can_sf<- st_transform(prov_can_sf, 4258) #- esta linea pasa las geometrias de Canarias de epsg(SRID):4326 a epsg(SRID): 4258

#-  consejos de Maelem
# http://www.masalmon.eu/2017/06/17/automatictools/?utm_content=buffere260d&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer

lintr::lint_package()
devtools::spell_check()
devtools::release()
