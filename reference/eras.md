# Standard era definitions

Definitions of common eras and time scales.

`eras()` lists all available era definitions. `eras(label)` looks up a
specific era by its unique, abbreviated name (e.g. "cal BP").

## Usage

``` r
eras(label = NA)
```

## Arguments

- label:

  (Optional) Abbreviated names(s) of eras to look up.

## Value

A table of era definitions. This can be passed to
[`era()`](https://era.joeroe.io/reference/era.md) to construct an `era`
object.

## Details

Looking up eras by `label` uses partial matching.

## See also

Other era definition functions:
[`era`](https://era.joeroe.io/reference/era.md)

## Examples

``` r
# List all available eras
eras()
#> # A tibble: 33 × 6
#>    label  epoch name                    unit      scale direction
#>    <chr>  <dbl> <chr>             <era_year>      <int>     <dbl>
#>  1 BP      1950 Before Present     Gregorian          1        -1
#>  2 cal BP  1950 Before Present     Gregorian          1        -1
#>  3 BC         1 Before Christ      Gregorian          1        -1
#>  4 BCE        1 Before Common Era  Gregorian          1        -1
#>  5 AD         0 Anno Domini        Gregorian          1         1
#>  6 CE         0 Common Era         Gregorian          1         1
#>  7 a       1950 annum              Gregorian          1        -1
#>  8 ka      1950 kiloannum          Gregorian       1000        -1
#>  9 Ma      1950 megaannum          Gregorian    1000000        -1
#> 10 Ga      1950 gigaannum          Gregorian 1000000000        -1
#> # ℹ 23 more rows

# Look up a specific era by label
eras("cal BP")
#> # A tibble: 1 × 6
#>   label  epoch name                 unit scale direction
#>   <chr>  <dbl> <chr>          <era_year> <int>     <dbl>
#> 1 cal BP  1950 Before Present  Gregorian     1        -1

# With partial matching
eras("cal")
#> # A tibble: 1 × 6
#>   label  epoch name                 unit scale direction
#>   <chr>  <dbl> <chr>          <era_year> <int>     <dbl>
#> 1 cal BP  1950 Before Present  Gregorian     1        -1
```
