# Get or set the era of a vector of years

Functions for extracting or assigning the era of a vector of years. This
function does not alter the underlying values of `x`. Use
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md) to
*convert* the values of a `yr` vector to a new era.

## Usage

``` r
yr_era(x)

yr_set_era(x, era)

yr_era(x) <- value
```

## Arguments

- x:

  A vector of years.

- value, era:

  An `era` object (see
  [`era()`](https://era.joeroe.io/reference/era.md)) to be assigned to
  `x`.

## Value

`yr_era(x)` returns the existing era associated with `x`.

`yr_set_era(x, era)` and `yr_era(x) <- era` return `x` with the new era
assigned. If `x` is not already a `yr` vector, it will attempt to coerce
it into one.

## See also

Other years with era functions:
[`yr()`](https://era.joeroe.io/reference/yr.md),
[`yr_transform()`](https://era.joeroe.io/reference/yr_transform.md)

## Examples

``` r
x <- 5000:5050
yr_era(x) <- era("cal BP")
yr_era(x)
#> <era[1]>
#> [1] Before Present (cal BP): Gregorian years (365.2425 days), counted backwards from 1950
```
