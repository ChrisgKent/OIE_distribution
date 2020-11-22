library(tidyverse)
library(rvest)

url <- "https://www.oie.int/en/animal-health-in-the-world/official-disease-status/fmd/list-of-fmd-free-members/"
webpage <- read_html(url)

#Grabs Data from the OIE website for the nations that are FMDV free without vaccination 
data <- webpage %>% html_nodes("tbody") %>% html_text()
names_FMDV_free <- data[[2]] %>% 
  str_remove_all("\\s\\(\\d\\)") %>% 
  str_remove_all("\\.") %>%
  str_trim() %>% 
  str_split("(?<=[a-z])(?=[A-Z])")

#Scrapes the two nations that are FMDV free with vaccination 
data2 <- webpage %>% html_nodes("p.texte") %>% html_text()
names_FMDV_free_vac <- data2[2] %>%
  str_split(",\\s")

# Creates two dataframes for each status, then binds them into final product called fin
names_free <- data.frame(nation = names_FMDV_free, fmdv_status = "Free", vac = "No") 
free_vac <- data.frame(nation = names_FMDV_free_vac, fmdv_status = "Free", vac = "Yes")
names(names_free) <- c("region", "fmdv_status", "vac" )
names(free_vac) <- c("region", "fmdv_status", "vac" )


fin <- rbind(names_free, free_vac)



