library(readr)
library(dplyr)
library(stringr)
library(sf)
library(plotly)
library(base)
library(plotly)

source("correction/R/import_data.R")
source("correction/R/create_data_list.R")
source("correction/R/clean_dataframe.R")
source("correction/R/figures.R")
source("R/figures.R")


# Load data ----------------------------------
urls <- create_data_list("./sources.yml")


pax_apt_all <- import_airport_data(unlist(urls$airports))
pax_cie_all <- import_compagnies_data(unlist(urls$compagnies))
pax_lsn_all <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)

liste_aeroports <- unique(pax_apt_all$apt)
default_airport <- liste_aeroports[1]

## Création de la variable trafic
trafic <- pax_apt_all %>% 
  mutate(trafic=apt_pax_dep + apt_pax_tr + apt_pax_arr) %>% 
  filter(apt %in% default_airport) %>% 
  mutate(date=as.Date(paste0(anmois,'01'),"%Y%m%d"))


