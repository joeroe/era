# Functions and methods for eras

# Constructors ------------------------------------------------------------

#' Create an era object
#'
#' The `era` class defines the time scale associated with a vector of years
#' (see [yr()]). `era()` returns an `era` object, either by looking up
#' `abbreviation` in the standard definitions included in the package or, if
#' more than one argument is given, constructing a new definition with the
#' given parameters.
#'
#' @param abbreviation  Character. If only one argument is given to `era()`, the
#'  abbreviation of a standard era defined in the package.
#'  Otherwise, the abbreviation of a user-specified era defined by the following
#'  arguments.
#' @param epoch  Integer. Epoch year from which years are counted (in the Common
#'  Era).
#' @param name  Character. Full name of the era. Defaults to the value of
#'  `abbreviation`.
#' @param unit  Character. Default: `"calendar years"`.
#' @param scale  Integer. Number of years represented by one unit, e.g. `1000`
#'  for ka. Default: 1.
#' @param direction  Are years counted `"backwards"` (the default) or `"forwards"`
#'  from `epoch`?
#'
#' @return
#' An object of class `era`.
#'
#' @export
#'
#' @examples
#' era("cal BP")
#'
#' era("T.A.", epoch = -9021, name = "Third Age", direction = "forwards")
era <- function(abbreviation,
                epoch = NULL,
                name = abbreviation,
                unit = c("calendar years", "radiocarbon years"),
                scale = 1,
                direction = c("backwards", "forwards")) {
  if (missing(epoch) &&
      missing(name) &&
      missing(unit) &&
      missing(scale) &&
      missing(direction)) {
    vec_assert(abbreviation, character())
    return(era_dictionary(abbreviation))
  }

  vec_cast(abbreviation, character())
  epoch <- vec_cast(epoch, integer())
  vec_cast(name, character())
  unit <- rlang::arg_match(unit)
  scale <- vec_cast(scale, integer())
  direction <- rlang::arg_match(direction)

  new_era(abbreviation, epoch, name, unit, scale, direction)
}

new_era <- function(abbreviation = NA,
                    epoch = NA,
                    name = NA,
                    unit = NA,
                    scale = NA,
                    direction = NA) {
  new_rcrd(
    list(abbreviation = abbreviation,
         epoch = epoch,
         name = name,
         unit = unit,
         scale = scale,
         direction = direction),
    class = "era"
  )
}

era_dictionary <- function(x) {
  switch(x,
         # Calendar years Before Present
         `BP` = era("BP", 1950, "Before Present"),
         `cal BP` = era("cal BP", 1950, "Before Present"),
         # Common Era
         `BC` = era("BC", 0, "Before Christ"),
         `BCE` = era("BCE", 0, "Before Common Era"),
         `AD` = era("AD", 0, "Anno Domini", direction = "forwards"),
         `CE` = era("CE", 0, "Common Era", direction = "forwards"),
         # Uncalibrated radiocarbon years
         `uncal BP` = era("uncal BP", 1950, "uncalibrated Before Present", "radiocarbon years"),
         `bp` = era("bp", 1950, "uncalibrate Before Present", "radiocarbon years"),
         `bc` = era("bc", 1950, "uncalibrated BC"),
         # SI time scale
         `ka` = era("ka", 1950, "kiloannum", scale = 1000),
         `Ma` = era("Ma", 1950, "megaannum", scale = 1e6),
         `Ga` = era("Ga", 1950, "gigaannum", scale = 1e9),
         # Pseudo-SI (years ago) time scale
         `kya` = era("kya", 1950, "thousand years ago", scale = 1000),
         `mya` = era("mya", 1950, "million years ago", scale = 1e6),
         `bya` = era("bya", 1950, "billion years ago", scale = 1e9),
         stop("Unknown era: '", x, "'.")
  )
}

#' Is this an `era` object?
#'
#' Tests whether an object is a `era`; an calendar era definition constructed
#' by [era()].
#'
#' @param x  Object to test.
#'
#' @return
#' `TRUE` or `FALSE`.
#'
#' @export
is_era <- function(x) {
  inherits(x, "era")
}

# S3 methods --------------------------------------------------------------

#' @export
format.era <- function(x, ...) {
  nameout <- paste0(era_name(x), " (", era_abbr(x), ")")
  nameout[era_name(x) == era_abbr(x)] <- era_name(x)[era_name(x) == era_abbr(x)]

  unitout <- paste0(era_unit(x), " (\u00d7", era_scale(x), ")")
  unitout[era_scale(x) == 1] <- era_unit(x)[era_scale(x) == 1]

  out <- paste0(nameout, ": ", unitout, ", counted ", era_direction(x), " from ", era_epoch(x))

  return(out)
}

# Getters and setters -----------------------------------------------------

#' Get attributes of an era
#'
#' Extracts a specific attribute from an era object.
#'
#' @name era_attributes
#'
#' @param x An `era` object.
#'
#' @return
#' Value of the attribute.
#'
#' @details
#' The available attributes are:
#'
#' * **abbreviation** (abbr) – abbreviated name of the era, e.g. "cal BP"
#' * **epoch** – year of origin of the era, e.g. 1950 for years Before Present
#' * **name** – full name of the era, e.g. "calendar years Before Present"
#' * **unit** – unit of years used, e.g. "calendar years", "radiocarbon years"
#' * **scale** – multiple of years used, e.g. 1000 for ka/kiloannum
#' * **direction** – whether years are counted "backwards" or "forwards" from the epoch
#'
#' @examples
#' x <- era("cal BP")
#' era_name(x)
NULL

#' @rdname era_attributes
#' @export
era_abbreviation <- function(x) {
  return(field(x, "abbreviation"))
}

#' @rdname era_attributes
#' @export
era_abbr <- function(x) {
  return(era_abbreviation(x))
}

#' @rdname era_attributes
#' @export
era_epoch <- function(x) {
  return(field(x, "epoch"))
}

#' @rdname era_attributes
#' @export
era_name <- function(x) {
  return(field(x, "name"))
}

#' @rdname era_attributes
#' @export
era_unit <- function(x) {
  return(field(x, "unit"))
}

#' @rdname era_attributes
#' @export
era_scale <- function(x) {
  return(field(x, "scale"))
}

#' @rdname era_attributes
#' @export
era_direction <- function(x) {
  return(field(x, "direction"))
}
