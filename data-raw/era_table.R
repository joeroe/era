# Prepare internal dataset of era definitions used in eras()

library("tibble")
library("usethis")

era_table <- tribble(
  # label must be unique
  ~label,      ~epoch,  ~name,                                   ~unit,          ~scale,  ~direction,
  # Before Present
  "BP",        1950,    "Before Present",                        "calendar",       1,       "backwards",
  "cal BP",    1950,    "Before Present",                        "calendar",       1,       "backwards",
  # Common Era (English)
  "BC",        0,       "Before Christ",                         "calendar",       1,       "backwards",
  "BCE",       0,       "Before Common Era",                     "calendar",       1,       "backwards",
  "AD",        0,       "Anno Domini",                           "calendar",       1,       "forwards",
  "CE",        0,       "Common Era",                            "calendar",       1,       "forwards",
  # SI annus
  "ka",        1950,    "kiloannum",                             "calendar",       1000,    "backwards",
  "Ma",        1950,    "megaannum",                             "calendar",       1e6,     "backwards",
  "Ga",        1950,    "gigaannum",                             "calendar",       1e9,     "backwards",
  # Pseudo-SI annus
  "kya",       1950,    "thousand years ago",                    "calendar",       1000,    "backwards",
  "mya",       1950,    "million years ago",                     "calendar",       1e6,     "backwards",
  "bya",       1950,    "billion years ago",                     "calendar",       1e9,     "backwards",
  # GICC05 (b2k)
  # https://www.iceandclimate.nbi.ku.dk/research/strat_dating/annual_layer_count/gicc05_time_scale/
  "b2k",       2000,    "years before 2000",                     "calendar",       1,       "backwards",
  # ISO 80000
  # Uncalibrated radiocarbon years
  "uncal BP",  1950,    "uncalibrated Before Present",           "radiocarbon",    1,       "backwards",
  "RCYBP",     1950,    "Radiocarbon Years Before Present",      "radiocarbon",    1,       "backwards",
  "bp",        1950,    "Before Present (uncalibrated)",         "radiocarbon",    1,       "backwards",
  "bc",        1950,    "Before Christ (uncalibrated)",          "radiocarbon",    1,       "backwards",
  "bce",       1950,    "Before Common Era (uncalibrated)",      "radiocarbon",    1,       "backwards",
  "ad",        1950,    "Anno Domini (uncalibrated)",            "radiocarbon",    1,       "forwards",
  "ce",        1950,    "Common Era (uncalibrated)",             "radiocarbon",    1,       "forwards",
  # Common Era aliases and translations
  # Contemporary calendars
  # Islamic calendars
  "AH",        622,     "Anno Hegirae",                          "Islamic lunar",  1,       "forwards",
  "BH",        622,     "Before the Hijra",                      "Islamic lunar",  1,       "backwards",
  "SH",        622,     "Solar Hijri",                           "calendar",       1,       "forwards",
  "BSH",       622,     "Before Solar Hijri",                    "calendar",      1,       "backwards",
  # Historic calendars
  # Ancient calendars
  # Quirky calendars
  "HE",        -10000,  "Holocene Era",                          "calendar",       1,       "forwards",
  "BHE",       -10000,  "Before Holocene Era",                   "calendar",       1,       "backwards",
  "AL",        -4000,   "Anno Lucis",                            "calendar",       1,       "forwards",
  "ADA",       -8000,   "After the Development of Agriculture",  "calendar",       1,       "forwards",
)

era_table <- as.data.frame(era_table)

use_data(era_table, overwrite = TRUE, internal = TRUE)
