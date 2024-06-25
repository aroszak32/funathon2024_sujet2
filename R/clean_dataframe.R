#### Exercice 2 ####

library(readr)
library(stringr)

clean_dataframe <- function(df){
  
  # Créer les colonnes an et mois
  df <- df %>% 
    mutate(
      an = str_sub(ANMOIS,1,4),
      mois = str_sub(ANMOIS,5,6)
    ) %>%
    mutate(
      mois = str_remove(mois, "^0+")
    )
  
  # lower case for variable names
  colnames(df) <- tolower(colnames(df))
  
  return(df)
  
}

import_airport_data <- function(list_files){
  
  pax_apt_all <- readr::read_csv2(
    list_files, 
    col_types = cols(
      ANMOIS = col_character(),
      APT = col_character(),
      APT_NOM = col_character(),
      APT_ZON = col_character(),
      .default = col_double()
    )
  ) %>% 
    clean_dataframe()
  
  return(pax_apt_all)
  
}

source("R/clean_dataframe.R")

table_aeroport <- read_csv2(unlist(urls$airports))
