
<!-- README.md is generated from README.Rmd. Please edit that file -->

# era <a href='https://era.joeroe.io'><img src='man/figures/logo.svg' align="right" height="139" /></a>

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
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

## Basic usage

`yr()` defines the era associated with a vector of years:

``` r
library(era)
x <- yr(c(9000, 8000, 7000), "cal BP")
x
#> # cal BP years <yr[3]>:
#> [1] 9000 8000 7000
#> # Era: Before Present (cal BP): Gregorian years (365.2425 days), counted backwards from 1950
```

Use `yr_transform()` to convert between eras:

``` r
yr_transform(x, "BCE")
#> # BCE years <yr[3]>:
#> [1] 7050 6050 5050
#> # Era: Before Common Era (BCE): Gregorian years (365.2425 days), counted backwards from 0
```

Many common calendar systems and time scales are predefined (see
`?eras()`) and can be referenced by their abbreviated labels. Other eras
can be defined using the `era()` function directly.

For further usage, see the [package
introduction](https://era.joeroe.io/articles/era.html)
(`vignette("era")`).
