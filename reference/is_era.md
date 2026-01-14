# Validation functions for `era` objects

Tests whether an object is an era definition (an `era` object).
`is_era()` tests whether the object inherits from the S3 class `era_yr`.
`is_valid_era()` performs additional checks to determine whether the
object is well-formed (see details). `validate_era()` throws an
informative error message for invalid `yr`s.

## Usage

``` r
is_era(x)

validate_era(x)

is_valid_era(x)
```

## Arguments

- x:

  Object to test.

## Value

`is_era()` and `is_valid_era()` return `TRUE` or `FALSE`.
`validate_era()` returns `x` invisibly, and is used for its side-effect
of throwing an informative error for invalid objects.

## Details

Valid `era` objects:

- Must have all parameters set and not NA

- Must have a character `label` parameter

- Must have a numeric `epoch` parameter

- Must have a character `name` parameter

- Must have a character `unit` parameter that is one of the defined
  units

- Must have a positive, integer `scale` parameter

- Must have a direction parameter that is -1 (backwards) or 1 (forwards)

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)
