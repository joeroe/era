# Convert years from one era to another

Transform a vector of years from one era to another.

## Usage

``` r
yr_transform(x, era = yr_era(x), precision = NA)
```

## Arguments

- x:

  `yr` object. A vector of years with an era, see
  [`yr()`](https://era.joeroe.io/reference/yr.md).

- era:

  `era` object describing the target era, see
  [`era()`](https://era.joeroe.io/reference/era.md).

- precision:

  Desired precision of the transformation, i.e. the transformed values
  are rounded to the nearest `precision`. If `NA` (the default), no
  rounding is performed and the exact transformed value is returned.

## Value

A `yr` object in the era specified by `era`.

## Details

Transformation between eras uses the `scale`, `epoch`, `direction` and
`unit` parameters of the era definition. `NA` values for any of these
parameters in the source or destination era will cause an error. This is
most often encountered when either are measured in 'radiocarbon years',
which cannot be related to a calendar time scale without
[calibration](https://en.wikipedia.org/wiki/Radiocarbon_calibration) or
un-calibration.

The transformation function is exact and treats years as a real number
scale. This means that transformations between eras with different year
units (e.g. Gregorian to Julian) and/or epochs not aligned to 1 January
in the Gregorian calendar (e.g. Common Era to Islamic calendars) will
likely return non-integer values. The `precision` argument provides a
convenient way to round the result if you do not need this level of
precision. It is also useful for working around the ambiguous definition
of 'present' in various geological time-scales.

## See also

Other years with era functions:
[`yr()`](https://era.joeroe.io/reference/yr.md),
[`yr_era()`](https://era.joeroe.io/reference/yr_era.md)

## Examples

``` r
x <- yr(10010:10001, "cal BP")
yr_transform(x, era("BCE"))
#> # BCE years <yr[10]>:
#>  [1] 8061 8060 8059 8058 8057 8056 8055 8054 8053 8052
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1

yr_transform(x, era("ka"), precision = 1)
#> # ka years <yr[10]>:
#>  [1] 10 10 10 10 10 10 10 10 10 10
#> # Era: kiloannum (ka): 1000 Gregorian years (365.2425 days), counted backwards from 1950
```
