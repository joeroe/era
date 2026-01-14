# Create an era object

An `era` object defines the time scale associated with a vector of years
(see [`yr()`](https://era.joeroe.io/reference/yr.md)). `era()` returns
an `era` object, either by looking up `label` in the standard eras
defined in [`eras()`](https://era.joeroe.io/reference/eras.md) or, if
more than one argument is given, constructing a new definition with the
specified parameters.

## Usage

``` r
era(
  label = character(),
  epoch = NULL,
  name = label,
  unit = era_year("Gregorian"),
  scale = 1,
  direction = -1
)
```

## Arguments

- label:

  Character. If only one argument is given to `era()`, the abbreviated
  label of a standard era defined in
  [`eras()`](https://era.joeroe.io/reference/eras.md). Otherwise, the
  label to give to the era constructed using the following arguments.

- epoch:

  Numeric. Epoch year from which years are counted in Gregorian
  astronomical years (i.e. there is a "year zero").

- name:

  Character. Full name of the era. Defaults to the value of `label`.

- unit:

  An [`era_year()`](https://era.joeroe.io/reference/era_year.md) object
  describing the name of the year unit and its average length in solar
  days. Defaults to a Gregorian year (365.2425 days).

- scale:

  Integer. Number of years represented by one unit, e.g. `1000` for ka.
  Default: 1.

- direction:

  Are years counted backwards (`-1`) (the default) or forwards (`1`)
  from `epoch`?

## Value

An object of class `era`.

## See also

Other era definition functions:
[`eras()`](https://era.joeroe.io/reference/eras.md)

Other era helper functions:
[`era_parameters`](https://era.joeroe.io/reference/era_parameters.md),
[`era_year`](https://era.joeroe.io/reference/era_year.md),
[`era_year_parameters`](https://era.joeroe.io/reference/era_year_parameters.md),
[`is_era()`](https://era.joeroe.io/reference/is_era.md),
[`is_era_year()`](https://era.joeroe.io/reference/is_era_year.md),
[`is_yr()`](https://era.joeroe.io/reference/is_yr.md),
[`this_year()`](https://era.joeroe.io/reference/this_year.md)

## Examples

``` r
era("cal BP")
#> <era[1]>
#> [1] Before Present (cal BP): Gregorian years (365.2425 days), counted backwards from 1950

era("T.A.", epoch = -9021, name = "Third Age", direction = 1)
#> <era[1]>
#> [1] Third Age (T.A.): Gregorian years (365.2425 days), counted forwards from -9021
```
