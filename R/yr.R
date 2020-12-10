# Functions and methods for years with era


# Constructors ------------------------------------------------------------

new_yr <- function(x = numeric(), era = new_era()) {
  new_vctr(x, era = era, class = "era_yr")
  # S4 compatibility as suggested in:
  # https://vctrs.r-lib.org/articles/s3-vector.html#low-level-and-user-friendly-constructors-1
  # See https://github.com/joeroe/era/issues/12
  # methods::setOldClass(c("era_yr", "vctrs_vctr"))
}

#' Create a vector of years with era
#'
#' A `yr` object represents years with an associated calendar era or time scale.
#'
#' @param x    A numeric vector of years.
#' @param era  The calendar era used by `x`. Either:
#'  * A string matching one of the standard era labels defined in [eras()]
#'  * An `era` object constructed with [era()]
#'
#' @return
#' A `yr` (`era_yr`) object.
#'
#' @family years with era functions
#'
#' @export
#'
#' @examples
#' # The R Age
#' yr(1993:2020, "CE")
#'
#' # A bad movie
#' yr(10000, "BC")
yr <- function(x = numeric(), era) {
  x <- vec_cast(x, numeric())

  era <- era(era)

  yr <- new_yr(x, era)
  validate_yr(yr)
  return(yr)
}


# Validators --------------------------------------------------------------

#' Validation functions for `yr` objects
#'
#' @description
#' Tests whether an object is a vector of years with an era (a `yr` object).
#' `is_yr()` tests whether the object inherits from the S3 class `era_yr`.
#' `is_valid_yr()` performs additional checks to determine whether the object
#' is well-formed (see details).
#' `validate_yr()` throws an informative error message for invalid `yr`s.
#'
#' @param x  Object to test.
#'
#' @details
#' Valid `yr` objects:
#'
#' * Must contain numeric data (NAs are allowed)
#' * Must have the `era` attribute set and not NA
#' * Must not have more than one era
#' * Must have an `era` attribute that is a valid era object (see `validate_era()`)
#'
#' @return
#' `is_yr()` and `is_valid_yr()` return `TRUE` or `FALSE`.
#' `validate_yr()` returns `x` invisibly, and is used for its side-effect of
#' throwing an informative error for invalid objects.
#'
#' @family era helper functions
#'
#' @export
#'
#' @examples
#' x <- yr(5000:5050, era("cal BP"))
#' is_yr(x)
#' is_valid_yr(x)
#' validate_yr(x)
is_yr <- function(x) {
  inherits(x, "era_yr")
}

#' @rdname is_yr
#' @export
validate_yr <- function(x) {
  if (!is_yr(x)) {
    abort("Invalid year vector:",
          class = "era_invalid_yr",
          body = format_error_bullets(c(
            x = "Must inherit from class era_yr.",
            i = "See ?yr for methods for constructing year vectors."
          )))
  }

  problems <- yr_problems(x)
  if (any(problems)) {
    problems <- names(problems[problems])
    names(problems) <- rep("x", length(problems))
    abort("Invalid year vector:",
          class = "era_invalid_yr",
          body = format_error_bullets(problems))
  }

  return(invisible(x))
}

#' @rdname is_yr
#' @export
is_valid_yr <- function(x) {
  if (!is_yr(x)) {
    return(FALSE)
  }

  problems <- yr_problems(x)
  !any(problems)
}

#' List problems with a yr object
#'
#' Internal function for testing validity of yr objects.
#'
#' @param x Object to test
#'
#' @return
#' A named logical vector. The names describe invalid conditions (formatted as
#' error messages that can be passed to vctrs::abort()) and `TRUE` indicates
#' an invalid state.
#'
#' @noRd
#' @keywords internal
yr_problems <- function(x) {
  !c(
    "yr data must be numeric" =
      vec_is(vec_data(x), integer()) || vec_is(vec_data(x), numeric()),
    "`era` attribute must be set and not NA" =
      !any(is.null(yr_era(x))) && !any(is.na(yr_era(x))),
    "Must not have more than one era" =
      vec_size(yr_era(x)) <= 1,
    "`era` attribute must be a valid era" =
      ifelse(!any(is.null(yr_era(x))) && !any(is.na(yr_era(x))),
             is_valid_era(yr_era(x)), TRUE)
  )
}

# Casting/coercion --------------------------------------------------------

#' @export
vec_ptype2.era_yr.era_yr <- function(x, y, ..., x_arg = "", y_arg = "") {
  if (yr_era(x) != yr_era(y)) {
    stop_incompatible_type(x, y,
                           x_arg = x_arg, y_arg = y_arg,
                           action = "combine",
                           details = "Reconcile eras with yr_transform() first.")
  }

  new_yr(era = yr_era(x))
}

#' @export
vec_cast.era_yr.era_yr <- function(x, to, ..., x_arg = "", y_arg = "") {
  if (yr_era(x) != yr_era(to)) {
    stop_incompatible_cast(x, to,
                           x_arg = x_arg, y_arg = y_arg,
                           action = "convert",
                           details = "Reconcile eras with yr_transform() first.")
  }

  new_yr(vec_data(x), era = yr_era(to))
}

#' @export
vec_ptype2.integer.era_yr <- function(x, y, ...) integer()
#' @export
vec_ptype2.era_yr.integer <- function(x, y, ...) integer()

#' @export
vec_cast.integer.era_yr <- function(x, to, ...) {
  vec_cast(vec_data(x), integer())
}

#' @export
vec_cast.era_yr.integer <- function(x, to, ...) {
  new_yr(x, yr_era(to))
}

#' @export
vec_ptype2.double.era_yr <- function(x, y, ...) double()
#' @export
vec_ptype2.era_yr.double <- function(x, y, ...) double()

#' @export
vec_cast.double.era_yr <- function(x, to, ...) {
  vec_cast(vec_data(x), double())
}

#' @export
vec_cast.era_yr.double <- function(x, to, ...) {
  new_yr(x, yr_era(to))
}

# Print generics ---------------------------------------------------------
#' @export
vec_ptype_full.era_yr <- function(x, ...) {
  paste0("yr (", era_label(yr_era(x)), ")")
}

#' @export
vec_ptype_abbr.era_yr <- function(x, ...) {
  "yr"
}

#' @export
obj_print_header.era_yr <- function(x, ...) {
  xera <- era_label(yr_era(x))
  cat("# ", xera, " years <", vec_ptype_abbr(x), "[", vec_size(x), "]>:", "\n",
      sep = "")
}

#' @export
obj_print_footer.era_yr <- function(x, ...) {
  cat("# Era: ", format(yr_era(x)), "\n", sep = "")
}


# Printing in tibbles -----------------------------------------------------

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.era_yr <- function(x, ...) {
  out <- format(
    paste(vec_data(x), pillar::style_subtle(era_label(yr_era(x)))),
    justify = "right"
  )
  pillar::new_pillar_shaft_simple(out, align = "right")
}

# Maths generics ----------------------------------------------------------

#' @method vec_arith era_yr
#' @export
vec_arith.era_yr <- function(op, x, y, ...) {
  UseMethod("vec_arith.era_yr", y)
}

#' @method vec_arith.era_yr default
#' @export
vec_arith.era_yr.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}

#' @method vec_arith.era_yr era_yr
#' @export
vec_arith.era_yr.era_yr <- function(op, x, y, ...) {
  if (yr_era(x) != yr_era(y)) {
    stop_incompatible_op(op, x, y,
                         details = "Reconcile eras with yr_transform() first.")
  }

  if (era_label(yr_era(x)) != era_label(yr_era(y)) |
      era_name(yr_era(x)) != era_name(yr_era(y))) {
    warn("`era(x)` and `era(y)` have different label or name parameters.",
         class = "era_lossy_coercion")
  }

  switch(
    op,
    "+" = ,
    "-" = new_yr(vec_arith_base(op, x, y), yr_era(x)),
    "/" = ,
    "*" = ,
    "^" = ,
    "%%" = ,
    "%/%" = vec_arith_base(op, x, y),
    stop_incompatible_op(op, x, y)
  )
}

#' @method vec_arith.era_yr MISSING
#' @export
vec_arith.era_yr.MISSING <- function(op, x, y, ...) {
  switch(op,
         `-` = new_yr(x * -1, yr_era(x)),
         `+` = x,
         stop_incompatible_op(op, x, y)
  )
}

#' @method vec_arith.era_yr numeric
#' @export
vec_arith.era_yr.numeric <- function(op, x, y, ...) {
  switch(
    op,
    "+" = ,
    "-" = new_yr(vec_arith_base(op, x, y), yr_era(x)),
    "/" = ,
    "*" = ,
    "^" = ,
    "%%" = ,
    "%/%" = vec_arith_base(op, x, y),
    stop_incompatible_op(op, x, y)
  )
}

#' @method vec_arith.numeric era_yr
#' @export
vec_arith.numeric.era_yr <- function(op, x, y, ...) {
  switch(
    op,
    "+" = ,
    "-" = new_yr(vec_arith_base(op, x, y), yr_era(y)),
    "/" = ,
    "*" = ,
    "^" = ,
    "%%" = ,
    "%/%" = vec_arith_base(op, x, y),
    stop_incompatible_op(op, x, y)
  )
}

# Getters and setters -----------------------------------------------------

#' Get or set the era of a vector of years
#'
#' Functions for extracting or assigning the era of a vector of years.
#' This function does not alter the underlying values of `x`. Use [yr_transform()]
#' to *convert* the values of a `yr` vector to a new era.
#'
#' @param x  A vector of years.
#' @param value,era  An `era` object (see [era()]) to be assigned to `x`.
#'
#' @return
#' `yr_era(x)` returns the existing era associated with `x`.
#'
#' `yr_set_era(x, era)` and `yr_era(x) <- era` return `x` with the new era
#' assigned. If `x` is not already a `yr` vector, it will attempt to coerce it
#' into one.
#'
#' @family years with era functions
#'
#' @export
#'
#' @examples
#' x <- 5000:5050
#' yr_era(x) <- era("cal BP")
#' yr_era(x)
yr_era <- function(x) {
  era <- attr(x, "era")
  return(era)
}

#' @rdname yr_era
#' @export
yr_set_era <- function(x, era) {
  era <- era(era)

  if (!is_yr(x)) {
    x <- new_yr(vec_cast(x, numeric()), era)
  }
  else {
    attr(x, "era") <- era
  }
  validate_yr(x)
  return(x)
}

#' @rdname yr_era
#' @export
`yr_era<-` <- function(x, value) yr_set_era(x, value)
