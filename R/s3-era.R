# era.R
# S3 record class `era`: era definitions

# Register formal class for S4 compatibility
# https://vctrs.r-lib.org/articles/s3-vector.html#implementing-a-vctrs-s3-class-in-a-package-1
methods::setOldClass(c("era", "vctrs_rcrd"))

# Constructors ------------------------------------------------------------

#' Create an era object
#'
#' An `era` object defines the time scale associated with a vector of years
#' (see [yr()]). `era()` returns an `era` object, either by looking up
#' `label` in the standard eras defined in [eras()] or, if more than one
#' argument is given, constructing a new definition with the specified
#' parameters.
#'
#' @param label  Character. If only one argument is given to `era()`, the
#'  abbreviated label of a standard era defined in [eras()].
#'  Otherwise, the label to give to the era constructed using the following
#'  arguments.
#' @param epoch  Integer. Epoch year from which years are counted (in the Common
#'  Era).
#' @param name  Character. Full name of the era. Defaults to the value of
#'  `label`.
#' @param unit  An [era_year()] object describing the name of the year unit and
#'  its average length in solar days. Defaults to a Gregorian year
#'  (365.2425 days).
#' @param scale  Integer. Number of years represented by one unit, e.g. `1000`
#'  for ka. Default: 1.
#' @param direction  Are years counted backwards (`-1`) (the default) or forwards (`1`)
#'  from `epoch`?
#'
#' @return
#' An object of class `era`.
#'
#' @family era definition functions
#' @family era helper functions
#'
#' @export
#'
#' @examples
#' era("cal BP")
#'
#' era("T.A.", epoch = -9021, name = "Third Age", direction = 1)
era <- function(label,
                epoch = NULL,
                name = label,
                unit = era_year("Gregorian"),
                scale = 1,
                direction = -1) {
  if (missing(epoch) &&
      missing(name) &&
      missing(unit) &&
      missing(scale) &&
      missing(direction)) {
    if (any(is.na(label))) {
      abort(
        "`label` must not contain NAs.",
        class = "era_invalid_era",
        body = format_error_bullets(c(
          i = "Use eras() to get a list of known era labels."
        ))
      )
    }

    if (is_era(label)) {
      parameters <- as.list(vec_data(label))
    }
    else {
      label <- vec_cast(label, character())
      parameters <- eras(label)
      if (any(apply(is.na(parameters), 1, all))) {
        unknown_label <- label[apply(is.na(parameters), 1, all)]
        unknown_label <- paste0("\"", unknown_label, "\"")
        names(unknown_label) <- rep("x", length(unknown_label))
        abort(
          "Some values of `label` do not match an era defined in eras():",
          class = "era_invalid_era",
          body = format_error_bullets(c(
            unknown_label,
            i = "Use eras() to get a list of known era labels."
          ))
        )
      }
      parameters <- as.list(parameters)
    }
  }
  else {
    # Backwards compatibility with era v.<=0.2.0
    if (any(direction %in% c("backwards", "forwards"))) {
      direction[direction == "backwards"] <- -1
      direction[direction == "forwards"] <- 1
      direction <- as.integer(direction)
    }

    # Use data.frame() to get vector recycling
    parameters <- data.frame(
      label = vec_cast(label, character()),
      epoch = vec_cast(epoch, numeric()),
      name = vec_cast(name, character()),
      unit = vec_assert(unit, new_era_year()),
      scale = vec_cast(scale, integer()),
      direction = vec_cast(direction, integer()),
      stringsAsFactors = FALSE
    )
    parameters <- as.list(parameters)
  }

  era <- do.call(new_era, parameters)
  validate_era(era)
  return(era)
}

new_era <- function(label = NA,
                    epoch = NA,
                    name = NA,
                    unit = NA,
                    scale = NA,
                    direction = NA) {
  new_rcrd(
    list(label = label,
         epoch = epoch,
         name = name,
         unit = unit,
         scale = scale,
         direction = direction),
    class = "era"
  )
}

#' Standard era definitions
#'
#' @description
#' Definitions of common eras and time scales.
#'
#' `eras()` lists all available era definitions. `eras(label)` looks up a
#' specific era by its unique, abbreviated name (e.g. "cal BP").
#'
#' @param label (Optional) Abbreviated names(s) of eras to look up.
#'
#' @details
#' Looking up eras by `label` uses partial matching.
#'
#' @return
#' A table of era definitions. This can be passed to [era()] to construct an
#' `era` object.
#'
#' @family era definition functions
#'
#' @export
#'
#' @examples
#' # List all available eras
#' eras()
#'
#' # Look up a specific era by label
#' eras("cal BP")
#'
#' # With partial matching
#' eras("cal")
eras <- function(label = NA) {
  # era_table is an internal dataset generated in data-raw/era_table.R
  era_table <- era_table

  # Partial matching
  if (!all(is.na(label))) {
    era_table[pmatch(label, era_table[["label"]]),]
  }
  else {
    era_table
  }
}


# Validators --------------------------------------------------------------

#' Validation functions for `era` objects
#'
#' @description
#' Tests whether an object is an era definition (an `era` object).
#' `is_era()` tests whether the object inherits from the S3 class `era_yr`.
#' `is_valid_era()` performs additional checks to determine whether the object
#' is well-formed (see details).
#' `validate_era()` throws an informative error message for invalid `yr`s.
#'
#' @param x  Object to test.
#'
#' @details
#' Valid `era` objects:
#'
#' * Must have all parameters set and not NA
#' * Must have a character `label` parameter
#' * Must have a numeric `epoch` parameter
#' * Must have a character `name` parameter
#' * Must have a character `unit` parameter that is one of the defined units
#' * Must have a positive, integer `scale` parameter
#' * Must have a direction parameter that is -1 (backwards) or 1 (forwards)
#'
#' @return
#' `is_era()` and `is_valid_era()` return `TRUE` or `FALSE`.
#' `validate_era()` returns `x` invisibly, and is used for its side-effect of
#' throwing an informative error for invalid objects.
#'
#' @family era helper functions
#'
#' @export
is_era <- function(x) {
  inherits(x, "era")
}

#' @rdname is_era
#' @export
validate_era <- function(x) {
  if (!is_era(x)) {
    abort("Invalid era:",
          class = "era_invalid_era",
          body = format_error_bullets(c(
            x = "Must inherit from class era.",
            i = "See ?era for methods for defining eras."
          )))
  }

  problems <- era_problems(x)
  if (any(problems)) {
    problems <- names(problems[problems])
    names(problems) <- rep("x", length(problems))
    abort("Invalid era:",
          class = "era_invalid_era",
          body = format_error_bullets(problems))
  }

  return(invisible(x))
}

#' @rdname is_era
#' @export
is_valid_era <- function(x) {
  if (!is_era(x)) {
    return(FALSE)
  }

  problems <- era_problems(x)
  !any(problems)
}

#' List problems with an era object
#'
#' Internal function for testing validity of era objects.
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
era_problems <- function(x) {
  !c(
    # TODO: Do we need this? Breaks now unit is a rcrd, and maybe some fields
    #  could be NA?
    # "era parameters must not be NA" =
    #   apply(vec_proxy(x), 1, function(x) !any(is.na(x))),
    "`label` must be a character" =
      vec_is(era_label(x), character()),
    "`epoch` must be a numeric" =
      vec_is(era_epoch(x), numeric()),
    "`name` must be a character" =
      vec_is(era_name(x), character()),
    "`unit` must be an `era_year` object" =
      is_era_year(era_unit(x)),
    "`scale` must be an integer" =
      vec_is(era_scale(x), integer()),
    "`scale` must be positive" =
      all(era_scale(x) > 0) && !any(is.na(era_scale(x))),
    "`direction` must be -1 (backwards) or 1 (forwards)" =
      all(era_direction(x) %in% c(-1, 1))
  )
}

# Format/print --------------------------------------------------------------

#' @export
format.era <- function(x, ...) {
  nameout <- paste0(era_name(x), " (", era_label(x), ")")
  nameout[era_name(x) == era_label(x)] <- era_name(x)[era_name(x) == era_label(x)]

  scaleout <- paste0(era_scale(x), " ")
  scaleout[era_scale(x) == 1] <- ""

  dirout <- c("backwards", "forwards")[(era_direction(x) > 0) + 1]

  out <- paste0(nameout, ": ", scaleout, format(era_unit(x)),
                ", counted ", dirout, " from ", era_epoch(x))

  return(out)
}


# Casting/coercion --------------------------------------------------------

#' @export
vec_ptype2.era.era <- function(x, y, ...) new_era()

#' @export
vec_cast.era.era <- function(x, to, ...) x


# Equality/comparison -------------------------------------------------

#' @method vec_proxy_equal era
#' @export
vec_proxy_equal.era <- function(x, ...) {
  vec_data(x)[!names(vec_data(x)) %in% c("label", "name")]
}

# Get/set attributes -----------------------------------------------------

#' Get parameters of an era
#'
#' Extracts a specific parameter from an era object.
#'
#' @name era_parameters
#'
#' @param x An `era` object.
#'
#' @details
#' The available parameters are:
#'
#' * **label** – unique, abbreviated label of the era, e.g. "cal BP"
#' * **epoch** – year of origin of the era, e.g. 1950 for years Before Present
#' * **name** – full name of the era, e.g. "calendar years Before Present"
#' * **unit** – unit of years used, an [era_year()] object
#' * **scale** – multiple of years used, e.g. 1000 for ka/kiloannum
#' * **direction** – whether years are counted "backwards" or "forwards" from the epoch
#' #'
#' @return
#' Value of the parameter.
#'
#' @family era helper functions
#'
#' @examples
#' x <- era("cal BP")
#' era_name(x)
NULL

#' @rdname era_parameters
#' @export
era_label <- function(x) {
  return(field(x, "label"))
}

#' @rdname era_parameters
#' @export
era_epoch <- function(x) {
  return(field(x, "epoch"))
}

#' @rdname era_parameters
#' @export
era_name <- function(x) {
  return(field(x, "name"))
}

#' @rdname era_parameters
#' @export
era_unit <- function(x) {
  return(field(x, "unit"))
}

#' @rdname era_parameters
#' @export
era_scale <- function(x) {
  return(field(x, "scale"))
}

#' @rdname era_parameters
#' @export
era_direction <- function(x) {
  return(field(x, "direction"))
}
