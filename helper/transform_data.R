### I havent changed the function names but I have switched them to the EV data

avg_temp_per_displ_marker <- function(df_ccc_scores, curr_sel_data) {
  df_ccc_scores %>%
    semi_join(curr_sel_data, by = c("State" = "NAME_1", "County" = "NAME_2")) %>%
    group_by(station, latitude, longitude) %>%
    summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE))
}

avg_temp_per_state <- function(df_ccc_scores, curr_data) {
  curr_data %>%
    left_join(df_ccc_scores, by = c("NAME_1" = "State")) %>%
    group_by(NAME_1) %>%
    summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE)) %>%
    pull(ev_per_new_vehicle_scaled)
}

avg_temp_per_county <- function(df_ccc_scores, curr_data) {
  curr_data %>%
    left_join(df_ccc_scores, by = c("NAME_1" = "State", "NAME_2" = "County")) %>%
    group_by(NAME_1, NAME_2) %>%
    summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE)) %>%
    pull(ev_per_new_vehicle_scaled)
}

### created but not used
avg_temp_per_city <- function(df_ccc_scores, curr_data) {
  curr_data %>%
    left_join(df_ccc_scores, by = c("NAME_1" = "State", "NAME_2" = "County", "NAME_3" = "City")) %>%
    group_by(NAME_1, NAME_2, NAME_3) %>%
    summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE)) %>%
    pull(ev_per_new_vehicle_scaled)
}

