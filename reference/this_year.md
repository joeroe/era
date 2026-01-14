# Current year

Returns the current year as a year vector, in the era system specified
by `era`.

## Usage

``` r
this_year(era = "CE")
```

## Arguments

- era:

  An `era` object or label understood by
  [`era()`](https://era.joeroe.io/reference/era.md). Defaults to the
  Common Era (`era("CE")`).

## Value

A `yr` vector with the current year.

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md)

## Examples

``` r
# This year in the Common Era
this_year()
#> # CE years <yr[1]>:
#> [1] 2026
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0
# This year in the Holocene Epoch
this_year("HE")
#> # HE years <yr[1]>:
#> [1] 12026
#> # Era: Holocene Era (HE): Gregorian years (365.2425 days), counted forwards from -10000
```
