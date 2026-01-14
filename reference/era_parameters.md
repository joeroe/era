# Get parameters of an era

Extracts a specific parameter from an era object.

## Usage

``` r
era_label(x)

era_epoch(x)

era_name(x)

era_unit(x)

era_scale(x)

era_direction(x)
```

## Arguments

- x:

  An `era` object.

## Value

Value of the parameter.

## Details

The available parameters are:

- **label** – unique, abbreviated label of the era, e.g. "cal BP"

- **epoch** – year of origin of the era, e.g. 1950 for Before Present

- **name** – full name of the era, e.g. "calendar years Before Present"

- **unit** – unit of years used, an
  [`era_year()`](https://era.joeroe.io/reference/era_year.md) object

- **scale** – multiple of years used, e.g. 1000 for ka/kiloannum

- **direction** – whether years are counted "backwards" or "forwards"
  from the epoch \#'

## See also

Other era helper functions:
[`era`](https://era.joeroe.io/reference/era.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)

## Examples

``` r
x <- era("cal BP")
era_name(x)
#> [1] "Before Present"
```
