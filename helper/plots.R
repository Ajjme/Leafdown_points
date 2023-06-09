custom_theme <- theme(
  axis.text = element_text(size = 16, color = "white"),
  axis.text.x = element_text(angle = 45, hjust = 1),
  title = element_text(size = 16, color = "white"),
  legend.text = element_text(size = 16, color = "white"),
  legend.title = element_text(size = 16),
  legend.background = element_rect(fill = "#343a40"),
  legend.key = element_rect(fill = "#343a40", color = "#343a40"),
  panel.background = element_rect(fill = "#343a40"),
  panel.grid = element_line(color = "black", size = 0.75),
  plot.background = element_rect(fill = "#343a40", color = "#343a40")
)

# need overall score and climate damage they will get!!!
create_scatter_plot <- function(curr_sel_data, curr_map_level, df_ccc_scores, active_markers) {

  if (curr_map_level == 1) {
    state_names <- curr_sel_data$NAME_1
    df <- df_ccc_scores %>%
      filter(State %in% state_names) %>%
      group_by(State) %>%
      summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE), chargers_per_total_vehicle_scaled = mean(chargers_per_total_vehicle_scaled, na.rm = TRUE))
    var_name <- sym("State")
  } else if (curr_map_level == 2) {
    county_names <- curr_sel_data$NAME_2
    state_names <- curr_sel_data$NAME_1
    df <- df_ccc_scores %>%
      filter(State %in% state_names & County %in% county_names) %>%
     group_by(County) %>%
      summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE), chargers_per_total_vehicle_scaled = mean(chargers_per_total_vehicle_scaled, na.rm = TRUE))
    var_name <- sym("County")
  } else {
    df <- df_ccc_scores %>%
      filter(city %in% active_markers$city) %>%
       group_by(city) %>%
       summarise(ev_per_new_vehicle_scaled = mean(ev_per_new_vehicle_scaled, na.rm = TRUE), chargers_per_total_vehicle_scaled = mean(chargers_per_total_vehicle_scaled, na.rm = TRUE))
    var_name <- sym("city")
  }

  ggplot(df, aes(x = ev_per_new_vehicle_scaled, y = chargers_per_total_vehicle_scaled)) +
    geom_point(aes(x = ev_per_new_vehicle_scaled, y = chargers_per_total_vehicle_scaled, color = !!var_name), size = 8) +
    geom_label_repel(
      aes(label = !!var_name), fill = "#343a40", color = "white", label.size = NA, size = 6, point.padding = 20
    ) +
    theme_classic() +
    ggtitle("Percent EVs vs Chargers per New Car Sold") +
    ylab("") +
    xlab("") +
    scale_color_brewer(palette = "Set2") +
    scale_y_continuous(labels = scales::label_number(suffix = "%", accuracy = 1), n.breaks = 4) +
    scale_x_continuous(labels = scales::label_number(suffix = "%")) +
    custom_theme +
    theme(legend.position = "none")

}
### Andrew
create_bar_plot <- function(curr_sel_data, curr_map_level, df_ccc_scores, active_markers) {

  if (curr_map_level == 1) {
    state_names <- curr_sel_data$NAME_1
    df <- df_ccc_scores %>% filter(State %in% state_names)
    var_name <- sym("State")
  } else if (curr_map_level == 2) {
    state_names <- curr_sel_data$NAME_1
    county_names <- curr_sel_data$NAME_2
    df <- df_ccc_scores %>% filter(State %in% state_names & County %in% county_names)
    var_name <- sym("County")
  } else { #will change this to city with new data
    df <- df_ccc_scores %>% filter(city %in% active_markers$city)
    var_name <- sym("city")
  }

  ggplot(df) +
    #geom_col(position = "dodge") + #puts the columns next to each other (stack would stack them)
    geom_col(position = "dodge", aes(x = city, y = chargers_per_total_vehicle_scaled, color = !!var_name, fill = !!var_name), alpha = 0.1, se = FALSE) +
    theme_classic() +
    ggtitle("Charger per New Car Rankings") +
    ylab("") +    xlab("") +
    scale_fill_brewer(palette = "Set2") +
    scale_color_brewer(palette = "Set2") +
    scale_y_continuous(labels = scales::label_number(suffix = "%", accuracy = 1), n.breaks = 4) +
    custom_theme

}


# create_line_plot <- function(curr_sel_data, curr_map_level, df_stations_monthly, active_markers) {
#
#   if (curr_map_level == 1) {
#     state_names <- curr_sel_data$NAME_1
#     df <- df_stations_monthly %>% filter(State %in% state_names)
#     var_name <- sym("State")
#   } else if (curr_map_level == 2) {
#     state_names <- curr_sel_data$NAME_1
#     county_names <- curr_sel_data$NAME_2
#     df <- df_stations_monthly %>% filter(State %in% state_names & County %in% county_names)
#     var_name <- sym("County")
#   } else {
#     df <- df_stations_monthly %>% filter(station %in% active_markers$station)
#     var_name <- sym("station")
#   }
#
#   ggplot(df) +
#       geom_smooth(aes(x = time, y = tavg, color = !!var_name, fill = !!var_name), alpha = 0.1, se = FALSE) +
#       theme_classic() +
#       ggtitle("Development of the average temperature [°C]") +
#       ylab("") +
#       xlab("") +
#       scale_fill_brewer(palette = "Set2") +
#       scale_color_brewer(palette = "Set2") +
#       scale_y_continuous(labels = scales::label_number(suffix = " °C", accuracy = 1), n.breaks = 4) +
#       custom_theme
#
# }
