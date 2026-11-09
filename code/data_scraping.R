# data scraping

library(rvest)
library(purrr) # for the keep() and pluck() functions
library(dplyr)

url <- "https://en.wikipedia.org/wiki/Washington,_D.C."
page <- read_html(url)

# Extract all html tables and find the population table
pop_table <- page |>
  html_elements("table") |>
  html_table() |>
  keep(~ any(grepl("Census", names(.x)))) |>
  pluck(1)

print(pop_table, n = 100)
# head(pop_table)
# colnames(pop_table)

# pop_table_clean <- pop_table %>% select(-3)
# pop_table_numeric <-

pop = pop_table |>
  # rename variables
  rename(Year = `Census`,
         Population = `Pop.`,
         Change_pct = `%±`) |>
  # remove last column
  slice(-n()) |>
  # remove 3rd column
  select(-3) |>
  # replace commas and percentage with empty space
  mutate(Population = gsub(",", "", Population),
         Change_pct = gsub("%", "", Change_pct)) |>
  # change dash to a negative symbol in Change_pct coulmn
  mutate(Change_pct = gsub("−", "-", Change_pct)) |>
  # read only first four characters in the "Year" column, turn all columns into numeric
  mutate(Year = as.numeric(substr(Year, 1, 4)),
         Population = as.numeric(Population),
         Change_pct = as.numeric(Change_pct))

summary(pop)


write.csv(pop, "dataderived/popDC.csv", row.names = FALSE)









