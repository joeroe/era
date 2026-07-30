# yr_sort_range.R
# Functions for era-aware sorting and ranges of yr vectors

#' Chronological ordering of year vectors
#'
#' Sorts a vector of years into earliest-to-latest or latest-to-earliest
#' chronological order based on its era.
#'
#' @param x [yr] vector with era
#' @param reverse Set `FALSE` (the default) for chronological order (earliest to
#'   latest) or `TRUE` for reverse chronological order (latest to earliest).
#' @param ... Other arguments passed to [sort()]; in particular use `na.last` to
#'   control NA handling.
#'
#' @details
#' This is implemented as a prefixed function rather than an S3 [sort()] method
#' for [yr]s to avoid surprises when numerical (i.e. not chronological) sorting
#' is expected.
#'
#' @return Sorted [yr] vector
#'
#' @family functions for chronological ordering and extremes
#'
#' @export
#'
#' @examples
#' # Forward-counting era:
#' x <- yr(c(200, 100, 300), "CE")
#' yr_sort(x)
#' yr_sort(x, reverse = TRUE)
#'
#' # Backward-counting era:
#' y <- yr(c(200, 100, 300), "BCE")
#' yr_sort(y)
#' yr_sort(y, reverse = TRUE)
yr_sort <- function(x, reverse = FALSE, ...) {
  sort(x, decreasing = xor(era_direction(yr_era(x)) < 0, reverse), ...)
}

#' Chronological minima and maxima
#'
#' Returns the chronologically earliest and/or latest value in a vector of
#' years, i.e. era-aware version [min()], [max()], and [range()].
#'
#' @param x A [yr] vector with era
#' @param na.rm a logical indicating whether missing values should be removed
#'
#' @details
#' These are implemented as prefixed functions rather than S3 [min()], [max()],
#' and [range()] methods for [yr]s to avoid surprises when numerical (i.e. not
#' chronological) extremes are expected.
#'
#' @return
#' For `yr_earliest()` and `yr_leatest()`, a `yr` vector of length 1 with the
#' earliest or latest value.
#'
#' For `yr_range()`, a `yr` vector of length 2 with the earliest and latest
#' value (in that order).
#'
#' If `x` contains `NA` values and `na.rm = FALSE` (the default), only `NA`s
#' will be returned.
#'
#' @family functions for chronological ordering and extremes
#'
#' @examples
#' # Forward-counting era:
#' x <- yr(c(200, 100, 300), "CE")
#' yr_earliest(x)
#' yr_latest(x)
#' yr_range(x)
#'
#' # Backward-counting era:
#' y <- yr(c(200, 100, 300), "BCE")
#' yr_earliest(y)
#' yr_latest(y)
#' yr_range(x)
#'
#' @name yr_extremes
NULL

#' @rdname yr_extremes
#' @export
yr_earliest <- function(x, na.rm = FALSE) {
  if (era_direction(yr_era(x)) < 0) max(x, na.rm = na.rm)
  else min(x, na.rm = na.rm)
}

#' @rdname yr_extremes
#' @export
yr_latest <- function(x, na.rm = FALSE) {
  if (era_direction(yr_era(x)) < 0) min(x, na.rm = na.rm)
  else max(x, na.rm = na.rm)
}

#' @rdname yr_extremes
#' @export
yr_range <- function(x, na.rm = FALSE) {
  yr_sort(range(x, na.rm = na.rm))
}

#' Chronological comparison of years
#'
#' Tests whether years are chronologically earlier or later than each other,
#' accounting for era direction.
#'
#' @param x,y [yr] vectors with era. If in different eras, `y` is transformed to
#'   the era of `x`. Recycled to their common length.
#'
#' @return A logical vector.
#'
#' @details
#' For forward-counting eras (e.g. CE), `yr_earlier_than(x, y)` is equivalent to
#' `x < y` and `yr_later_than(x, y)` is equivalent to `x > y`. For
#' backward-counting eras (e.g. BP, BCE), the comparisons are reversed.
#'
#' `yr_not_earlier_than()` and `yr_not_later_than()` are the negations of
#' `yr_earlier_than()` and `yr_later_than()`, equivalent to `>=` and `<=`
#' respectively for forward-counting eras.
#'
#' These are implemented as functions rather than S3 methods for `<`, `>`,
#' `<=`, and `>=` to avoid surprises when numerical (i.e. not chronological)
#' comparison is expected.
#'
#' @family functions for chronological ordering and extremes
#'
#' @export
#'
#' @examples
#' # Forward-counting era:
#' x <- yr(c(100, 200, 300), "CE")
#' yr_earlier_than(x, yr(200, "CE"))
#' yr_later_than(x, yr(200, "CE"))
#' yr_not_earlier_than(x, yr(200, "CE"))
#' yr_not_later_than(x, yr(200, "CE"))
#'
#' # Backward-counting era:
#' y <- yr(c(100, 200, 300), "BCE")
#' yr_earlier_than(y, yr(200, "BCE"))
#' yr_later_than(y, yr(200, "BCE"))
#' yr_not_earlier_than(y, yr(200, "BCE"))
#' yr_not_later_than(y, yr(200, "BCE"))
yr_earlier_than <- function(x, y) {
  if (!is_yr(x) || !is_yr(y)) {
    abort(
      "Both `x` and `y` must be yr objects",
      class = "era_invalid_yr"
    )
  }

  c(x, y) %<-% vec_recycle_common(x, y)

  if (yr_era(x) != yr_era(y)) {
    y <- yr_transform(y, yr_era(x))
  }

  if (era_direction(yr_era(x)) < 0) x > y
  else x < y
}

#' @rdname yr_earlier_than
#' @export
yr_later_than <- function(x, y) {
  if (!is_yr(x) || !is_yr(y)) {
    abort(
      "Both `x` and `y` must be yr objects",
      class = "era_invalid_yr"
    )
  }

  c(x, y) %<-% vec_recycle_common(x, y)

  if (yr_era(x) != yr_era(y)) {
    y <- yr_transform(y, yr_era(x))
  }

  if (era_direction(yr_era(x)) < 0) x < y
  else x > y
}

#' @rdname yr_earlier_than
#' @export
yr_not_earlier_than <- function(x, y) {
  !yr_earlier_than(x, y)
}

#' @rdname yr_earlier_than
#' @export
yr_not_later_than <- function(x, y) {
  !yr_later_than(x, y)
}
