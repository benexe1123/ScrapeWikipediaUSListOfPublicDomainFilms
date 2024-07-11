library(rvest)
library(tidyverse)

url <- "https://en.wikipedia.org/wiki/List_of_films_in_the_public_domain_in_the_United_States"

page <- read_html(url)

table <- page |>
  html_node(xpath='//*[@id="mw-content-text"]/div/table[2]') |>
  html_table(fill = TRUE)

films_df <- table |>
  select(1:2) |>
  as.data.frame()

films_df <- films_df |>
  mutate(Year = substr(`Release year`, 1, 4),
         Title_Year = paste(`Film title`, " (", Year, ")", sep = ""))

title_year_df <- films_df |>
  select(Title_Year)

print(title_year_df)

write.csv(title_year_df, "films_in_public_domain.csv", row.names = FALSE)