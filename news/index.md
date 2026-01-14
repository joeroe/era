# Changelog

## era (development version)

- Added `CITATION.cff` file with software citation metadata
  ([\#49](https://github.com/joeroe/era/issues/49))

## era 0.5.0

CRAN release: 2024-11-20

- New [`yr_sort()`](https://era.joeroe.io/reference/yr_sort.md) function
  for chronological ordering of year vectors
  ([\#44](https://github.com/joeroe/era/issues/44))
- New [`yr_earliest()`](https://era.joeroe.io/reference/yr_extremes.md),
  [`yr_latest()`](https://era.joeroe.io/reference/yr_extremes.md), and
  [`yr_range()`](https://era.joeroe.io/reference/yr_extremes.md)
  functions for chronological extremes of year vectors
  ([\#43](https://github.com/joeroe/era/issues/43))

## era 0.4.1

CRAN release: 2022-11-17

This patch fixes a malfunctioning test that was causing CRAN checks to
fail. There are no significant changes.

- Fixed malfunctioning check

## era 0.4.0

CRAN release: 2022-03-09

- New eras:
  - Anno Mundi (Hebrew calendar)
- New year units:
  - Sidereal, tropical, and anomalistic astronomic years
    [\#15](https://github.com/joeroe/era/issues/15)
  - Hebrew lunisolar years
- Changes to existing eras:
  - More precise epoch value for Hijri eras: `621.5394` instead of
    `622`.
  - More precise epoch value for Nowruz (Solar Hijri) eras: `621.2218`
    instead of `622`.
- Fixed recurring issues related to the absence of a year 0 in BCE/CE
  [\#4](https://github.com/joeroe/era/issues/4)
- [`this_year()`](https://era.joeroe.io/reference/this_year.md) now
  considers the current date, returns a floored integer (i.e. the actual
  current calendar year), and is vectorised over `era`.
- Added pillar printing methods for `era`
  ([\#33](https://github.com/joeroe/era/issues/33)) and `era_year`
  ([\#34](https://github.com/joeroe/era/issues/34)) in tibbles
- Class constructors [`era()`](https://era.joeroe.io/reference/era.md)
  and [`yr()`](https://era.joeroe.io/reference/yr.md) now return a
  zero-length vector when called with no arguments (instead of an
  error), allowing them to be used as
  [prototypes](https://vctrs.r-lib.org/articles/type-size.html)
- `era_yr` objects can now be cast to character vectors
  (e.g. `as.character(yr(1, "BP"))`)
- Combining otherwise equivalent eras with different names or labels
  with [`c()`](https://rdrr.io/r/base/c.html) now triggers a warning
  ([\#27](https://github.com/joeroe/era/issues/27)), consistent with
  combining them using arithmetic
  ([\#3](https://github.com/joeroe/era/issues/3))
- The `era` package no longer exports `magrittr`’s pipe operator (`%>%`)

## era 0.3.1

CRAN release: 2021-01-29

CRAN release.

- Fixed moved link in README

## era 0.3.0

Second beta / CRAN pre-release.

- Added new era definitions:
  - Islamic calendars (Lunar Hijri, Solar Hijri).
  - Julian calendar
- Reworked era definition scheme:
  - Unit is now represented by the `era_year` class, which describes its
    length in solar days as well as its name. Added functions for
    constructing and working with `era_year` objects:
    [`era_year()`](https://era.joeroe.io/reference/era_year.md),
    [`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
    [`era_year_label()`](https://era.joeroe.io/reference/era_year_parameters.md),
    [`era_year_days()`](https://era.joeroe.io/reference/era_year_parameters.md).
  - Direction is now coded as `1` (“forwards”) or `-1` (“backwards”).
    The previous character arguments still work but are deprecated.
  - Equality tests for eras now only check significant parameters
    (i.e. not “label” or “name”), allowing for coercion between
    functionally equivalent eras, e.g. `yr(1, "BP") + yr(1, "cal BP")`
    now works (with a warning)
    ([\#3](https://github.com/joeroe/era/issues/3)).
- Improved
  [`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md):
  - Can now convert between eras with different year units
    ([\#25](https://github.com/joeroe/era/issues/25)).
  - Now has a `precision` argument, allowing the result to be rounded
    ([\#23](https://github.com/joeroe/era/issues/23)).
- `era` and `yr` objects are now validated when constructed, using new
  functions
  [`validate_era()`](https://era.joeroe.io/reference/is_era.md)/[`is_valid_era()`](https://era.joeroe.io/reference/is_era.md)
  and
  [`validate_yr()`](https://era.joeroe.io/reference/is_yr.md)/[`is_valid_yr()`](https://era.joeroe.io/reference/is_yr.md)
  ([\#7](https://github.com/joeroe/era/issues/7) and
  [\#8](https://github.com/joeroe/era/issues/8)).
- Minor changes/bug fixes:
  - Added [`this_year()`](https://era.joeroe.io/reference/this_year.md),
    which returns the current year as a `yr` object.
  - `era(NA)` now returns an error, not a vector of all standard eras
    ([\#20](https://github.com/joeroe/era/issues/20)).
  - All `era` arguments in functions can now accept a character vector
    ([\#20](https://github.com/joeroe/era/issues/20))
  - `era(<era>)` now returns an era with the same parameters (to enable
    the above)
  - Various additions to make the [coercion
    hierarchy](https://vctrs.r-lib.org/reference/theory-faq-coercion.html)
    for era_yrs more consistent; most notably, the common prototype of
    era_yr, integer, and double, is now era_yr.
  - Fixed printing of NA eras
    ([\#9](https://github.com/joeroe/era/issues/9))
  - Errors now use the rlang format and are in general more informative
    ([\#26](https://github.com/joeroe/era/issues/26) and
    [\#28](https://github.com/joeroe/era/issues/28))

## era 0.2.0

First beta release, including:

- S3 vector class `yr` (`era_yr`) representing years with an era
  - [`yr()`](https://era.joeroe.io/reference/yr.md) constructor
  - Functions for getting and setting the era of a `yr` object:
    [`yr_era()`](https://era.joeroe.io/reference/yr_era.md),
    `yr_era()<-` and
    [`yr_set_era()`](https://era.joeroe.io/reference/yr_era.md)
  - Format and print methods for `yr`s
  - Vector arithmetic methods for `yr`s
- S3 record class `era` representing an era definition
  - [`era()`](https://era.joeroe.io/reference/era.md) constructor
  - Format and print methods for `era`s
  - Getter functions for era parameters:
    [`era_label()`](https://era.joeroe.io/reference/era_parameters.md),
    [`era_name()`](https://era.joeroe.io/reference/era_parameters.md),
    [`era_epoch()`](https://era.joeroe.io/reference/era_parameters.md),
    [`era_unit()`](https://era.joeroe.io/reference/era_parameters.md),
    [`era_scale()`](https://era.joeroe.io/reference/era_parameters.md),
    [`era_direction()`](https://era.joeroe.io/reference/era_parameters.md)
  - [`eras()`](https://era.joeroe.io/reference/eras.md) defining
    standard eras
- [`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md)
  function for converting years between eras
- Function documentation and introductory vignette:
  [`vignette("era")`](https://era.joeroe.io/articles/era.md)
- A `NEWS.md` file to track changes to the package.

## era 0.1.0

Initial development version.
