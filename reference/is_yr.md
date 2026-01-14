# Validation functions for `yr` objects

Tests whether an object is a vector of years with an era (a `yr`
object). `is_yr()` tests whether the object inherits from the S3 class
`era_yr`. `is_valid_yr()` performs additional checks to determine
whether the object is well-formed (see details). `validate_yr()` throws
an informative error message for invalid `yr`s.

## Usage

``` r
is_yr(x)

validate_yr(x)

is_valid_yr(x)
```

## Arguments

- x:

  Object to test.

## Value

`is_yr()` and `is_valid_yr()` return `TRUE` or `FALSE`. `validate_yr()`
returns `x` invisibly, and is used for its side-effect of throwing an
informative error for invalid objects.

## Details

Valid `yr` objects:

- Must contain numeric data (NAs are allowed)

- Must have the `era` attribute set and not NA

- Must not have more than one era

- Must have an `era` attribute that is a valid era object (see
  [`validate_era()`](https://era.joeroe.io/reference/is_era.md))

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)

## Examples

``` r
x <- yr(5000:5050, era("cal BP"))
is_yr(x)
#> [1] TRUE
is_valid_yr(x)
#> [1] TRUE
validate_yr(x)
```
