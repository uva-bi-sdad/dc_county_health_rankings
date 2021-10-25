get_data_columns <-
  function(years = c("2015", "2016", "2017", "2018", "2019", "2020", "2021"),
           data_types = c("Ranked Measure Data", "Additional Measure Data")) {
    data_file_urls <- set_data_file_urls()

    county_hlth_rnks_columns <- data.table::data.table(
      Category = character(),
      Variable = character(),
      Column = character(),
      Year = character(),
      DataType = character()
    )

    for (y in years) {
      for (t in data_types) {
        url <- data_file_urls[year == y, url]

        dt_2r <-
          data.table::setDT(
            rio::import(url,
                        sheet = t,
                        col_names = FALSE,
                        n_max = 2)
          )
        dt_2r_t <- data.table::as.data.table(t(dt_2r))
        dt_2r_t[1, V1 := "Geographic identifiers"]
        dt_2r_t[, V3 := .I]
        dt_2r_t[, V4 := y]
        dt_2r_t[, V5 := t]

        measure_nas <- which(is.na(dt_2r_t$V1))
        measure_rows <- nrow(dt_2r_t)
        for (i in 1:measure_rows) {
          if (!i %in% measure_nas) {
            curr_idx <- i
            #print(introduction$Measure[curr_idx])
          } else {
            dt_2r_t[i, V1 := dt_2r_t[curr_idx, V1]]
            #print(introduction$Measure[curr_idx])
          }
        }
        colnames(dt_2r_t) <- c("Category", "Variable", "Column", "Year", "DataType")
        county_hlth_rnks_columns <- data.table::rbindlist(list(county_hlth_rnks_columns, dt_2r_t))
      }
    }
    save(county_hlth_rnks_columns, file = "data/county.hlth.rnks.columns.RData")
    data_columns
  }
