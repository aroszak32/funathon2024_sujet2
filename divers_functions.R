YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- 1:12

## Exercice 4a1##
create_data_from_input <- function(data, year, month){
  data <- data %>%
    filter(mois == month, an == year)
  return(data)
}


## Exercice 4a2##

stats_aeroports <- pax_apt_all %>% 
  group_by(apt,apt_nom) %>%
  mutate(trafic=apt_pax_dep + apt_pax_tr + apt_pax_arr) %>% 
  summarise(trafic_tot=sum(trafic),
            paxdep = sum(apt_pax_dep),
            paxarr = sum(apt_pax_arr),
            paxtra = sum(apt_pax_tr)) %>%
  arrange(desc(trafic_tot)) %>%
  ungroup()

summary_stat_aeroport <- function(data){
  agg_data <- data %>%
    group_by(apt,apt_nom) %>%
    mutate(trafic=apt_pax_dep + apt_pax_tr + apt_pax_arr) %>% 
    summarise(trafic_tot=(sum(trafic))) %>%
    arrange(desc(trafic_tot)) %>%
    ungroup()
  return(agg_data)
}

stats_aeroports_table <- stats_aeroports %>%
  mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
  ) %>%
  select(name_clean, everything())

## Exercice 4b##
library(gt)

table_aeroports <- gt(stats_aeroports_table)
table_aeroports

table_aeroports <- table_aeroports %>%
  cols_hide(columns = starts_with("apt")) %>% 
  fmt_number(columns = starts_with(c("trafic","pax")), suffixing = TRUE) %>% 
  fmt_markdown(columns = "name_clean") %>% 
  cols_label(
    name_clean = md("**Aéroport**"),
    trafic_tot = md("**Trafic total**"),
    paxdep = md("**Départs**"),
    paxarr = md("**Arrivée**"),
    paxtra = md("**Transit**")
  ) %>%
  tab_header(
    title = md("**Statistiques de fréquentation**"),
    subtitle = md("Classement des aéroports")
  ) %>%
  tab_style(
    style = cell_fill(color = "powderblue"),
    locations = cells_title()
  ) %>%
  tab_source_note(source_note = md("_Source: DGAC, à partir des données sur data.gouv.fr_")) %>% 
  opt_interactive()
table_aeroports
