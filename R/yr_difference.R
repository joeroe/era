# yr_difference.R
# Era-aware chronological subtraction

#' Chronological difference between year vectors
#'
#' `yr_difference(x, y)` calculates how much later `x` is than `y`, taking into
#; account its era.
#'
#' @param x A [yr] vector with era.
#' @param y A [yr] vector or numeric value. If `yr`, and in a different era than
#'   `x`, it is transformed to the era of `x`. Recycled to the common length of
#'   `x` and `y`.
#'
#' @details
#' This function performs chronological subtraction, not numeric subtraction.
#' Both inputs are converted to a common chronological scale (accounting for era
#' direction and epoch), and the difference is computed as `x - y` on that
#' scale.
#'
#' For forward-counting eras (e.g. CE), this is equivalent to numeric
#' subtraction. For backward-counting eras (e.g. BCE, BP), the era direction is
#' accounted for, so `yr_difference(yr(1900, "BCE"), yr(2000, "BCE"))` returns
#' 100 (1900 BCE is 100 years later than 2000 BCE), even though 1900 - 2000 =
#' -100.
#'
#' @return
#' Numeric vector of signed differences. Positive values indicate `x` is
#' chronologically later than `y`; negative values indicate `x` is earlier.
#'
#' @family functions for chronological ordering and extremes
#'
#' @export
#'
#' @examples
#' # Forward-counting era (CE):
#' yr_difference(yr(200, "CE"), yr(100, "CE"))  # 100
#' yr_difference(yr(100, "CE"), yr(200, "CE"))  # -100
#'
#' # Backward-counting era (BCE):
#' yr_difference(yr(1900, "BCE"), yr(2000, "BCE"))  # 100
#' yr_difference(yr(2000, "BCE"), yr(1900, "BCE"))  # -100
#'
#' # Cross-era (accounts for year zero):
#' yr_difference(yr(10, "CE"), yr(10, "BCE"))  # 19
#'
#' # Scaled eras (returns difference in era's native units):
#' yr_difference(yr(2, "ka"), yr(1, "ka"))  # 1
yr_difference <- function(x, y) {
  if (!is_yr(x)) {
    abort("`x` must be a yr object", class = "era_invalid_yr")
  }

  c(x, y) %<-% vec_recycle_common(x, y)
  y <- yr_transform(y, yr_era(x))

  d <- era_direction(yr_era(x))
  (d * vec_data(x)) - (d * vec_data(y))
}
