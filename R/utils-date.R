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
  this_year <- yr(frac_year(Sys.Date()), "CE")
  yr_transform(this_year, era, precision = 1)
}

#' Fractional years
#'
#' Converts a (Gregorian) date to a fractional year.
#'
#' @param x A Date object, e.g. `Sys.Date()`
#'
#' @return
#' Numeric.
#'
#' @noRd
#' @keywords internal
frac_year <- function(x) {
  as.numeric(format(x, "%Y")) + (as.numeric(format(x, "%j")) / 365.2425)
}
