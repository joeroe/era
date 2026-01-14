# Chronological ordering of year vectors

Sorts a vector of years into earliest-to-latest or latest-to-earliest
chronological order based on its era.

## Usage

``` r
yr_sort(x, reverse = FALSE, ...)
```

## Arguments

- x:

  [yr](https://era.joeroe.io/reference/yr.md) vector with era

- reverse:

  Set `FALSE` (the default) for chronological order (earliest to latest)
  or `TRUE` for reverse chronological order (latest to earliest).

- ...:

  Other arguments passed to
  [`sort()`](https://rdrr.io/r/base/sort.html); in particular use
  `na.last` to control NA handling.

## Value

Sorted [yr](https://era.joeroe.io/reference/yr.md) vector

## Details

This is implemented as a prefixed function rather than an S3
[`sort()`](https://rdrr.io/r/base/sort.html) method for
[yr](https://era.joeroe.io/reference/yr.md)s to avoid surprises when
numerical (i.e. not chronological) sorting is expected.

## See also

Other functions for chronological ordering and extremes:
[`yr_extremes`](https://era.joeroe.io/reference/yr_extremes.md)

## Examples

``` r
# Forward-counting era:
x <- yr(c(200, 100, 300), "CE")
yr_sort(x)
#> # CE years <yr[3]>:
#> [1] 100 200 300
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0
yr_sort(x, reverse = TRUE)
#> # CE years <yr[3]>:
#> [1] 300 200 100
#> # Era: Common Era (CE): Gregorian years (365.2425 days), counted forwards from 0

# Backward-counting era:
y <- yr(c(200, 100, 300), "BCE")
yr_sort(y)
#> # BCE years <yr[3]>:
#> [1] 300 200 100
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
yr_sort(y, reverse = TRUE)
#> # BCE years <yr[3]>:
#> [1] 100 200 300
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 1
```
