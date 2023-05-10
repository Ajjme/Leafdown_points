update_leafdown_map <- function(my_leafdown, input, df_ccc_scores, sel_data_before_drilldown) {
  curr_data <- my_leafdown$curr_data
  curr_map_level <- my_leafdown$curr_map_level
  new_data <- curr_data

  if (curr_map_level == 1) {
    new_data$ev_per_new_vehicle_scaled <- avg_temp_per_state(df_ccc_scores, curr_data)
  } else {
    new_data$ev_per_new_vehicle_scaled <- avg_temp_per_county(df_ccc_scores, curr_data)#function name not changed but data pull from different column
  }
  my_leafdown$add_data(new_data)

  draw_arg_list <- create_draw_arg_list(new_data, curr_map_level)

  my_leafdown$activate_shape_selection()
  map <- my_leafdown$draw_leafdown(
    fillColor = draw_arg_list$fill_color,
    weight = draw_arg_list$weight,
    fillOpacity = draw_arg_list$fill_opacity,
    color = "grey",
    label = draw_arg_list$labels,
    labelOptions = labelOptions(style = list("font-size" = "16px")),
    highlight = draw_arg_list$highlight
  ) %>%
    setView(-95, 39, 4) %>% # use later to change start
    my_leafdown$keep_zoom(input) %>%
    addLegend(
      pal = colorNumeric(color_ramp_blue_red, new_data$ev_per_new_vehicle_scaled, na.color = NA),
      values = new_data$ev_per_new_vehicle_scaled,
      title = "Average EV Score",
      labFormat = labelFormat(suffix = "Percent"),
      opacity = 1,
      layerId = "legend"
    )

 # if (curr_map_level == 4) {
 #   my_leafdown$deactivate_shape_selection()
 #   markers <- avg_temp_per_displ_marker(df_ccc_scores, sel_data_before_drilldown)
 #   map <- map %>%
 #     addGlPoints(
 #       data = st_as_sf(markers, coords = c("longitude", "latitude")),
 #       label = paste("Station: ", markers$city),
 #       fillOpacity = 1,
 #       radius = 30,
 #       fillColor = colorNumeric(color_ramp_blue_red, markers$ev_per_new_vehicle_scaled)(markers$ev_per_new_vehicle_scaled),
 #       layerId = "points"
 #     )
 # }

  map

}

