library(tidyverse)
library(lubridate)
library(here)

# Import all records that were exported from LigoLab
cases <-
  readr::read_delim(
    here("data", "ytd-results_2023.01.26.csv"),
    delim = ",",
    col_types = cols(
      Accession = col_double(),
      `Result ID` = col_character(),
      `Patient Name` = col_character(),
      `Date of Birth` = col_datetime()
    ),
    na = "NULL"
  )

# Remove non-identifiable records and count unique name & DOB combinations
phi_unique <- 
  cases %>% 
  filter(`Patient Name` != "CONFIDENTIAL, PATIENT|, ",
         !str_detect(`Patient Name`, "(?i)^zz")) %>% 
  count(`Patient Name`, `Date of Birth`)
