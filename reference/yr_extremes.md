# Chronological minima and maxima

Returns the chronologically earliest and/or latest value in a vector of
years, i.e. era-aware version
[`min()`](https://rdrr.io/r/base/Extremes.html),
[`max()`](https://rdrr.io/r/base/Extremes.html), and
[`range()`](https://rdrr.io/r/base/range.html).

## Usage

``` r
yr_earliest(x, na.rm = FALSE)

yr_latest(x, na.rm = FALSE)

yr_range(x, na.rm = FALSE)
```

## Arguments

- x:

  A [yr](https://era.joeroe.io/reference/yr.md) vector with era

- na.rm:

  a logical indicating whether missing values should be removed

## Value

For `yr_earliest()` and `yr_leatest()`, a `yr` vector of length 1 with
the earliest or latest value.

For `yr_range()`, a `yr` vector of length 2 with the earliest and latest
value (in that order).

If `x` contains `NA` values and `na.rm = FALSE` (the default), only
`NA`s will be returned.

## Details

These are implemented as prefixed functions rather than S3
[`min()`](https://rdrr.io/r/base/Extremes.html),
[`max()`](https://rdrr.io/r/base/Extremes.html), and
[`range()`](https://rdrr.io/r/base/range.html) methods for
[yr](https://era.joeroe.io/reference/yr.md)s to avoid surprises when
numerical (i.e. not chronological) extremes are expected.

## See also

Other functions for chronological ordering and extremes:
[`yr_sort()`](https://era.joeroe.io/reference/yr_sort.md)

## Examples

``` r
# Forward-counting era:
x <- yr(c(200, 100, 300), "CE")
yr_earliest(x)
#> # CE years <yr[1]>:
#> [1] 100
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0
yr_latest(x)
#> # CE years <yr[1]>:
#> [1] 300
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0
yr_range(x)
#> # CE years <yr[2]>:
#> [1] 100 300
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0

# Backward-counting era:
y <- yr(c(200, 100, 300), "BCE")
yr_earliest(y)
#> # BCE years <yr[1]>:
#> [1] 300
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
yr_latest(y)
#> # BCE years <yr[1]>:
#> [1] 100
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
yr_range(x)
#> # CE years <yr[2]>:
#> [1] 100 300
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0
```
