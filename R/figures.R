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
