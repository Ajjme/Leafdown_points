library(leafdown)
library(leaflet)
library(shiny)
library(dplyr)
library(shinyjs)
library(leafgl)
library(sf)
library(ggplot2)
library(plotly)
library(bs4Dash)
library(fresh)
library(ggrepel)
library(readr)

helper_files = list.files(path = "helper", full.names = TRUE, pattern = "*.R")
sapply(helper_files, source, encoding = "UTF-8")

# shapes and data -----------------------------------------------------------------
ca_cities <- readRDS( file = "shapes/ca_cities.rds")
usa1 <- readRDS("shapes/usa1.RDS")
usa2 <- readRDS("shapes/usa2.RDS") #(counties)shapes/usa2.RDS
### does not work
spdfs_list <- list(usa1, usa2, ca_cities)

### works with below mapping
#spdfs_list <- list(usa1, usa2, usa2)

### combining stations data with mine Seems to be the only way I can get it to work
df_stations_monthly <- get_data()  %>%
  distinct(County, .keep_all = TRUE) %>%
  select(-State)
# Joining Information on Contra costa county cities -----
df_ccc_scores_only <- readRDS("helper/all_scores.RDS") %>%
  mutate(County = "Contra Costa",
         State = "California",
         ev_per_new_vehicle_scaled = as.numeric(ev_per_new_vehicle_scaled),
         mce_score = as.numeric(mce_score),
         participation_score = as.numeric(participation_score)
         )

df_ccc_scores <- full_join(df_ccc_scores_only, df_stations_monthly, by = "County") %>%
  select(-timezone ,
         -hourly_start,
         -hourly_end   ,
         -daily_start  ,
         -daily_end    ,
         -monthly_start,
         -monthly_end    )

df_ccc_scores <- replace(df_ccc_scores, is.na(df_ccc_scores), 0)

df_ccc_scores %>%
  mutate(station = as.character(station))
