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
  this_year <- yr(as.numeric(format(Sys.Date(), "%Y")), "CE")
  this_year <- yr_transform(this_year, era)
  return(this_year)
}
