# Prepare internal dataset of era definitions used in eras()

library("tibble")
library("usethis")

# EPOCHS
# - Defined in astronomical year numbering, i.e. 1 BCE is 0, 2 BCE is -1, etc.
# - Remember that era_yrs are continuous: 1 CE should be read as 1.0 CE, i.e.
#   the start of the year.
# - Use era:::frac_year("MM-DD") to roughly align calendars where the year
#   doesn't begin on 1 January.
# - If the year numbering starts with 1 (e.g. 1 CE, 1 AH), the epoch is one year
#   *before* the start of that year.
present <- 1950
# Hijra <https://www.soundvision.com/article/the-beginning-of-hijri-calendar>
hijra <- 621 + era:::frac_year("07-16")
# Hijra (Nowruz) <https://web.archive.org/web/20050311055900/http://wwwusr.obspm.fr/~heydari/divers/ir-cal-eng.html>
nhijra <- 621 + era:::frac_year("03-22")
# Anno Mundi
mundi <- -3761 + era:::frac_year("10-07")

# YEAR UNITS
# - Defined as the *mean* length in days; accounting for the differing lengths
#   of calendar years is beyond the scope of this package.
# - Please include a link for the source of information.
# - Otherwise mostly sourced from https://en.wikipedia.org/wiki/Year
gregorian <- era_year("Gregorian", 365.2425)
julian <- era_year("Julian", 365.25)
solar <- era_year("solar", 365.24219)
islamic_lunar <- era_year("Islamic lunar", 354.36708)
nowruz <- era_year("Nowruz", 365.2424) # <https://web.archive.org/web/20050311055900/http://wwwusr.obspm.fr/~heydari/divers/ir-cal-eng.html>
hebrew <- era_year("Hebrew lunisolar", 365 + (24311/98496)) # <http://individual.utoronto.ca/kalendis/hebrew/Hebrew-Possible-Weekdays-view.htm>
radiocarbon <- era_year("radiocarbon", NA)
sidereal <- era_year("sidereal", 365.256363004)
tropical <- era_year("tropical", 365.24219)
anomalistic <- era_year("anomalistic", 365.259636)


era_table <- tribble(
  # label must be unique
  ~label,      ~epoch, ~name,                                   ~unit,         ~scale,  ~direction,
  # Before Present
  "BP",        present, "Before Present",                        gregorian,      1L,    -1,
  "cal BP",    present, "Before Present",                        gregorian,      1L,    -1,
  # Common Era (English)
  "BC",        1,       "Before Christ",                         gregorian,      1L,    -1,
  "BCE",       1,       "Before Common Era",                     gregorian,      1L,    -1,
  "AD",        0,       "Anno Domini",                           gregorian,      1L,    1,
  "CE",        0,       "Common Era",                            gregorian,      1L,    1,
  # SI annus
  "a",         present, "annum",                                 gregorian,      1L,    -1,
  "ka",        present, "kiloannum",                             gregorian,      1000L, -1,
  "Ma",        present, "megaannum",                             gregorian,      1e6L,  -1,
  "Ga",        present, "gigaannum",                             gregorian,      1e9L,  -1,
  # Pseudo-SI annus
  "kya",       present, "thousand years ago",                    gregorian,      1000L, -1,
  "mya",       present, "million years ago",                     gregorian,      1e6L,  -1,
  "bya",       present, "billion years ago",                     gregorian,      1e9L,  -1,
  # GICC05 (b2k)
  # https://www.iceandclimate.nbi.ku.dk/research/strat_dating/annual_layer_count/gicc05_time_scale/
  "b2k",       2000,    "years before 2000",                     gregorian,      1L,    -1,
  # ISO 80000
  # Uncalibrated radiocarbon years
  "uncal BP",  present, "uncalibrated Before Present",           radiocarbon,    1L,    -1,
  "RCYBP",     present, "Radiocarbon Years Before Present",      radiocarbon,    1L,    -1,
  "bp",        present, "Before Present (uncalibrated)",         radiocarbon,    1L,    -1,
  "bc",        present, "Before Christ (uncalibrated)",          radiocarbon,    1L,    -1,
  "bce",       present, "Before Common Era (uncalibrated)",      radiocarbon,    1L,    -1,
  "ad",        present, "Anno Domini (uncalibrated)",            radiocarbon,    1L,    1,
  "ce",        present, "Common Era (uncalibrated)",             radiocarbon,    1L,    1,
  # Common Era aliases and translations
  # Contemporary calendars
  # Julian calendar (English)
  "AD O.S.",   0,       "Anno Domini (Old Style)",               julian,         1L,    1,
  "BC O.S.",   1,       "Before Christ (New Style)",             julian,         1L,    1,
  # Islamic calendars
  "H",         hijra,    "Hijra",                                 islamic_lunar,  1L,    1,
  "AH",        hijra,    "Anno Hegirae",                          islamic_lunar,  1L,    1,
  "BH",        hijra+1,  "Before the Hijra",                      islamic_lunar,  1L,    -1,
  "SH",        nhijra,   "Solar Hijri",                           nowruz,         1L,    1,
  "BSH",       nhijra+1, "Before Solar Hijri",                    nowruz,         1L,    -1,
  # Jewish calendars
  "AM",        mundi,   "Anno Mundi",                            hebrew,         1L,    1,
  # Historic calendars
  # Ancient calendars
  # Quirky calendars
  "HE",        -10000,  "Holocene Era",                          gregorian,      1L,    1,
  "BHE",       -10000,  "Before Holocene Era",                   gregorian,      1L,    -1,
  "AL",        -4000,   "Anno Lucis",                            gregorian,      1L,    1,
  "ADA",       -8000,   "After the Development of Agriculture",  gregorian,      1L,    1,
)

# Unlist unit column
era_table$unit <- do.call(vctrs::vec_c, era_table$unit)

use_data(era_table, overwrite = TRUE, internal = TRUE)
