# Prepare internal dataset of era definitions used in eras()

library("tibble")
library("usethis")

# Epochs
# Remember to subtract 1 from the epoch of calendar systems that don't have a year 0
# Hijra <https://www.soundvision.com/article/the-beginning-of-hijri-calendar>
hijra <- era:::frac_year(as.Date("622-07-16")) - 1
# Hijra (Nowruz) <https://web.archive.org/web/20050311055900/http://wwwusr.obspm.fr/~heydari/divers/ir-cal-eng.html>
nhijra <- era:::frac_year(as.Date("622-03-22")) - 1

# Year units
# Mostly from https://en.wikipedia.org/wiki/Year
gregorian <- era_year("Gregorian", 365.2425)
julian <- era_year("Julian", 365.25)
solar <- era_year("solar", 365.24219)
islamic_lunar <- era_year("Islamic lunar", 354.36708)
nowruz <- era_year("Nowruz", 365.2424) # https://web.archive.org/web/20050311055900/http://wwwusr.obspm.fr/~heydari/divers/ir-cal-eng.html
radiocarbon <- era_year("radiocarbon", NA)
sidereal <- era_year("sidereal", 365.256363004)
tropical <- era_year("tropical", 365.24219)
anomalistic <- era_year("anomalistic", 365.259636)


era_table <- tribble(
  # label must be unique
  ~label,      ~epoch, ~name,                                   ~unit,         ~scale,  ~direction,
  # Before Present
  "BP",        1950,   "Before Present",                        gregorian,      1L,    -1,
  "cal BP",    1950,   "Before Present",                        gregorian,      1L,    -1,
  # Common Era (English)
  "BC",        0,      "Before Christ",                         gregorian,      1L,    -1,
  "BCE",       0,      "Before Common Era",                     gregorian,      1L,    -1,
  "AD",        0,      "Anno Domini",                           gregorian,      1L,    1,
  "CE",        0,      "Common Era",                            gregorian,      1L,    1,
  # SI annus
  "a",         1950,   "annum",                                 gregorian,      1L,    -1,
  "ka",        1950,   "kiloannum",                             gregorian,      1000L, -1,
  "Ma",        1950,   "megaannum",                             gregorian,      1e6L,  -1,
  "Ga",        1950,   "gigaannum",                             gregorian,      1e9L,  -1,
  # Pseudo-SI annus
  "kya",       1950,   "thousand years ago",                    gregorian,      1000L, -1,
  "mya",       1950,   "million years ago",                     gregorian,      1e6L,  -1,
  "bya",       1950,   "billion years ago",                     gregorian,      1e9L,  -1,
  # GICC05 (b2k)
  # https://www.iceandclimate.nbi.ku.dk/research/strat_dating/annual_layer_count/gicc05_time_scale/
  "b2k",       2000,   "years before 2000",                     gregorian,      1L,    -1,
  # ISO 80000
  # Uncalibrated radiocarbon years
  "uncal BP",  1950,   "uncalibrated Before Present",           radiocarbon,    1L,    -1,
  "RCYBP",     1950,   "Radiocarbon Years Before Present",      radiocarbon,    1L,    -1,
  "bp",        1950,   "Before Present (uncalibrated)",         radiocarbon,    1L,    -1,
  "bc",        1950,   "Before Christ (uncalibrated)",          radiocarbon,    1L,    -1,
  "bce",       1950,   "Before Common Era (uncalibrated)",      radiocarbon,    1L,    -1,
  "ad",        1950,   "Anno Domini (uncalibrated)",            radiocarbon,    1L,    1,
  "ce",        1950,   "Common Era (uncalibrated)",             radiocarbon,    1L,    1,
  # Common Era aliases and translations
  # Contemporary calendars
  # Julian calendar (English)
  "AD O.S.",   0,      "Anno Domini (Old Style)",               julian,         1L,    1,
  "BC O.S.",   0,      "Before Christ (New Style)",             julian,         1L,    1,
  # Islamic calendars
  "H",         hijra,  "Hijra",                                 islamic_lunar,  1L,    1,
  "AH",        hijra,  "Anno Hegirae",                          islamic_lunar,  1L,    1,
  "BH",        hijra,  "Before the Hijra",                      islamic_lunar,  1L,    -1,
  "SH",        nhijra, "Solar Hijri",                           nowruz,         1L,    1,
  "BSH",       nhijra, "Before Solar Hijri",                    nowruz,         1L,    -1,
  # Historic calendars
  # Ancient calendars
  # Quirky calendars
  "HE",        -10000, "Holocene Era",                          gregorian,      1L,    1,
  "BHE",       -10000, "Before Holocene Era",                   gregorian,      1L,    -1,
  "AL",        -4000,  "Anno Lucis",                            gregorian,      1L,    1,
  "ADA",       -8000,  "After the Development of Agriculture",  gregorian,      1L,    1,
)

# Unlist unit column
era_table$unit <- do.call(vctrs::vec_c, era_table$unit)

use_data(era_table, overwrite = TRUE, internal = TRUE)
