# date_utils.R
# Utility functions for dates. Mostly internal.

#' Current year
#'
#' Returns the current year as a year vector, in the era system specified by
#' `era`.
#'
#' @param era An `era` object or label understood by [era()]. Defaults to the
#'  Common Era (`era("CE")`).
#'
#' @return
#' A `yr` vector with the current year.
#'
#' @family era helper functions
#'
#' @export
#'
#' @examples
#' # This year in the Common Era
#' this_year()
#' # This year in the Holocene Epoch
#' this_year("HE")
this_year <- function(era = "CE") {
  whole_year <- as.numeric(format(Sys.Date(), "%Y"))
  frac_date <- frac_year(format(Sys.Date(), "%m-%d"))
  this_year <- yr(whole_year + frac_date, "CE")

  this_year <- purrr::map(era, ~yr_transform(this_year, .x))
  this_year <- purrr::map(this_year, floor_or_ceiling)

  if (vec_size(this_year) > 1) this_year
  else this_year[[1]]
}

floor_or_ceiling <- function(x) {
  if (era_direction(yr_era(x)) == -1) ceiling(x)
  else floor(x)
}

#' Fractional years
#'
#' Calculates the fraction of a year represented by a (Gregorian) date. Doesn't
#' account for leap years.
#'
#' @param x Character. Partial date in format `"%m-%d"`.
#'
#' @return
#' Numeric.
#'
#' @noRd
#' @keywords internal
frac_year <- function(x) {
  base <- as.Date("1970-01-01")
  date <- as.Date(paste("1970", x, sep = "-"), format = "%Y-%m-%d")
  as.numeric(date - base) / 365.2425
}
