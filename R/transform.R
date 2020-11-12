# Functions for transforming years with between eras

#' Convert years from one era to another
#'
#' Transform a vector of years from one era to another. Not all transformations
#' are possible (see details).
#'
#' @param x  A `yr` object to be transformed.
#' @param era  Target `era` object, see [era()].
#'
#' @details
#' Era transformations currently supported:
#'
#' * Between scales
#' * Between epochs
#'
#' Not supported:
#'
#' * Between directions (to be implemented).
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
yr_transform <- function(x, era = yr_era(x)) {
  src_era <- yr_era(x)
  dst_era <- era

  # Check comparable units
  if (era_unit(src_era) != era_unit(dst_era)) {
    stop("No method for transforming ", era_unit(src_era), " to ", era_unit(dst_era))
  }

  # Rescale to 1 (if not already)
  x <- x * era_scale(src_era)

  # Transformation
  d <- c("backwards" = -1, "forwards" = 1)
  dx <- unname(d[era_direction(src_era)])
  dy <- unname(d[era_direction(dst_era)])
  ex <- era_epoch(src_era)
  ey <- era_epoch(dst_era)
  y <- x * (dx*dy) + dy * (ex - ey)

  # Apply destination scale
  y <- y / era_scale(dst_era)

  y <- yr(y, dst_era)
  return(y)
}
