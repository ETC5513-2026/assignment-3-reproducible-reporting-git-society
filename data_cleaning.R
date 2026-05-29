
# ================================
# ETC5513 Assignment 3
# Data Cleaning Script
# Author: Tushar Dhanorkar
# Date: May 2026
# ================================

library(tidyverse)

# ---- Load Raw Data ----
imdb_raw <- read_csv("data/IMDB_top_1000.csv")
glimpse(imdb_raw)

# ---- Clean Data ----
imdb_clean <- imdb_raw |>
  
  # Drop columns not needed for analysis
  select(-Poster_Link) |>
  
  # Released_Year to numeric
  mutate(Released_Year = suppressWarnings(as.numeric(Released_Year))) |>
  
  # Runtime to numeric and remove " min"
  mutate(Runtime = as.numeric(str_remove(Runtime, " min"))) |>
  
  # Extract  first as primary genre only
  mutate(Primary_Genre = str_extract(Genre, "^[^,]+") |> str_trim()) |>
  
  # Add Decade column
  mutate(Decade = paste0(floor(Released_Year / 10) * 10, "s")) |>
  
  # Remove rows with missing IMDB Rating and Gross Revenue
  filter(!is.na(IMDB_Rating)) |>
  filter(!(is.na(Gross))) |>
  
  # Reorder columns neatly
  select(Series_Title, Released_Year, Decade, Certificate,
         Runtime, Genre, Primary_Genre, IMDB_Rating,
         Meta_score, Director, Star1, Star2, Star3, Star4,
         No_of_Votes, Gross, Overview)


# ---- Save Cleaned Data ----
write_csv(imdb_clean, "data/imdb_clean.csv")