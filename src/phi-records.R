library(tidyverse)
library(lubridate)
library(here)

# Import all records that were exported from LigoLab
cases <-
  readr::read_delim(
    here("data", "all-cases-2014.09.14-2022.03.29.csv"),
    delim = ",",
    col_types = cols(
      Accession = col_double(),
      `Result ID` = col_character(),
      `Client ID` = col_character(),
      `Client Name` = col_character(),
      `Patient Name` = col_character(),
      `Patient ID` = col_character(),
      `Date of Birth` = col_datetime(),
      `Result Created Time` = col_datetime(),
      `Report Released Time` = col_datetime(),
      GUID = col_character(),
      `CPT Code` = col_character(),
      Quantity = col_double(),
      `CPT Created Time` = col_datetime()
    ),
    na = "NULL"
  )

# Remove non-identifiable records and count unique name & DOB combinations
phi_recs <- cases %>% 
  filter(`Patient Name` != "CONFIDENTIAL, PATIENT") %>% 
  # select(`Patient Name`, `Date of Birth`) %>% 
  count(`Patient Name`, `Date of Birth`)

# Tally records: Number of patients to notify in case of catastrophic breach
phi_count <- 
n_distinct(phi_recs$`Patient Name`, phi_recs$`Date of Birth`)
