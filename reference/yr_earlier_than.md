# Chronological comparison of years

Tests whether years are chronologically earlier or later than each
other, accounting for era direction.

## Usage

``` r
yr_earlier_than(x, y)

yr_later_than(x, y)

yr_not_earlier_than(x, y)

yr_not_later_than(x, y)
```

## Arguments

- x, y:

  [yr](https://era.joeroe.io/reference/yr.md) vectors with era. If in
  different eras, `y` is transformed to the era of `x`. Recycled to
  their common length.

## Value

A logical vector.

## Details

For forward-counting eras (e.g. CE), `yr_earlier_than(x, y)` is
equivalent to `x < y` and `yr_later_than(x, y)` is equivalent to
`x > y`. For backward-counting eras (e.g. BP, BCE), the comparisons are
reversed.

`yr_not_earlier_than()` and `yr_not_later_than()` are the negations of
`yr_earlier_than()` and `yr_later_than()`, equivalent to `>=` and `<=`
respectively for forward-counting eras.

These are implemented as functions rather than S3 methods for `<`, `>`,
`<=`, and `>=` to avoid surprises when numerical (i.e. not
chronological) comparison is expected.

## See also

Other functions for chronological ordering and extremes:
[`yr_extremes`](https://era.joeroe.io/reference/yr_extremes.md),
[`yr_sort()`](https://era.joeroe.io/reference/yr_sort.md)

## Examples

``` r
# Forward-counting era:
x <- yr(c(100, 200, 300), "CE")
yr_earlier_than(x, yr(200, "CE"))
#> [1]  TRUE FALSE FALSE
yr_later_than(x, yr(200, "CE"))
#> [1] FALSE FALSE  TRUE
yr_not_earlier_than(x, yr(200, "CE"))
#> [1] FALSE  TRUE  TRUE
yr_not_later_than(x, yr(200, "CE"))
#> [1]  TRUE  TRUE FALSE

# Backward-counting era:
y <- yr(c(100, 200, 300), "BCE")
yr_earlier_than(y, yr(200, "BCE"))
#> [1] FALSE FALSE  TRUE
yr_later_than(y, yr(200, "BCE"))
#> [1]  TRUE FALSE FALSE
yr_not_earlier_than(y, yr(200, "BCE"))
#> [1]  TRUE  TRUE FALSE
yr_not_later_than(y, yr(200, "BCE"))
#> [1] FALSE  TRUE  TRUE
```
