# Load the County Health Rankings Column Definitions
load("data/county.hlth.rnks.columns.RData")

# List the Variable Categories
county_hlth_rnks_columns[, .(Category), c("DataType")]

# List all Variables in a Variable Category
county_hlth_rnks_columns[Category=="Preventable hospital stays",]

# Download Data By Year, Data Type, and Column Numbers
my_data <- get_data(year = "2015", data_type = "Ranked Measure Data", columns = c(88, 91))
print(my_data)
