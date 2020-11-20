# Prepare internal dataset of era definitions used in eras()

library("tibble")
library("usethis")

era_table <- tribble(
  # label must be unique
  ~label,      ~epoch,  ~name,                                   ~unit,          ~scale,  ~direction,
  # Before Present
  "BP",        1950,    "Before Present",                        "calendar",       1L,    -1,
  "cal BP",    1950,    "Before Present",                        "calendar",       1L,    -1,
  # Common Era (English)
  "BC",        0,       "Before Christ",                         "calendar",       1L,    -1,
  "BCE",       0,       "Before Common Era",                     "calendar",       1L,    -1,
  "AD",        0,       "Anno Domini",                           "calendar",       1L,    1,
  "CE",        0,       "Common Era",                            "calendar",       1L,    1,
  # SI annus
  "ka",        1950,    "kiloannum",                             "calendar",       1000L, -1,
  "Ma",        1950,    "megaannum",                             "calendar",       1e6L,  -1,
  "Ga",        1950,    "gigaannum",                             "calendar",       1e9L,  -1,
  # Pseudo-SI annus
  "kya",       1950,    "thousand years ago",                    "calendar",       1000L, -1,
  "mya",       1950,    "million years ago",                     "calendar",       1e6L,  -1,
  "bya",       1950,    "billion years ago",                     "calendar",       1e9L,  -1,
  # GICC05 (b2k)
  # https://www.iceandclimate.nbi.ku.dk/research/strat_dating/annual_layer_count/gicc05_time_scale/
  "b2k",       2000,    "years before 2000",                     "calendar",       1L,    -1,
  # ISO 80000
  # Uncalibrated radiocarbon years
  "uncal BP",  1950,    "uncalibrated Before Present",           "radiocarbon",    1L,    -1,
  "RCYBP",     1950,    "Radiocarbon Years Before Present",      "radiocarbon",    1L,    -1,
  "bp",        1950,    "Before Present (uncalibrated)",         "radiocarbon",    1L,    -1,
  "bc",        1950,    "Before Christ (uncalibrated)",          "radiocarbon",    1L,    -1,
  "bce",       1950,    "Before Common Era (uncalibrated)",      "radiocarbon",    1L,    -1,
  "ad",        1950,    "Anno Domini (uncalibrated)",            "radiocarbon",    1L,    1,
  "ce",        1950,    "Common Era (uncalibrated)",             "radiocarbon",    1L,    1,
  # Common Era aliases and translations
  # Contemporary calendars
  # Islamic calendars
  "AH",        622,     "Anno Hegirae",                          "Islamic lunar",  1L,    1,
  "BH",        622,     "Before the Hijra",                      "Islamic lunar",  1L,    -1,
  "SH",        622,     "Solar Hijri",                           "calendar",       1L,    1,
  "BSH",       622,     "Before Solar Hijri",                    "calendar",       1L,     1,
  # Historic calendars
  # Ancient calendars
  # Quirky calendars
  "HE",        -10000,  "Holocene Era",                          "calendar",       1L,    1,
  "BHE",       -10000,  "Before Holocene Era",                   "calendar",       1L,    -1,
  "AL",        -4000,   "Anno Lucis",                            "calendar",       1L,    1,
  "ADA",       -8000,   "After the Development of Agriculture",  "calendar",       1L,    1,
)

era_table <- as.data.frame(era_table)

use_data(era_table, overwrite = TRUE, internal = TRUE)
