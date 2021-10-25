get_data <- function(year = "2021",
                     data_type = "Ranked Measure Data",
                     columns = c(127,128)) {
  data_file_urls <- set_data_file_urls()
  yr <- year
  url <- data_file_urls[year == yr, url]

  if (file.exists("data/county.hlth.rnks.columns.RData")) load("data/county.hlth.rnks.columns.RData")
  else county_hlth_rnks_columns <- get_data_columns()

  sel_cols <- unique(c(1,2,3,columns))

  dt <-
    data.table::setDT(
      rio::import(url,
                  sheet = data_type,
                  col_names = FALSE,
                  skip = 2
                  )
    )[,.SD, .SDcols=sel_cols]

  colnames(dt) <- county_hlth_rnks_columns[DataType==data_type & Year==yr,][unique(c(1,2,3,columns)), paste(Category, "-", Variable)]
  dt$year <- yr
  dt
}
