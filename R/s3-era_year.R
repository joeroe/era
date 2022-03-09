# era_year.R
# S3 record class `era_year`: year unit definition

# Register formal class for S4 compatibility
# https://vctrs.r-lib.org/articles/s3-vector.html#implementing-a-vctrs-s3-class-in-a-package-1
methods::setOldClass(c("era_year", "vctrs_rcrd"))

# Constructors ------------------------------------------------------------

#' Year units
#'
#' `era_year` objects describe the unit used for a year as its length in days.
#' This value is used in an era definition ([era()]) to enable conversions
#' between eras that use different units (with [yr_transform()]).
#'
#' @param label Character. Name of the year unit.
#' @param days Numeric. Average length of the year in solar days. Defaults to a
#'  Gregorian year (365.2425 days).
#'
#' @return
#' S3 vector of class `era_year`.
#'
#' @family era helper functions
#'
#' @export
#'
#' @examples
#' era_year("Julian", 365.25)
era_year <- function(label = character(), days = 365.2425) {
  if (vec_is_empty(label) && missing(days)) {
    new_era_year()
  }
  else {
    label <- vec_cast(label, character())
    days <- vec_cast(days, numeric())

    new_era_year(label, days)
  }
}

new_era_year <- function(label = character(), days = numeric()) {
  new_rcrd(list(label = label, days = days), class = c("era_year"))
}


# Validators --------------------------------------------------------------

#' Validation functions for `era_year` objects
#'
#' Tests whether an object is of class `era_year` (constructed by [era_year()]).
#'
#' @param x Object to test.
#'
#' @return
#' `TRUE` or `FALSE`.
#'
#' @family era helper functions
#'
#' @export
#'
#' @examples
#' is_era_year(era_year("Julian", 365.25))
is_era_year <- function(x) {
  vec_is(x, new_era_year())
}


# Print/format --------------------------------------------------------

#' @export
format.era_year <- function(x, ...) {
  paste0(era_year_label(x), " years (", era_year_days(x), " days)")
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.era_year <- function(x, ...) {
  out <- format(era_year_label(x), justify = "right")
  pillar::new_pillar_shaft_simple(out, align = "right")
}

# Get/set attributes -----------------------------------------------------

#' Get the parameters of an `era_year` object.
#'
#' Extracts a specific parameter from a year unit object constructed by
#' [era_year()].
#'
#' @name era_year_parameters
#'
#' @param x An object of class `era_year`.
#'
#' @return
#' Value of the parameter.
#'
#' @family era helper functions
#'
#' @examples
#' julian <- era_year("Julian", 365.25)
#' era_year_label(julian)
#' era_year_days(julian)
NULL

#' @rdname era_year_parameters
#' @export
era_year_label <- function(x) {
  field(x, "label")
}

#' @rdname era_year_parameters
#' @export
era_year_days <- function(x) {
  field(x, "days")
}
