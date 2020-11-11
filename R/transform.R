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

  # Unit
  if (era_unit(src_era) != era_unit(src_era)) {
    stop("No method for transforming ", era_unit(src_era), " to ", era_unit(dst_era))
  }

  # Scale
  if(era_scale(src_era) != era_scale(dst_era)) {
    x <- x * (era_scale(src_era) / era_scale(dst_era))
  }

  # Epoch
  if(era_epoch(src_era) != era_epoch(dst_era)) {
    x <- x + (era_epoch(dst_era) - era_epoch(src_era))
  }

  # Direction
  # See https://github.com/joeroe/era/issues/13

  x <- yr(x, dst_era)
  return(x)
}
