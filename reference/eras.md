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
[`era()`](https://era.joeroe.io/reference/era.md)

## Examples

``` r
# List all available eras
print(eras(), n = Inf)
#> # A tibble: 33 × 6
#>    label      epoch name                                    unit scale direction
#>    <chr>      <dbl> <chr>                             <era_year> <int>     <dbl>
#>  1 BP         1950  Before Present                     Gregorian   1e0        -1
#>  2 cal BP     1950  Before Present                     Gregorian   1e0        -1
#>  3 BC            1  Before Christ                      Gregorian   1e0        -1
#>  4 BCE           1  Before Common Era                  Gregorian   1e0        -1
#>  5 AD            0  Anno Domini                        Gregorian   1e0         1
#>  6 CE            0  Common Era                         Gregorian   1e0         1
#>  7 a          1950  annum                              Gregorian   1e0        -1
#>  8 ka         1950  kiloannum                          Gregorian   1e3        -1
#>  9 Ma         1950  megaannum                          Gregorian   1e6        -1
#> 10 Ga         1950  gigaannum                          Gregorian   1e9        -1
#> 11 kya        1950  thousand years ago                 Gregorian   1e3        -1
#> 12 mya        1950  million years ago                  Gregorian   1e6        -1
#> 13 bya        1950  billion years ago                  Gregorian   1e9        -1
#> 14 b2k        2000  years before 2000                  Gregorian   1e0        -1
#> 15 uncal BP   1950  uncalibrated Before Present      radiocarbon   1e0        -1
#> 16 RCYBP      1950  Radiocarbon Years Before P…      radiocarbon   1e0        -1
#> 17 bp         1950  Before Present (uncalibrat…      radiocarbon   1e0        -1
#> 18 bc         1950  Before Christ (uncalibrate…      radiocarbon   1e0        -1
#> 19 bce        1950  Before Common Era (uncalib…      radiocarbon   1e0        -1
#> 20 ad         1950  Anno Domini (uncalibrated)       radiocarbon   1e0         1
#> 21 ce         1950  Common Era (uncalibrated)        radiocarbon   1e0         1
#> 22 AD O.S.       0  Anno Domini (Old Style)               Julian   1e0         1
#> 23 BC O.S.       1  Before Christ (New Style)             Julian   1e0         1
#> 24 H           622. Hijra                          Islamic lunar   1e0         1
#> 25 AH          622. Anno Hegirae                   Islamic lunar   1e0         1
#> 26 BH          623. Before the Hijra               Islamic lunar   1e0        -1
#> 27 SH          621. Solar Hijri                           Nowruz   1e0         1
#> 28 BSH         622. Before Solar Hijri                    Nowruz   1e0        -1
#> 29 AM        -3760. Anno Mundi                  Hebrew lunisolar   1e0         1
#> 30 HE       -10000  Holocene Era                       Gregorian   1e0         1
#> 31 BHE      -10000  Before Holocene Era                Gregorian   1e0        -1
#> 32 AL        -4000  Anno Lucis                         Gregorian   1e0         1
#> 33 ADA       -8000  After the Development of A…        Gregorian   1e0         1

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
