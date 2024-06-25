#### Exercice 2 ####

library(readr)
library(stringr)

table_aeroport <- read_csv2(unlist(urls$airports))
table_compagnies <- read_csv2(unlist(urls$compagnies))
table_liaisons <- read_csv2(unlist(urls$liaisons))

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


