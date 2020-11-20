# Functions and methods for eras

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
#' @param unit  Character. Type of years used. Default: `"calendar"`.
#' @param scale  Integer. Number of years represented by one unit, e.g. `1000`
#'  for ka. Default: 1.
#' @param direction  Are years counted backwards (`-1`) (the default) or forwards (`1`)
#'  from `epoch`?
#'
#' @return
#' An object of class `era`.
#'
#' @family era definition functions
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
                unit = c("calendar", "Islamic lunar", "radiocarbon"),
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
    label <- vec_cast(label, character())
    parameters <- as.list(eras(label))
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
      epoch = vec_cast(epoch, integer()),
      name = vec_cast(name, character()),
      unit = arg_match(unit),
      scale = vec_cast(scale, integer()),
      direction = vec_cast(direction, integer()),
      stringsAsFactors = FALSE
    )
    parameters <- as.list(parameters)
  }

  do.call(new_era, parameters)
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
#' #  uses partial matching
#' eras("cal")
eras <- function(label = NA) {
  # era_table is an internal dataset generated in data-raw/era_table.R
  if (requireNamespace("tibble", quietly = TRUE)) {
    era_table <- tibble::as_tibble(era_table)
  }

  # Partial matching
  if (!all(is.na(label))) {
    era_table[pmatch(label, era_table[["label"]]),]
  }
  else {
    era_table
  }
}


# Validators --------------------------------------------------------------

validate_era <- function(x) {
  # label
  vec_assert(era_label(x), character())

  # epoch
  vec_assert(era_epoch(x), numeric())

  # name
  vec_assert(era_name(x), character())

  # unit
  # scale
  # direction
  if (!era_direction(x) %in% c(-1, 1)) {
   abort("`direction` must be -1 (backwards) or 1 (forwards)",
         class = "era_invalid_era")
  }
}

#' Is this an `era` object?
#'
#' Tests whether an object is an `era`; a calendar era definition constructed
#' by [era()].
#'
#' @param x  Object to test.
#'
#' @return
#' `TRUE` or `FALSE`.
#'
#' @family era helper functions
#'
#' @export
is_era <- function(x) {
  inherits(x, "era")
}

# S3 methods --------------------------------------------------------------

#' @export
format.era <- function(x, ...) {
  nameout <- paste0(era_name(x), " (", era_label(x), ")")
  nameout[era_name(x) == era_label(x)] <- era_name(x)[era_name(x) == era_label(x)]

  unitout <- paste0(era_unit(x), " (\u00d7", era_scale(x), ")")
  unitout[era_scale(x) == 1] <- era_unit(x)[era_scale(x) == 1]

  dirout <- c("backwards", "forwards")[(era_direction(x) > 0) + 1]

  out <- paste0(nameout, ": ", unitout, " years, counted ", dirout, " from ",
                era_epoch(x))

  return(out)
}

# Getters and setters -----------------------------------------------------

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
#' * **unit** – unit of years used, e.g. "calendar years", "radiocarbon years"
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
