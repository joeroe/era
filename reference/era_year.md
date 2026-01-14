# Year units

`era_year` objects describe the unit used for a year as its length in
days. This value is used in an era definition
([`era()`](https://era.joeroe.io/reference/era.md)) to enable
conversions between eras that use different units (with
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md)).

## Usage

``` r
era_year(label = character(), days = 365.2425)
```

## Arguments

- label:

  Character. Name of the year unit.

- days:

  Numeric. Average length of the year in solar days. Defaults to a
  Gregorian year (365.2425 days).

## Value

S3 vector of class `era_year`.

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)

## Examples

``` r
era_year("Julian", 365.25)
#> <era_year[1]>
#> [1] Julian years (365.25 days)
```
