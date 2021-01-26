# Functions for transforming years with between eras

#' Convert years from one era to another
#'
#' Transform a vector of years from one era to another.
#'
#' @param x `yr` object. A vector of years with an era, see [yr()].
#' @param era `era` object describing the target era, see [era()].
#' @param precision Desired precision of the transformation, i.e. the
#'  transformed values are rounded to the nearest `precision`. If `NA`
#'  (the default), no rounding is performed and the exact transformed value is
#'  returned.
#'
#' @details
#' Transformation between eras uses the `scale`, `epoch`, `direction` and `unit`
#' parameters of the era definition. `NA` values for any of these parameters in
#' the source or destination era will cause an error. This is most often
#' encountered when either are measured in 'radiocarbon years', which cannot be
#' related to a calendar time scale without
#' [calibration](https://en.wikipedia.org/wiki/Radiocarbon_calibration) or
#' un-calibration. [stratigraphr::c14_calibrate()] can be used to calibrate
#' radiocarbon dates preserving the `era` attribute.
#'
#' The transformation function is exact and treats years as a real number
#' scale. This means that transformations between eras with different year
#' units (e.g. Gregorian to Julian) and/or epochs not aligned to 1 January
#' in the Gregorian calendar (e.g. Common Era to Islamic calendars) will likely
#' return non-integer values. The `precision` argument provides a
#' convenient way to round the result if you do not need this level of
#' precision. It is also useful for working around the ambiguous definition of
#' 'present' in various geological time-scales.
#'
#'
#' @return
#' A `yr` object in the era specified by `era`.
#'
#' @family years with era functions
#'
#' @export
#'
#' @examples
#' x <- yr(10010:10001, "cal BP")
#' yr_transform(x, era("BCE"))
#'
#' yr_transform(x, era("ka"), precision = 1)
yr_transform <- function(x, era = yr_era(x), precision = NA) {
  src_era <- yr_era(x)
  dst_era <- era(era)

  # Check compatible units
  na_units <- c(era_unit(src_era), era_unit(dst_era))
  na_units <- na_units[is.na(era_year_days(na_units))]
  if (length(na_units) == 1) {
    na_units <- unique(na_units)
    na_units <- paste0("Calendar length of a ", era_year_label(na_units),
                       " year is undefined.")
    names(na_units) <- rep("x", length(na_units))
    abort(
      paste0("Cannot transform ", era_name(src_era), " to ",
             era_name(dst_era), " years:"),
      class = "era_invalid_transform",
      body = format_error_bullets(na_units)
      )
  }

  # Rescale to 1 (if not already)
  x <- x * era_scale(src_era)

  # Transformation
  ux <- era_year_days(era_unit(src_era))
  uy <- era_year_days(era_unit(dst_era))
  dx <- era_direction(src_era)
  dy <- era_direction(dst_era)
  ex <- era_epoch(src_era)
  ey <- era_epoch(dst_era)
  y <- ((ux * dx * dy * x) + (365.2425 * dy * (ex - ey))) / uy

  # Apply destination scale
  y <- y / era_scale(dst_era)

  # Round to precision
  if (!is.na(precision)) {
    y <- round(y / precision) * precision
  }

  y <- yr(y, dst_era)
  return(y)
}
