# Get the parameters of an `era_year` object.

Extracts a specific parameter from a year unit object constructed by
[`era_year()`](https://era.joeroe.io/reference/era_year.md).

## Usage

``` r
era_year_label(x)

era_year_days(x)
```

## Arguments

- x:

  An object of class `era_year`.

## Value

Value of the parameter.

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)

## Examples

``` r
julian <- era_year("Julian", 365.25)
era_year_label(julian)
#> [1] "Julian"
era_year_days(julian)
#> [1] 365.25
```
