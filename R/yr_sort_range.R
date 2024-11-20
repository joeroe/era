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
#' @return Sorted [yr] vector
#'
#' @family functions for chronological ordering and ranges
#'
#' @export
#'
#' @examples
#' # Forward-counting era:
#' x <- yr(c(200, 100, 300), "CE")
#' yr_sort(x)
#' yr_sort(x, reverse = TRUE)

#' # Backward-counting era:
#' y <- yr(c(200, 100, 300), "BCE")
#' yr_sort(y)
#' yr_sort(y, reverse = TRUE)
yr_sort <- function(x, reverse = FALSE, ...) {
  sort(x, decreasing = xor(era_direction(yr_era(x)) < 0, reverse), ...)
}
