##Exercice 5##
month <- 1
year <- 2019
palette <- c("green", "blue", "red")

## Question 1
trafic_date <- pax_apt_all %>%
  mutate(
    date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
  ) %>%
  filter(mois == month, an == year)

##Question 2
trafic_aeroports <- airports_location %>%
  inner_join(trafic_date, by = c("Code.OACI" = "apt"))

## Question 3
library(leaflet)

leaflet(trafic_aeroports) %>% addTiles() %>%
  addMarkers(popup = ~paste0(Nom, ": ", trafic)) 

## Question 4
trafic_aeroports <- trafic_aeroports %>%
  mutate(
    volume = ntile(trafic, 3)
  ) %>%
  mutate(
    color = palette[volume]
  )

##Question 5
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

carte_interactive
