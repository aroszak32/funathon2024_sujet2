## figure statique
fig <- plot_ly(trafic, x = ~date, y = ~trafic, type = 'scatter', mode = 'lines')
fig

figure_plotly <- plot_airport_line(trafic, default_airport)

## graphique dynamique
graph_dynamique <- function(df, selection_aeroport){
  trafic <- df %>% 
    mutate(trafic=apt_pax_dep + apt_pax_tr + apt_pax_arr) %>% 
    filter(apt %in% default_airport) %>% 
    mutate(date=as.Date(paste0(anmois,'01'),"%Y%m%d"))
  
  fig <- trafic %>% 
    plot_ly(x = ~date, y = ~trafic, 
            text = ~apt_nom,
            type = 'scatter', mode = 'lines+markers')
  
  return(fig)
  
}
graph_dynamique(pax_apt_all,"FMEE")

## carte 

map_leaflet_airport <- function(df, airports_location, months, years){
  
  palette <- c("green", "blue", "red")
  
  trafic_date <- df %>%
    mutate(
      date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
    ) %>%
    filter(mois %in% month, an %in% year)
  trafic_aeroports <- airports_location %>%
    inner_join(trafic_date, by = c("Code.OACI" = "apt"))
  
  
  trafic_aeroports <- trafic_aeroports %>%
    mutate(
      volume = ntile(trafic, 3)
    ) %>%
    mutate(
      color = palette[volume]
    )  
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$color
  )
  
  carte_interactive <- leaflet(trafic_aeroports) %>% addTiles() %>%
    addAwesomeMarkers(
      icon=icons[],
      label=~paste0(Nom, "", " (",Code.OACI, ") : ", trafic, " voyageurs")
    )
  
  return(carte_interactive)
}