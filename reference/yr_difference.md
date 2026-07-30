# Chronological difference between year vectors

`yr_difference(x, y)` calculates how much later `x` is than `y`, taking
into

## Usage

``` r
yr_difference(x, y)
```

## Arguments

- x:

  A [yr](https://era.joeroe.io/reference/yr.md) vector with era.

- y:

  A [yr](https://era.joeroe.io/reference/yr.md) vector or numeric value.
  If `yr`, and in a different era than `x`, it is transformed to the era
  of `x`. Recycled to the common length of `x` and `y`.

## Value

Numeric vector of signed differences. Positive values indicate `x` is
chronologically later than `y`; negative values indicate `x` is earlier.

## Details

This function performs chronological subtraction, not numeric
subtraction. Both inputs are converted to a common chronological scale
(accounting for era direction and epoch), and the difference is computed
as `x - y` on that scale.

For forward-counting eras (e.g. CE), this is equivalent to numeric
subtraction. For backward-counting eras (e.g. BCE, BP), the era
direction is accounted for, so
`yr_difference(yr(1900, "BCE"), yr(2000, "BCE"))` returns 100 (1900 BCE
is 100 years later than 2000 BCE), even though 1900 - 2000 = -100.

## See also

Other functions for chronological ordering and extremes:
[`yr_earlier_than()`](https://era.joeroe.io/reference/yr_earlier_than.md),
[`yr_extremes`](https://era.joeroe.io/reference/yr_extremes.md),
[`yr_sort()`](https://era.joeroe.io/reference/yr_sort.md)

## Examples

``` r
# Forward-counting era (CE):
yr_difference(yr(200, "CE"), yr(100, "CE"))  # 100
#> [1] 100
yr_difference(yr(100, "CE"), yr(200, "CE"))  # -100
#> [1] -100

# Backward-counting era (BCE):
yr_difference(yr(1900, "BCE"), yr(2000, "BCE"))  # 100
#> [1] 100
yr_difference(yr(2000, "BCE"), yr(1900, "BCE"))  # -100
#> [1] -100

# Cross-era (accounts for year zero):
yr_difference(yr(10, "CE"), yr(10, "BCE"))  # 19
#> [1] 19

# Scaled eras (returns difference in era's native units):
yr_difference(yr(2, "ka"), yr(1, "ka"))  # 1
#> [1] -1
```
