listtest <-
  list(DataType = c(
    list("Ranked Measure Data" = c(list("Preventable hospital stays", "Premature death" = list("95% CI - Low" = "Premature death - 95% CI - Low")),
    list("Additional Measure Data"))
  )))


listtest$DataType$`Ranked Measure Data`$`Premature death`$`95% CI - Low`
