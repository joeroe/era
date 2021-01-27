# examples.R
# Miscellaneous functions for examples and documentation

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
  dst_era <- era(era)
  this_year <- as.numeric(format(Sys.Date(), "%Y"))
  this_year <- yr(this_year, "CE")

  # N.B. this_year("AD") still returns era("CE")
  # See https://github.com/joeroe/era/issues/31
  if (dst_era != era("CE")) {
    this_year <- yr_transform(this_year, era(dst_era))
  }

  return(this_year)
}
