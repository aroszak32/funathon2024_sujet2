#### Exercice 1 ####

library(yaml)

create_data_list <- function(source_file){
  catalogue <- yaml::read_yaml(source_file)
  return(catalogue)
}

urls <- create_data_list("R/sources.yml")
getwd()

source("correction/R/create_data_list.R")


