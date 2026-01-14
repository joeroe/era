# Validation functions for `era_year` objects

Tests whether an object is of class `era_year` (constructed by
[`era_year()`](https://era.joeroe.io/reference/era_year.md)).

## Usage

``` r
is_era_year(x)
```

## Arguments

- x:

  Object to test.

## Value

`TRUE` or `FALSE`.

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)

## Examples

``` r
is_era_year(era_year("Julian", 365.25))
#> [1] TRUE
```
