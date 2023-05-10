# Little helper function for hover labels
create_labels <- function(data, map_level) {
  labels <- sprintf(
    "<strong>%s</strong><br/>Average Policy Score [in Percent]: %g</sup>",
    data[, paste0("NAME_", map_level)], round(data$ev_per_new_vehicle_scale, 1)
  )
  labels %>% lapply(htmltools::HTML)
}
