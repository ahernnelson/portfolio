pacman::p_load("dplyr","ggplot2","tidyr","scales", "plotly","ggsci")
## Read in data that you created(with extra column)
all_data <- read.csv("all_data_v2.csv", stringsAsFactors = F)
all_data[all_data$year<100,"year"]<-all_data[all_data$year<100,"year"] + 1900
all_data %>% rename(m_rent = X_30a, oop_rent = X_31b, 
                    n_heat = X_32b, fun_kitchen = X_26c,
                    b_toilet = X_25c, n_room = X_25c,
                    rats = X_35a, leak = X_38a, Borough=borough, Year = year) %>%
            mutate(Borough = recode(Borough,
                                     `1`="Bronx",
                                     `2`="Brooklyn",
                                     `3`="Manhattan",
                                     `4`="Queens", 
                                     `5`="Staten Island")) %>%
  mutate(oop_rent = na_if(oop_rent, 99999)) %>%
  mutate(m_rent = na_if(m_rent, 99999)) %>%
  mutate(m_rent = na_if(m_rent, 99998)) -> all_data
all_data[which(all_data$hhinc==9999999),"hhinc"] <- NA
`%!in%` = Negate(`%in%`)

#round((1-mean(is.na(all_data$m_rent)))*100,3)
# 67.5% rent in NYC 
