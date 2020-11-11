
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/joeroe/era/workflows/R-CMD-check/badge.svg)](https://github.com/joeroe/era/actions)
[![Codecov test
coverage](https://codecov.io/gh/joeroe/era/branch/master/graph/badge.svg)](https://codecov.io/gh/joeroe/era?branch=master)
<!-- badges: end -->

**era** is an R package that provides a consistent vector representation
of years with an associated calendar era or time scale. It includes
built-in definitions of many contemporary and historic calendars; time
scales commonly used in archaeology, astronomy, geology, and other
palaeosciences (e.g. Before Present, SI-prefixed *annus*); and support
for arbitrary user-defined eras. Functions for converting between eras
and for type-stable arithmetic with years are also provided.

## Installation

You can install the development version of era from GitHub with the
[remotes](https://remotes.r-lib.org/) package.

``` r
# install.packages("remotes")
remotes::install_github("joeroe/era")
```

## Usage

`yr()` constructs an vector representing years with an associated era.

``` r
library(era)
yr(10010:10001, "cal BP")
#> # cal BP years <yr[10]>:
#>  [1] 10010 10009 10008 10007 10006 10005 10004 10003 10002 10001
#> # Era: Before Present (cal BP): calendar years, counted backwards from 1950
```

The time scale used by a `yr` vector is defined by a call to `era()`.
Many common era systems are built into the package and can be used by
simply passing a string to `era()` or `yr()`. Use `yr_transform()` to
convert between eras.

``` r
x <- yr(10010:10001, "cal BP")
yr_transform(x, era("BCE"))
#> # BCE years <yr[10]>:
#>  [1] 8060 8059 8058 8057 8056 8055 8054 8053 8052 8051
#> # Era: Before Common Era (BCE): calendar years, counted backwards from 0
```

Arbitrary user-defined eras are also supported.

``` r
era("T.A.", epoch = -9021, name = "Third Age", direction = "forwards")
#> <era[1]>
#> [1] Third Age (T.A.): calendar years, counted forwards from -9021
```

era is based on [vctrs](https://vctrs.r-lib.org/), which means years fit
nicely into both data frames and tibbles.

``` r
library("tibble")
tibble(bp_year = yr(c(15000, 14000, 13000, 12000, 11000), "cal BP"),
       bce_year = yr_transform(bp_year, era("BCE")))
#> # A tibble: 5 x 2
#>   bp_year bce_year
#>      <yr>     <yr>
#> 1   15000    13050
#> 2   14000    12050
#> 3   13000    11050
#> 4   12000    10050
#> 5   11000     9050
```

It also ensures type- and size-stable computations. For example, you can
perform arithmetic with years:

``` r
a <- yr(1500, "CE")
b <- yr(2020, "CE")
b - a
#> # CE years <yr[1]>:
#> [1] 520
#> # Era: Common Era (CE): calendar years, counted forwards from 0
```

But only when they have the same era:

``` r
c <- yr(0.5, "ka")
b - c
#> Error: <yr (CE)> - <yr (ka)> is not permitted
#> Reconcile eras with yr_transform() first.
```

And years will be coerced to a plain numeric vector if a computation
means their era attribute is no longer accurate:

``` r
a * b
#> [1] 3030000
```
