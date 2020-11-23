# Functions for transforming years with between eras

#' Convert years from one era to another
#'
#' Transform a vector of years from one era to another. Not all transformations
#' are possible (see details).
#'
#' @param x  A `yr` object to be transformed.
#' @param era  Target `era` object, see [era()].
#' @param precision Desired precision of the transformation, i.e. the
#'  transformed values are rounded to the nearest `precision`. If `NA`
#'  (the default), no rounding is performed and the exact transformed value is
#'  returned.
#'
#' @details
#' Era transformations currently supported:
#'
#' * Between scales
#' * Between epochs
#' * Between directions
#'
#' Not supported:
#'
#' * Between different units (to be implemented).
#' * units: `calendar` ↔ `radiocarbon` years. This requires
#'   [calibration](https://en.wikipedia.org/wiki/Radiocarbon_calibration)
#'   or un-calibration, which is outside the scope of this package. Functions
#'   for radiocarbon calibration can be found in [rcarbon::calibrate()] and
#'   [Bchron::BchronCalibrate()].
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
  dst_era <- era

  # Check comparable units
  if (era_unit(src_era) != era_unit(dst_era)) {
    abort(
      paste0("Can't transform era ", era_label(src_era), " to ", era_label(dst_era), ":"),
      class = "era_invalid_transform",
      body = format_error_bullets(c(
        x = paste0("Can't convert ", era_unit(src_era), " to ",
                   era_unit(dst_era), " years.")
        ))
      )
  }

  # Rescale to 1 (if not already)
  x <- x * era_scale(src_era)

  # Transformation
  dx <- era_direction(src_era)
  dy <- era_direction(dst_era)
  ex <- era_epoch(src_era)
  ey <- era_epoch(dst_era)
  y <- x * (dx*dy) + dy * (ex - ey)

  # Apply destination scale
  y <- y / era_scale(dst_era)

  # Round to precision
  if (!is.na(precision)) {
    y <- round(y / precision) * precision
  }

  y <- yr(y, dst_era)
  return(y)
}
